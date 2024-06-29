const battery = await Service.import("battery");

const BatteryIndicator = () =>
  Widget.Box({
    children: [
      Widget.Icon({
        className: "battery",
        icon: battery.bind("icon_name"),
        tooltipText: battery.bind("percent").as((p) => `${p}%`),
      }),
    ],
  });

export default BatteryIndicator;
