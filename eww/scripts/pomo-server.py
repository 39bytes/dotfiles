#!/usr/bin/python3

import os
import errno
import queue
import threading
import json
import subprocess
from typing import Any
from enum import StrEnum, auto

POMO_PIPE = "pomo_pipe"


class PauseState(StrEnum):
    PAUSED = auto()
    RUNNING = auto()
    NOT_STARTED = auto()


class TimerKind(StrEnum):
    FOCUS = auto()
    BREAK = auto()


class State:
    focus_mins: int
    break_mins: int
    remaining: int
    pause_state: PauseState
    timer_kind: TimerKind

    timer_thread: threading.Thread
    stop_queue: queue.Queue[None]

    def __init__(self):
        self.focus_mins = 25
        self.break_mins = 5
        self.remaining = self.focus_mins * 60
        self.pause_state = PauseState.NOT_STARTED
        self.timer_kind = TimerKind.FOCUS

        self.timer_thread = threading.Thread(target=self.tick)
        self.stop_queue = queue.Queue()

    def tick(self):
        while self.remaining > 0:
            self.output()
            try:
                self.stop_queue.get(block=True, timeout=1)
                return
            except queue.Empty:
                self.remaining -= 1

        self.pause_state = PauseState.NOT_STARTED
        if self.timer_kind == TimerKind.FOCUS:
            self.timer_kind = TimerKind.BREAK
            _ = subprocess.run(["notify-send", "Focus Over", "Time to take a break!"])
        else:
            self.timer_kind = TimerKind.FOCUS
            _ = subprocess.run(["notify-send", "Break Over", "Back to work!"])
        self.reset_timer()
        self.output()

    def start(self):
        self.pause_state = PauseState.RUNNING
        self.timer_thread = threading.Thread(target=self.tick)
        self.timer_thread.start()

    def pause(self):
        self.stop_queue.put(None)
        self.pause_state = PauseState.PAUSED

    def cancel(self):
        self.pause_state = PauseState.NOT_STARTED
        self.timer_kind = TimerKind.FOCUS
        self.reset_timer()

    def reset_timer(self):
        self.remaining = self.timer_len()

    def timer_len(self):
        match self.timer_kind:
            case TimerKind.FOCUS:
                return self.focus_mins * 60
            case TimerKind.BREAK:
                return self.break_mins * 60

    def output(self):
        print(
            json.dumps(
                {
                    "focus_mins": self.focus_mins,
                    "break_mins": self.break_mins,
                    "timer": format_time(self.remaining),
                    "percentage": self.remaining / self.timer_len() * 100,
                    "pause_state": self.pause_state.value,
                    "timer_kind": self.timer_kind.value,
                }
            ),
            flush=True,
        )


def format_time(seconds: int):
    mins = seconds // 60
    secs = str(seconds % 60).rjust(2, "0")
    return f"{mins}:{secs}"


def init_pipe():
    try:
        os.mkfifo(POMO_PIPE)
    except OSError as e:
        if e.errno != errno.EEXIST:
            raise


def msg_handler(state: State, msg: dict[str, Any]):
    match msg["type"]:
        case "update":
            focus_mins = msg.get("focus_mins")
            break_mins = msg.get("break_mins")

            if focus_mins is not None:
                state.focus_mins = focus_mins
            if break_mins is not None:
                state.break_mins = break_mins

            if state.pause_state == PauseState.NOT_STARTED:
                state.reset_timer()
            state.output()
        case "start":
            state.start()
        case "pause":
            state.pause()
            state.output()
        case "cancel":
            if state.pause_state != PauseState.PAUSED:
                return
            state.cancel()
            state.output()
        case _:
            raise Exception("Failed")


def main():
    init_pipe()
    state = State()
    state.output()

    while True:
        with open(POMO_PIPE) as fifo:
            for line in fifo:
                msg_handler(state, json.loads(line.strip()))


if __name__ == "__main__":
    main()
