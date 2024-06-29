const battery = await Service.import("battery");

const BatteryIndicator = () =>
  Widget.Box({
    children: [
      Widget.Icon({
        className: "battery",
        icon: battery.bind("icon_name"),
        tooltipText: Utils.merge(
          [battery.bind("percent"), battery.bind("time_remaining")],
          (p, t) => {
            const hours = Math.floor(t / 3600);
            const minutes = Math.floor((t % 3600) / 60);
            return `${p}% (${hours}h${minutes}m)`;
          },
        ),
      }),
    ],
  });

export default BatteryIndicator;
