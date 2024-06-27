local birthday_day = 30
local birthday_month = 8
local ascii_art_directory = "plugins.dashboard-ascii-arts"
local ascii_art_files = {
  new_year = "new-year",
  valentines = "valentines",
  spring = "spring",
  summer = "summer",
  birthday = "birthday",
  autumn = "autumn",
  halloween = "halloween",
  winter = "winter",
  christmas = "christmas",
}
local function get_ascii_art_file()
  local day = tonumber(vim.fn.strftime("%e"))
  local month = tonumber(vim.fn.strftime("%m"))

  if month == birthday_month and day == birthday_day then
    return ascii_art_files.birthday
  end

  if month > 12 or (month == 12 and day >= 22) then
    if month == 12 and day == 24 then
      return ascii_art_files.christmas
    end
    return ascii_art_files.winter
  elseif month > 9 or (month == 9 and day >= 23) then
    if month == 10 and day == 31 then
      return ascii_art_files.halloween
    end
    return ascii_art_files.autumn
  elseif month > 6 or (month == 6 and day >= 21) then
    return ascii_art_files.summer
  elseif month > 3 or (month == 3 and day >= 20) then
    return ascii_art_files.spring
  else
    if month == 1 and day == 1 then
      return ascii_art_files.new_year
    elseif month == 2 and day == 14 then
      return ascii_art_files.valentines
    end
    return ascii_art_files.winter
  end
end
local function get_ascii_art()
  local file = get_ascii_art_file()
  local ascii_arts = require(ascii_art_directory .. "." .. file)
  return ascii_arts[math.random(#ascii_arts)]
end

local function get_header()
  local head = vim.api.nvim_win_get_height(0) > 40 and get_ascii_art() or {}
  head = vim.fn.extend(head, {
    "",
    "",
    "A great day incoming",
    "The world is curs3d, people are curs3d",
    "",
  })
  return head
end
local function get_footer()
  local footer = {
    "",
    "",
    string.format(
      "Lazy took %s ms to start with %s plugins",
      require("lazy").stats().startuptime,
      require("lazy").stats().loaded
    ),
    string.format(
      "%s plugins are currently not loaded",
      require("lazy").stats().count - require("lazy").stats().loaded
    ),
  }
  if require("lazy.status").has_updates() then
    footer = vim.fn.extend(footer, { string.format("%s plugins require updates", require("lazy.status").updates()) })
  end
  footer = vim.fn.extend(footer, {
    "",
    "",
    vim.fn.strftime("%A %e %B %G - %H:%M:%S"),
  })
  return footer
end

local function get_update_title()
  local title = "Update"
  if require("lazy.status").has_updates() then
    title = title .. string.format("(%s)", require("lazy.status").updates())
  end
  return title
end

return function()
  require("dashboard").setup({ -- Used theme for greater
    theme = "hyper",
    -- Disable moving keys
    disable_move = true,
    config = {
      -- Disable moving keys
      disable_move = true,
      -- Header (first lines)
      header = get_header(),
      -- Pre-config header
      week_header = {
        -- Disable week header (display day of week)
        enable = false,
        concat = "- A great day incoming",
        append = {
          "The world is curs3d, people are curs3d",
        },
      },
      -- List of actions available in dashboard
      shortcut = {
        {
          icon = " ",
          desc = "Leave",
          group = "DiagnosticVirtualTextError",
          key = "q",
          action = "q",
        },
        {
          icon = " ",
          desc = get_update_title(),
          group = "DiagnosticVirtualTextHint",
          key = "u",
          action = "Lazy update",
        },
        {
          icon = "󰿞 ",
          desc = "Clean",
          group = "DiagnosticVirtualTextWarn",
          key = "x",
          action = "Lazy clean",
        },
        {
          icon = " ",
          desc = "Files",
          group = "DiagnosticVirtualTextInfo",
          action = "Telescope find_files hidden=true",
          key = "f",
        },
        {
          icon = " ",
          desc = "Config",
          group = "DiagnosticVirtualTextInfo",
          action = "lua vim.cmd('silent cd ~/.local/share/chezmoi');require('telescope.builtin').find_files({ hidden = true })",
          key = "c",
        },
        {
          icon = "󰆓 ",
          desc = "Last session",
          group = "DiagnosticVirtualTextInfo",
          action = "lua require('persistence').load({ last = true })",
          key = "s",
        },
        {
          icon = "󰆓 ",
          desc = "Last dir session",
          group = "DiagnosticVirtualTextInfo",
          action = "lua require('persistence').load()",
          key = "d",
        },
      },
      -- Display number of packages neovim loaded
      packages = {
        enable = true,
      },
      -- Display recently opened projects
      project = {
        enable = true,
        limit = 5,
        icon = " ",
        label = "Recent projects",
        action = "Telescope find_files hidden=true cwd=",
      },
      -- Display recently opened files
      mru = {
        limit = 5,
        icon = " ",
        label = "Recent files",
      },
      -- Footer (last lines)
      footer = get_footer,
    },
  })
end
