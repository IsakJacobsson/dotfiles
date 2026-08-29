# tmux

Modular tmux configuration. `~/.tmux.conf` is the entry point.

```text
~/.tmux.conf
├── general.conf
├── key-bindings.conf
├── colors/<theme>.conf
└── styles/<style>.conf
```

### Structure

* `general.conf` — general tmux settings
* `key-bindings.conf` — key bindings
* `colors/` — color themes
* `styles/` — visual styles
* `test_colors.sh` — validates color themes

### Colors in styles

Styles are **color-independent** and use the variables provided by a color
theme:

```text
color theme -> variables -> style
```

Themes define tmux user options (`@`):

```tmux
set -g @active_bg_color "#7aa2f7"
```

Styles use them:

```tmux
fg=#{@active_bg_color}
```

The color theme must be sourced **before** the style.

### Testing

```bash
./test_colors.sh
```

The test automatically discovers every `colors/*.conf` file and
verifies that all required color variables are defined.

The required color variables are defined in `test_colors.sh`.

