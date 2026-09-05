-- Require each plugin file in this folder
for name, type in vim.fs.dir(vim.fn.stdpath("config") .. "/lua/plugins") do
  if type == "file" and name:sub(-4) == ".lua" and name ~= "init.lua" then
    require("plugins." .. name:sub(1, -5))
  end
end
