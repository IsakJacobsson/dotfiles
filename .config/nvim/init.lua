-- [[ Setting options ]]
require("config.set")

-- [[ Basic Keymaps ]]
require("config.remap")

-- [[ Install plugins ]]
require("plugins.plugins")

-- [[ Plugin configuration ]]
require("plugins.undotree")
require("plugins.telescope")
require("plugins.oil")
require("plugins.tokyonight")
require("plugins.treesitter")
require("plugins.conform")
require("plugins.comment")
require("plugins.gitsigns")
require("plugins.mason")
require("plugins.blink")
require("plugins.mini")
require("plugins.highlight_color")

-- [[ Configure lsp ]]
require("config.lsp")
