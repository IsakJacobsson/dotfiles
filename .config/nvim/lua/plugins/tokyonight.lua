local function jaco_light(colors)
    colors.bg = "#edf3ee"
    colors.bg_dark = "#bed8cd"
    colors.bg_dark1 = "#93c0af"
    colors.bg_highlight = "#bed8cd"

    colors.bg_float = "#edf3ee"
    colors.bg_popup = "#edf3ee"
    colors.bg_sidebar = "#d7e4dd"
    colors.bg_statusline = "#d7e4dd"

    colors.border = "#929c98"
    colors.border_highlight = "#0076c5"

    colors.bg_visual = "#bed8cd"
    colors.bg_search = "#93c0af"

    colors.fg = "#000000"
    colors.fg_dark = "#000000"
    colors.fg_float = "#000000"
    colors.fg_sidebar = "#000000"
    colors.fg_gutter = "#929c98"

    colors.black = "#000000"
    colors.terminal_black = "#929c98"

    colors.blue = "#0076c5"
    colors.blue0 = "#3b87df"
    colors.blue1 = "#50b1b2"
    colors.blue2 = "#50b1b2"
    colors.blue5 = "#3b87df"
    colors.blue6 = "#50b1b2"
    colors.blue7 = "#93c0af"

    colors.cyan = "#008f8f"

    colors.green = "#008b17"
    colors.green1 = "#52b63d"
    colors.green2 = "#50b1b2"

    colors.yellow = "#c08403"
    colors.orange = "#dba137"

    colors.red = "#d12525"
    colors.red1 = "#d33d34"

    colors.magenta = "#7522d3"
    colors.magenta2 = "#752bdd"
    colors.purple = "#7522d3"

    colors.teal = "#008f8f"

    colors.comment = "#929c98"
    colors.dark3 = "#929c98"
    colors.dark5 = "#929c98"

    colors.diff = {
      add = "#bed8cd",
      change = "#93c0af",
      delete = "#f4d6d6",
      text = "#93c0af",
    }

    colors.git = {
      add = "#008b17",
      change = "#0076c5",
      delete = "#d12525",
      ignore = "#929c98",
    }

    colors.error = "#d12525"
    colors.warning = "#c08403"
    colors.info = "#0076c5"
    colors.hint = "#008f8f"
    colors.todo = "#0076c5"

    colors.terminal = {
      black = "#000000",
      black_bright = "#929c98",

      blue = "#0076c5",
      blue_bright = "#3b87df",

      cyan = "#008f8f",
      cyan_bright = "#50b1b2",

      green = "#008b17",
      green_bright = "#52b63d",

      magenta = "#7522d3",
      magenta_bright = "#752bdd",

      red = "#d12525",
      red_bright = "#d33d34",

      white = "#000000",
      white_bright = "#000000",

      yellow = "#c08403",
      yellow_bright = "#dba137",
    }

    colors.terminal_black = "#929c98"

    colors.none = "NONE"
    colors.rainbow = {
      "#0076c5",
      "#c08403",
      "#008b17",
      "#008f8f",
      "#7522d3",
      "#d33d34",
      "#3b87df",
      "#dba137",
    }
end

local function jaco_dark(colors)
    colors.bg = "#161d1a"
    colors.bg_dark = "#1a221f"
    colors.bg_dark1 = "#232d29"
    colors.bg_highlight = "#2c4b43"

    colors.bg_float = "#1a221f"
    colors.bg_popup = "#1a221f"
    colors.bg_sidebar = "#1a221f"
    colors.bg_statusline = "#1a221f"

    colors.border = "#6f7d78"
    colors.border_highlight = "#58a6ff"

    colors.bg_visual = "#2c4b43"
    colors.bg_search = "#356557"

    colors.fg = "#d9e2dd"
    colors.fg_dark = "#b7c2bc"
    colors.fg_float = "#d9e2dd"
    colors.fg_sidebar = "#c8d2cd"
    colors.fg_gutter = "#6f7d78"

    colors.black = "#1a1f1d"
    colors.terminal_black = "#6f7d78"

    colors.blue = "#58a6ff"
    colors.blue0 = "#7bb9ff"
    colors.blue1 = "#72d0d1"
    colors.blue2 = "#72d0d1"
    colors.blue5 = "#7bb9ff"
    colors.blue6 = "#72d0d1"
    colors.blue7 = "#356557"

    colors.cyan = "#4db8b8"

    colors.green = "#008b17"
    colors.green1 = "#52b63d"
    colors.green2 = "#50b1b2"

    colors.yellow = "#d8a437"
    colors.orange = "#ebbd5c"

    colors.red = "#e35b5b"
    colors.red1 = "#ef7b73"

    colors.magenta = "#b27aff"
    colors.magenta2 = "#c696ff"
    colors.purple = "#b27aff"

    colors.teal = "#4db8b8"

    colors.comment = "#6f7d78"
    colors.dark3 = "#6f7d78"
    colors.dark5 = "#6f7d78"

    colors.diff = {
        add = "#234433",
        change = "#2d4d59",
        delete = "#4a2525",
        text = "#356557",
    }

    colors.git = {
        add = "#008b17",
        change = "#58a6ff",
        delete = "#e35b5b",
        ignore = "#6f7d78",
    }

    colors.error = "#e35b5b"
    colors.warning = "#d8a437"
    colors.info = "#58a6ff"
    colors.hint = "#4db8b8"
    colors.todo = "#58a6ff"

    colors.terminal = {
        black = "#1a1f1d",
        black_bright = "#6f7d78",

        red = "#e35b5b",
        red_bright = "#ef7b73",

        green = "#008b17",
        green_bright = "#52b63d",

        yellow = "#d8a437",
        yellow_bright = "#ebbd5c",

        blue = "#58a6ff",
        blue_bright = "#7bb9ff",

        magenta = "#b27aff",
        magenta_bright = "#c696ff",

        cyan = "#4db8b8",
        cyan_bright = "#72d0d1",

        white = "#d9e2dd",
        white_bright = "#ffffff",
    }

    colors.terminal_black = "#6f7d78"

    colors.none = "NONE"

    colors.rainbow = {
        "#58a6ff",
        "#d8a437",
        "#008b17",
        "#4db8b8",
        "#b27aff",
        "#e35b5b",
        "#7bb9ff",
        "#ebbd5c",
    }
end

return {
    {
        "folke/tokyonight.nvim",
        priority = 1000, -- Make sure to load this before all the other start plugins.
        config = function()
            ---@diagnostic disable-next-line: missing-fields
            require("tokyonight").setup({
                transparent = true,
                styles = {
                    -- Floating windows will have same background as nvim.
                    -- E.g., Telescope or auto complete menu.
                    -- Looks good with vim.o.winborder = true.
                    floats = "transparent",
                },
                on_highlights = function(hl, c)
                    hl.LineNr = { fg = c.fg_dark }
                    hl.LineNrAbove = { fg = c.fg_dark }
                    hl.LineNrBelow = { fg = c.fg_dark }
                end,
                on_colors = function(colors)
                    colors.comment = colors.fg_dark
                end,
                -- on_colors = jaco_light,
            })

            -- Load the colorscheme here.
            -- Like many other themes, this one has different styles, and you could load
            -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
            vim.cmd.colorscheme("tokyonight-storm")
        end,
    },
}
