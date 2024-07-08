const audio = await Service.import("audio");

export const AudioIcon = (size: number = 14) =>
  Widget.Icon({ size }).hook(audio.speaker, (self) => {
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
  });

const VolumeIndicator = () =>
  Widget.Box({
    className: "audio",
    spacing: 2,
    children: [
      Widget.Button({
        on_clicked: () => (audio.speaker.is_muted = !audio.speaker.is_muted),
        child: AudioIcon(),
      }),
    ],
  });

export default VolumeIndicator;
