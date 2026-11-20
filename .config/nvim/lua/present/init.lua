local M = {}

--- @class present.Slides
--- @field slides Slide[]: List of slides

---@class present.Slide
---@field title string: Title of the slide
---@field body string[]: Body of slide

--- Parses lines into slides
--- @param lines string[]: Lines to parse
--- @return present.Slides
local function parse_slides(lines)
  local slides = {}
  local current_slide

  for _, line in ipairs(lines) do
    local title = line:match("^#%s+(.+)")
    if title then
      current_slide = { title = title, body = {} }
      slides[#slides + 1] = current_slide
    elseif current_slide then
      current_slide.body[#current_slide.body + 1] = line
    end
  end

  return slides
end

--- Open a floating winding with a scratch buffer.
--- The buffer is automatically deleted when hidden.
--- @return integer buf Buffer handle
--- @return integer win Window handle
local function open_window()
  local buf = vim.api.nvim_create_buf(false, true)
  vim.bo[buf].bufhidden = "wipe"

  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    row = 1,
    col = 1,
    width = vim.o.columns,
    height = vim.o.lines,
    border = { " ", " ", " ", " ", " ", " ", " ", " " },
    style = "minimal",
  })

  return buf, win
end

--- Calculates the horizontal padding needed to center text.
--- @param width integer Available width
--- @param text string Text to center
--- @return integer left Left padding
--- @return integer Right Right padding
local function calculate_horizontal_padding(width, text)
  local text_width = vim.fn.strdisplaywidth(text)
  local left = math.max(0, math.floor(
    (width - text_width) / 2
  ))
  local right = math.max(0, width - left - text_width)
  return left, right
end

--- Renders a slide inside a window.
--- Centers the slide title and appends the slide body below it.
--- Positions the cursor at the beginning of the title.
--- @param buf integer Buffer handle
--- @param win integer Window handle
--- @param slide present.Slide Slide data containing a title and body
local function render_slide(buf, win, slide)
  local width = vim.api.nvim_win_get_width(win)
  local content_width = width - 2

  local title_left_padding, title_right_padding = calculate_horizontal_padding(content_width, slide.title)

  local top_title_box = "╭" .. string.rep("─", content_width) .. "╮"
  local middle_title_box = "│" .. string.rep(" ", title_left_padding) .. slide.title .. string.rep(" ", title_right_padding) .. "│"
  local bottom_title_box = "╰" .. string.rep("─", content_width) .. "╯"

  local lines = { top_title_box, middle_title_box, bottom_title_box }
  vim.list_extend(lines, slide.body)

  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.api.nvim_win_set_cursor(win, { 1, 0 })
end

local function is_markdown_file()
  return vim.bo.filetype == "markdown"
end

--- @param slides present.Slides Slides to present
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
