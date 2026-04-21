# sa-dev

Silver Aspen developer TUI.

## Install

One-liner (macOS / Linux):

```sh
curl -fsSL https://raw.githubusercontent.com/silveraspen-com/tui/main/install.sh | sh
```

Or pin a version:

```sh
SA_VERSION=v0.1.0 curl -fsSL https://raw.githubusercontent.com/silveraspen-com/tui/main/install.sh | sh
```

### Manual install

```sh
# macOS (Apple Silicon)
curl -LO https://github.com/silveraspen-com/tui/releases/latest/download/sa-dev-darwin-arm64.tar.gz
curl -LO https://github.com/silveraspen-com/tui/releases/latest/download/sa-dev-darwin-arm64.tar.gz.sha256
shasum -a 256 -c sa-dev-darwin-arm64.tar.gz.sha256

mkdir -p ~/.silveraspen
tar xzf sa-dev-darwin-arm64.tar.gz -C ~/.silveraspen
sudo ln -sf ~/.silveraspen/sa-dev /usr/local/bin/sa-dev
```

### Requirements

- Node.js 20 or higher on `PATH`. Install from [nodejs.org](https://nodejs.org/).

### Supported platforms

| OS | Arch | Asset |
|---|---|---|
| macOS | arm64 | `sa-dev-darwin-arm64.tar.gz` |

Additional platforms (macOS x64, Linux x64, Linux arm64) coming soon.

## Usage

```sh
sa-dev
```

## Uninstall

```sh
sudo rm /usr/local/bin/sa-dev
rm -rf ~/.silveraspen
```
