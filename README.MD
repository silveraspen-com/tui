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
for cmd in sa-dev sa-dev-bob sa-dev-charlie sa-dev-alice; do
  sudo ln -sf "$HOME/.silveraspen/$cmd" "/usr/local/bin/$cmd"
done
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

### Running multiple personas in parallel

The installer also puts three sibling commands on `PATH` — `sa-dev-bob`,
`sa-dev-charlie`, `sa-dev-alice`. They talk to the same hosted network as
`sa-dev`, but each one keeps an isolated edge vault and OS keychain entry, so
you can run three terminals side-by-side as three distinct members and
dogfood peer-to-peer flows against the real trust node.

| Command | Vault directory | OS keychain service |
|---|---|---|
| `sa-dev` | `~/.silveraspen/dev` | `com.silveraspen.tui.sa-dev` |
| `sa-dev-bob` | `~/.silveraspen/dev-bob` | `com.silveraspen.tui.sa-dev-bob` |
| `sa-dev-charlie` | `~/.silveraspen/dev-charlie` | `com.silveraspen.tui.sa-dev-charlie` |
| `sa-dev-alice` | `~/.silveraspen/dev-alice` | `com.silveraspen.tui.sa-dev-alice` |

Enroll each one under a different handle; they will see each other on the
network as distinct members.

## Uninstall

```sh
for cmd in sa-dev sa-dev-bob sa-dev-charlie sa-dev-alice; do
  sudo rm -f "/usr/local/bin/$cmd"
done
rm -rf ~/.silveraspen
```
