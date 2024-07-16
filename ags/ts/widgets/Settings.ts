import icons from "ts/icons";
import VolumeIndicator from "./Audio";
import brightness from "ts/services/brightness";
import { Media } from "./Player";

const audio = await Service.import("audio");

export const SETTINGS_WINDOW_NAME = "settings";

const VolumeSlider = () =>
  Widget.Box({
    className: "audio-slider",
    children: [
      VolumeIndicator(),
      Widget.Slider({
        css: "margin-left: 2pt;",
        hexpand: true,

        min: 0,
        max: 1,
        drawValue: false,
        value: audio.speaker.bind("volume"),
        onChange: ({ value, dragging }) => {
          if (dragging) {
            audio.speaker.volume = value;
            audio.speaker.is_muted = false;
          }
        },
      }),
    ],
  });

const BrightnessSlider = () =>
  Widget.Box({
    className: "brightness-slider",
    children: [
      Widget.Icon({ icon: "display-brightness-symbolic" }),
      Widget.Slider({
        css: "margin-left: 2pt;",
        hexpand: true,

        min: 0,
        max: 1,
        drawValue: false,
        value: brightness.bind("screen"),
        onChange: ({ value, dragging }) => {
          if (dragging) {
            brightness.screen = value;
          }
        },
      }),
    ],
  });

type PowerButtonProps = {
  className: string;
  icon: string;
  action: string;
};

const PowerButton = ({ className, icon, action }: PowerButtonProps) =>
  Widget.Button({
    className: `power-button ${className}`,
    child: Widget.Icon({
      icon,
      cursor: "pointer",
    }),
    cursor: "pointer",
    onClicked: () => {
      App.closeWindow(SETTINGS_WINDOW_NAME);
      Utils.execAsync(action);
    },
  });

const PowerButtons = () =>
  Widget.Box({
    spacing: 8,
    hpack: "end",
    children: [
      PowerButton({
        icon: icons.powermenu.sleep,
        className: "sleep",
        action: "systemctl suspend",
      }),
      PowerButton({
        icon: icons.powermenu.reboot,
        className: "reboot",
        action: "reboot",
      }),
      PowerButton({
        icon: icons.powermenu.shutdown,
        className: "shutdown",
        action: "systemctl poweroff",
      }),
    ],
  });

export const Settings = () =>
  Widget.Window({
    name: SETTINGS_WINDOW_NAME,
    child: Widget.Box({
      className: "settings",
      vertical: true,
      spacing: 16,
      children: [PowerButtons(), VolumeSlider(), BrightnessSlider(), Media()],
    }),
    visible: false,
    keymode: "on-demand",
    anchor: ["top", "right"],
    setup: (w) => {
      w.keybind("Escape", () => App.closeWindow(SETTINGS_WINDOW_NAME));
    },
  });
