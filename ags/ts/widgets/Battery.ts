const battery = await Service.import("battery");

const BatteryIndicator = () =>
  Widget.Box({
    children: [
      Widget.Icon({
        className: "battery",
        icon: battery.bind("icon_name"),
        tooltipText: Utils.merge(
          [
            battery.bind("percent"),
            battery.bind("time_remaining"),
            battery.bind("charging"),
          ],
          (p, t, charging) => {
            if (p === 100) {
              return "100%";
            }
            const hours = Math.floor(t / 3600);
            const minutes = Math.floor((t % 3600) / 60);
            if (charging) {
              return `${p}% (${hours}h${minutes}m till full)`;
            }
            return `${p}% (${hours}h${minutes}m)`;
          },
        ),
      }),
    ],
  });

export default BatteryIndicator;
