const get = (args: string) => Number(Utils.exec(`brightnessctl ${args}`));
const screen = Utils.execAsync("ls -w1 /sys/class/backlight | head -1");

class Brightness extends Service {
  static {
    Service.register(
      this,
      {},
      {
        screen: ["float", "rw"],
      },
    );
  }

  #screenMax = get(`max`);
  #screen = get("get") / get(`max`);

  get screen() {
    return this.#screen;
  }
  get screenMax() {
    return this.#screenMax;
  }

  set screen(percent: number) {
    if (percent < 0) {
      percent = 0;
    }

    if (percent > 1) {
      percent = 1;
    }

    percent = Math.floor(percent * 100);

    Utils.execAsync(`brightnessctl set ${percent}% -q`).then(() => {
      this.#screen = percent;
      this.changed("screen");
    });
  }

  constructor() {
    super();

    Utils.monitorFile(
      `/sys/class/backlight/${screen}/brightness`,
      async (f) => {
        const v = await Utils.readFileAsync(f);
        this.#screen = Number(v) / this.#screenMax;
        this.changed("screen");
      },
    );
  }
}

export default new Brightness();
