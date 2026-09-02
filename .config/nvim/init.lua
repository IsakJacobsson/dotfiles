-- [[ Setting options ]]
require("config.set")

-- [[ Basic Keymaps ]]
require("config.remap")

-- [[ Install `lazy.nvim` plugin manager ]]
require("config.lazy")

-- [[ Configure and install all plugins ]]
require("lazy").setup("plugins")

-- [[ Configure lsp ]]
require("config.lsp")
