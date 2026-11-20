local M = {}

local function parse_slides(lines)
  local slides = {}
  local slide

  for _, line in ipairs(lines) do
    local title = line:match("^#%s+(.+)$")
    if title then
      slide = { title = title, body = {} }
      slides[#slides + 1] = slide
    elseif slide then
      slide.body[#slide.body + 1] = line
    end
  end

  return slides
end

local function open_window()
  local buf = vim.api.nvim_create_buf(false, true)
  vim.bo[buf].bufhidden = "wipe"

  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    row = 1,
    col = 1,
    width = vim.o.columns,
    height = vim.o.lines,
    border = "rounded",
    style = "minimal",
  })

  return buf, win
end

local function render_slide(buf, win, slide)
  local width = vim.api.nvim_win_get_width(win)
  local padding = math.max(0, math.floor(
    (width - vim.fn.strdisplaywidth(slide.title)) / 2
  ))
  local lines = { "", string.rep(" ", padding) .. slide.title, "" }
  vim.list_extend(lines, slide.body)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.api.nvim_win_set_cursor(win, { 1, 0 })
end

local function is_markdown_file()
  return vim.bo.filetype == "markdown"
end

local function show_presentation(slides)
  local buf, win = open_window()
  local index = 1

  local function move(delta)
    index = math.max(1, math.min(#slides, index + delta))
    render_slide(buf, win, slides[index])
  end

  vim.keymap.set("n", "j", function() move(1) end, { buffer = buf })
  vim.keymap.set("n", "k", function() move(-1) end, { buffer = buf })
  vim.keymap.set("n", "q", function()
    vim.api.nvim_win_close(win, true)
  end, { buffer = buf })

  render_slide(buf, win, slides[index])
end

local function start()
  if not is_markdown_file() then
    vim.notify("This plugin only works with markdown files.", vim.log.levels.ERROR)
    return
  end

  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local slides = parse_slides(lines)
  if #slides == 0 then
    vim.notify("Add a # Heading to start your first slide.")
    return
  end

  show_presentation(slides)
end

function M.setup()
  vim.api.nvim_create_user_command("Present", start, { force = true })
end

return M
