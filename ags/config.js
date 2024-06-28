const entry = `${App.configDir}/ts/main.ts`;
const scss = `${App.configDir}/style.scss`;
const css = `/tmp/style.css`;

Utils.exec(`sassc ${scss} ${css}`);

const outdir = "/tmp/ags/js";

try {
  await Utils.execAsync([
    "bun",
    "build",
    entry,
    "--outdir",
    outdir,
    "--external",
    "resource://*",
    "--external",
    "gi://*",
  ]);
  await import(`file://${outdir}/main.js`);
} catch (error) {
  console.error(error);
}

export {};
