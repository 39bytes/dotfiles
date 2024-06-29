import { TrayItem } from "types/service/systemtray";
const systemtray = await Service.import("systemtray");

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

export default SysTray;
