import VolumeIndicator from "./widgets/Audio";
import BatteryIndicator from "./widgets/Battery";
import SysTray from "./widgets/Tray";
import Workspaces from "./widgets/Workspaces";
import Clock from "./widgets/Clock";
import Launcher from "./widgets/Launcher";

const LeftGroup = () =>
  Widget.Box({
    className: "bar",
    spacing: 12,
    hpack: "start",
    children: [
      Widget.Label({
        label: "󰣇",
        className: "logo",
      }),
      Workspaces(),
    ],
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
      startWidget: LeftGroup(),
      centerWidget: Widget.Box(),
      endWidget: RightGroup(),
    }),
  });

App.config({
  style: "/tmp/style.css",
  windows: [Bar(0), Bar(1), Launcher],
});

export {};
