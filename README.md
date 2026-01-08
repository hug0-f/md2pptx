# md2pptx

`md2pptx` is a Bash tool that converts Markdown files into PowerPoint (`.pptx`) presentations using **marp-cli**.

## Requirements

* Node.js
* npm
* marp-cli

If `node`, `npm`, or `marp-cli` are missing, `md2pptx` can install them automatically (except in CI mode).

---

## Installation

Clone the repository and make the script executable:

```bash
chmod +x md2pptx lib/*
```

---

## Basic Usage

Convert a single Markdown file:

```bash
md2pptx slides.md
```

This generates:

```text
slides.pptx
```

---

## Specify Output File

You can define the output file name when converting a single file:

```bash
md2pptx slides.md -o deck.pptx
```

`--output` can only be used with one input file.

---

## Batch Processing

Convert all Markdown files in a directory:

```bash
md2pptx slides/
```

Or multiple files:

```bash
md2pptx intro.md chapter1.md chapter2.md
```

Each file generates its own `.pptx`.

---

## Themes

Use a Marp theme:

```bash
md2pptx slides.md --theme gaia
```

Theme auto-discovery:

* `themes/*.css` in the current directory
* `/usr/share/marp/themes/*.css`
* Marp built-in themes

If multiple themes are found, you will be prompted to select one (except in CI mode).

---

## Advanced Marp Options

You can pass additional options directly to marp:

```bash
md2pptx slides.md --marp-opt "--allow-local-files"
```

You can use `--marp-opt` multiple times.

---

## Dry Run

Run without generating files:

```bash
md2pptx slides.md --dry-run
```

---

## Verbose Mode

Enable detailed output:

```bash
md2pptx slides.md --verbose
```

---

## CI Mode (Non-Interactive)

CI mode disables:

* prompts
* automatic installation
* cleanup questions

The command fails immediately if a dependency is missing.

```bash
md2pptx slides.md --ci
```

Typical CI usage:

```bash
md2pptx --ci --theme default slides/*.md
```

---

## Cleanup Behavior

If `md2pptx` installs `npm` or `marp-cli`, it will ask at the end whether you want to remove them.

To disable cleanup prompts:

```bash
md2pptx slides.md --no-cleanup
```

To auto-confirm prompts:

```bash
md2pptx slides.md --yes
```

---

## Help

Display help:

```bash
md2pptx --help
```

or

```bash
md2pptx -h
```

---

## Exit Codes

* `0` — success
* non-zero — error (missing dependency, conversion failure, invalid arguments)

---

## Notes

* `--output` is only supported for single-file conversion
* In batch mode, output files are generated next to their input files
* In CI mode, the script is fully deterministic and non-interactive
