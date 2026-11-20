local M = {}

local highlight_ns = vim.api.nvim_create_namespace("present")

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

local function is_markdown_file()
  return vim.bo.filetype == "markdown"
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
local function render_slide(buf, win, slide, bullet_highlight_row)
  local width = vim.api.nvim_win_get_width(win)
  local content_width = width - 2

  local title_left_padding, title_right_padding = calculate_horizontal_padding(content_width, slide.title)

  local top_title_box = "╭" .. string.rep("─", content_width) .. "╮"
  local middle_title_box = "│" .. string.rep(" ", title_left_padding) .. slide.title .. string.rep(" ", title_right_padding) .. "│"
  local bottom_title_box = "╰" .. string.rep("─", content_width) .. "╯"

  local lines = { top_title_box, middle_title_box, bottom_title_box }
  vim.list_extend(lines, slide.body)

  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

  -- Clear previous highlights
  vim.api.nvim_buf_clear_namespace(buf, highlight_ns, 0, -1)

  -- Highlight the title
  vim.api.nvim_buf_add_highlight(buf, highlight_ns, "Title", 1, 1, -1)

  -- Highlight bullet
  if bullet_highlight_row then
    vim.api.nvim_buf_add_highlight(buf, highlight_ns, "Statement", bullet_highlight_row, 0, -1)
  end

  vim.api.nvim_win_set_cursor(win, { 1, 0 })
end

--- Gets the buffer line numbers of all bullets in a slide.
--- @param slide present.Slide
--- @return integer[] rows
local function get_bullet_rows(slide)
  local rows = {}

  for i, line in ipairs(slide.body) do
    if line:match("^%s*[-*+]%s+") then
      rows[#rows + 1] = i + 2
    end
  end

  return rows
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

--- @param slides present.Slide[] Slides to present.
local function show_presentation(slides)
  local buf, win = open_window()
  local slide_index = 1
  local bullet_index = nil
  local bullet_rows = get_bullet_rows(slides[slide_index])
  local bullet_indices = {}

  local function render_current_slide()
    bullet_rows = get_bullet_rows(slides[slide_index])
    bullet_index = bullet_indices[slide_index]
    local highlight_row = bullet_index and bullet_rows[bullet_index]
    render_slide(buf, win, slides[slide_index], highlight_row)
  end

  local function move_down()
    if not bullet_index then
      if #bullet_rows > 0 then
        bullet_index = 1
        bullet_indices[slide_index] = bullet_index
      elseif slide_index < #slides then
        slide_index = slide_index + 1
        render_current_slide()
        return
      end
    elseif bullet_index < #bullet_rows then
      bullet_index = bullet_index + 1
      bullet_indices[slide_index] = bullet_index
    elseif slide_index < #slides then
      slide_index = slide_index + 1
      render_current_slide()
      return
    end
    render_current_slide()
  end

  local function move_up()
    if not bullet_index then
      if slide_index > 1 then
        slide_index = slide_index - 1
        bullet_indices[slide_index] = bullet_indices[slide_index] or #get_bullet_rows(slides[slide_index])

        render_current_slide()
      end
      return
    end

    if bullet_index > 1 then
      bullet_index = bullet_index - 1
    else
      bullet_index = nil
    end

    bullet_indices[slide_index] = bullet_index
    render_current_slide()
  end

  vim.keymap.set("n", "j", move_down, { buffer = buf })
  vim.keymap.set("n", "k", move_up, { buffer = buf })

  vim.keymap.set("n", "q", function()
    vim.api.nvim_win_close(win, true)
  end, { buffer = buf })

  render_current_slide()
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
