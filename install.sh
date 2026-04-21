#!/usr/bin/env sh
# sa-dev installer
#
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/silveraspen-com/tui/main/install.sh | sh
#
# Env vars:
#   SA_VERSION      release tag to install (default: latest)
#   SA_INSTALL_DIR  where to extract the tarball (default: $HOME/.silveraspen)
#   SA_BIN_DIR      where to symlink the launcher (default: /usr/local/bin)

set -eu

REPO="silveraspen-com/tui"
VERSION="${SA_VERSION:-latest}"
INSTALL_DIR="${SA_INSTALL_DIR:-$HOME/.silveraspen}"
BIN_DIR="${SA_BIN_DIR:-/usr/local/bin}"

uname_s="$(uname -s)"
uname_m="$(uname -m)"

case "$uname_s" in
  Darwin) os="darwin" ;;
  Linux)  os="linux" ;;
  *) echo "Error: unsupported OS '$uname_s'." >&2; exit 1 ;;
esac

case "$uname_m" in
  arm64|aarch64) arch="arm64" ;;
  x86_64|amd64)  arch="x64" ;;
  *) echo "Error: unsupported arch '$uname_m'." >&2; exit 1 ;;
esac

target="${os}-${arch}"
tarball="sa-dev-${target}.tar.gz"

if [ "$VERSION" = "latest" ]; then
  base_url="https://github.com/${REPO}/releases/latest/download"
else
  base_url="https://github.com/${REPO}/releases/download/${VERSION}"
fi

tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT

echo "Downloading ${tarball} from ${VERSION} release..."
if command -v curl >/dev/null 2>&1; then
  curl -fL --progress-bar -o "${tmp}/${tarball}" "${base_url}/${tarball}"
  curl -fL --progress-bar -o "${tmp}/${tarball}.sha256" "${base_url}/${tarball}.sha256"
elif command -v wget >/dev/null 2>&1; then
  wget -q --show-progress -O "${tmp}/${tarball}"        "${base_url}/${tarball}"
  wget -q --show-progress -O "${tmp}/${tarball}.sha256" "${base_url}/${tarball}.sha256"
else
  echo "Error: need 'curl' or 'wget' on PATH." >&2
  exit 1
fi

echo "Verifying checksum..."
(
  cd "$tmp"
  if command -v shasum >/dev/null 2>&1; then
    shasum -a 256 -c "${tarball}.sha256"
  else
    sha256sum -c "${tarball}.sha256"
  fi
)

echo "Extracting to ${INSTALL_DIR}..."
mkdir -p "$INSTALL_DIR"
tar xzf "${tmp}/${tarball}" -C "$INSTALL_DIR"

launcher="${INSTALL_DIR}/sa-dev"
link="${BIN_DIR}/sa-dev"

echo "Linking ${link} -> ${launcher}"
if [ -w "$BIN_DIR" ]; then
  ln -sf "$launcher" "$link"
else
  sudo ln -sf "$launcher" "$link"
fi

echo
echo "Installed. Run: sa-dev"
echo "(Requires Node.js 20+ on PATH.)"
