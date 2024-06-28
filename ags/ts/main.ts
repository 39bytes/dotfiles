import { TrayItem } from "types/service/systemtray";

const battery = await Service.import("battery");
const hyprland = await Service.import("hyprland");
const audio = await Service.import("audio");
const systemtray = await Service.import("systemtray");

const date = Variable("", {
  poll: [1000, "date +%R"],
});

const BatteryIndicator = () =>
  Widget.Box({
    children: [
      Widget.Icon({
        className: "battery",
        icon: battery.bind("icon_name"),
        tooltipText: battery.bind("percent").as((p) => `${p}%`),
      }),
      // Widget.Label({
      //   className: "battery",
      //   label: battery.bind("percent").as((p) => `${p}%`),
      // }),
    ],
  });

const Clock = () => Widget.Label({ className: "clock", label: date.bind() });

const VolumeIndicator = () =>
  Widget.Box({
    className: "audio",
    spacing: 2,
    children: [
      Widget.Button({
        on_clicked: () => (audio.speaker.is_muted = !audio.speaker.is_muted),
        child: Widget.Icon().hook(audio.speaker, (self) => {
          const vol = audio.speaker.volume * 100;
          const thresholds: [number, string][] = [
            [101, "overamplified"],
            [67, "high"],
            [34, "medium"],
            [1, "low"],
            [0, "muted"],
          ];
          const icon = audio.speaker.is_muted
            ? "muted"
            : thresholds.find(([t]) => t <= vol)?.[1];

          self.icon = `audio-volume-${icon}-symbolic`;
          self.tooltip_text = `Volume ${Math.floor(vol)}%`;
        }),
      }),
      // Widget.Label({
      //   label: audio.speaker
      //     .bind("volume")
      //     .as((v) => `${Math.round(v * 100)}%`),
      // }),
    ],
  });

const SysTrayItem = (item: TrayItem) =>
  Widget.Button({
    child: Widget.Icon({
      icon: item.bind("icon"),
    }),
    tooltipMarkup: item.bind("tooltip_markup"),
    onPrimaryClick: (_, event) => item.activate(event),
    onSecondaryClick: (_, event) => item.openMenu(event),
  });

const SysTray = () =>
  Widget.Box({
    className: "tray",
    spacing: 4,
    children: systemtray.bind("items").as((i) => i.map(SysTrayItem)),
  });

const switchWorkspace = (ws: number) =>
  hyprland.messageAsync(`dispatch workspace ${ws}`);

const Workspaces = () => {
  const range = Array.from({ length: 10 }, (_, i) => i + 1);
  const workspaces = range.map((i) =>
    Widget.Label({
      attribute: i,
      vpack: "center",
      // label: `${i}`,
      // onClicked: () => switchWorkspace(i),
      setup: (self) =>
        self.hook(hyprland, () => {
          self.toggleClassName("active", hyprland.active.workspace.id === i);
        }),
    }),
  );

  return Widget.Box({
    className: "workspaces",
    children: workspaces,
  });
};

const LeftGroup = () =>
  Widget.Box({
    className: "bar",
    spacing: 12,
    hpack: "start",
    children: [Widget.Label({ label: "󰣇", className: "logo" }), Workspaces()],
  });

const RightGroup = () =>
  Widget.Box({
    className: "bar",
    spacing: 6,
    hpack: "end",
    children: [SysTray(), VolumeIndicator(), BatteryIndicator(), Clock()],
  });

const Bar = (monitor = 0) =>
  Widget.Window({
    monitor,
    css: `background-color: transparent;`,
    name: `bar${monitor}`,
    anchor: ["top", "left", "right"],
    child: Widget.CenterBox({
      css: `min-width: 100%;`,
      vertical: false,
      startWidget: LeftGroup(),
      centerWidget: Widget.Box(),
      endWidget: RightGroup(),
    }),
  });

App.config({
  style: "/tmp/style.css",
  windows: [
    Bar(0), // can be instantiated for each monitor
  ],
});

export {};
