const hyprland = await Service.import("hyprland");

const Workspaces = () => {
  const range = Array.from({ length: 10 }, (_, i) => i + 1);
  const workspaces = range.map((i) =>
    Widget.Label({
      attribute: i,
      vpack: "center",
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

export default Workspaces;
