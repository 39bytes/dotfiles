import { Application } from "types/service/applications";
const applications = await Service.import("applications");

const LAUNCHER_WINDOW_NAME = "ags-launcher";

const AppItem = (app: Application) =>
  Widget.Button({
    on_clicked: () => {
      App.closeWindow(LAUNCHER_WINDOW_NAME);
      app.launch();
    },
    attribute: { app },
    child: Widget.Box({
      className: "app-item",
      children: [
        Widget.Icon({
          css: "margin-right: 6pt;",
          icon: app.icon_name ?? "",
          size: 24,
        }),
        Widget.Label({
          label: app.name,
          xalign: 0,
          vpack: "center",
          truncate: "end",
        }),
      ],
    }),
  });

const LauncherContent = () => {
  let apps = applications.query("").map(AppItem);

  const list = Widget.Box({
    vertical: true,
    children: apps,
    spacing: 6,
  });

  const refresh = () => {
    apps = applications.query("").map(AppItem);
    list.children = apps;
  };

  const search = Widget.Entry({
    className: "search",
    placeholderText: "Search...",
    hexpand: true,
    on_change: ({ text }) => {
      for (const item of apps) {
        item.visible = item.attribute.app.match(text ?? "");
      }
    },
    on_accept: () => {
      const searchResults = apps.filter((item) => item.visible);
      const first = searchResults[0];
      if (first) {
        App.toggleWindow(LAUNCHER_WINDOW_NAME);
        first.attribute.app.launch();
      }
    },
  });

  return Widget.Box({
    className: "launcher",
    vertical: true,
    children: [
      search,
      Widget.Scrollable({
        hscroll: "never",
        css: `min-width: 600px; min-height: 250px;`,
        child: list,
      }),
    ],
    setup: (self) => {
      self.hook(App, (_, windowName, visible) => {
        if (windowName !== LAUNCHER_WINDOW_NAME) {
          return;
        }

        if (visible) {
          refresh();
          search.text = "";
          search.grab_focus();
        }
      });
    },
  });
};

const Launcher = Widget.Window({
  name: LAUNCHER_WINDOW_NAME,
  keymode: "exclusive",
  setup: (self) => {
    self.keybind("Escape", () => {
      App.closeWindow(LAUNCHER_WINDOW_NAME);
    });
  },
  visible: false,
  child: LauncherContent(),
});

export default Launcher;
