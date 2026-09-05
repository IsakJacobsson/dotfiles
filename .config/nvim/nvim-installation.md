# Neovim Installation

Neovim is installed from the official macOS ARM64 tarball.

## Installation

The extracted Neovim directory is located at:

```text
~/.local/opt/nvim-macos-arm64/
```

The executable is exposed through:

```text
~/.local/bin/nvim
```

as a symlink to:

```text
~/.local/opt/nvim-macos-arm64/bin/nvim
```

Make sure `~/.local/bin` is in `$PATH`:

```bash
export PATH="$HOME/.local/bin:$PATH"
```

## Configuration

Existing Neovim configuration is kept in:

```text
~/.config/nvim/
```

Existing Neovim data is kept in:

```text
~/.local/share/nvim/
```

The tarball's `bin`, `lib`, and `share` directories are kept together and should not be split apart.

