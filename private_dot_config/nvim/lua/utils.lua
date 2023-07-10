local M = {}

function M.ensureDirectory(path)
    if vim.fn.isdirectory(path) == 0 then
        vim.cmd("silent !mkdir " .. path)
    end
end

function M.fileExist(filename, path)
    if not vim.fn.isdirectory(path) == 0 then
        error("Path not found: '" .. path .. "'")
    end
    return (vim.fn.findfile(filename, path) ~= "")
end

function M.ensureLastChar(str)
    if string.sub(str, -1) ~= "/" then
        return str .. "/"
    end
    return str
end

function M.getOption(option, window)
    if window == nil then
        if pcall(vim.api.nvim_get_option, option) then
            return vim.api.nvim_get_option(option)
        elseif pcall(vim.api.nvim_win_get_option, 0, option) then
            return vim.api.nvim_win_get_option(0, option)
        else
            error("Error while changing option '" .. option .. "' not found")
        end
    else
        if window then
            return vim.api.nvim_win_get_option(0, option)
        else
            return vim.api.nvim_get_option(option)
        end
    end
end
function M.updateOption(option, value, window)
    if window == nil then
        if pcall(vim.api.nvim_get_option, option) then
            vim.api.nvim_set_option(option, value)
        elseif pcall(vim.api.nvim_win_get_option, 0, option) then
            vim.api.nvim_win_set_option(0, option, value)
        else
            error("Error while changing option '" .. option .. "' not found")
        end
        if pcall(vim.api.nvim_buf_get_option, 0, option) then
            vim.api.nvim_buf_set_option(0, option, value)
        end
    else
        if window then
            vim.api.nvim_win_set_option(0, option, value)
        else
            vim.api.nvim_set_option(option, value)
        end
    end
end
function M.turnon(option, window)
    M.updateOption(option, true, window)
end
function M.turnoff(option, window)
    M.updateOption(option, false, window)
end

local default_options = {
    noremap = true,
    silent = false,
    nowait = false,
}
function M.map(mode, key, action, opts)
    local options = default_options
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, key, action, options)
end
function M.unmap(key)
    vim.cmd("unmap " .. key)
end

function M.reloadConfiguration()
    local configsPath = M.ensureLastChar(vim.fn.stdpath('config')) .. "lua/"
    for name,_ in pairs(package.loaded) do
        if M.fileExist(vim.fn.substitute(name, "\\.", "/", "g") .. ".lua", configsPath) then
            package.loaded[name] = nil
        end
    end

    dofile(vim.env.MYVIMRC)

    require("plenary.async").run(function()
        require("notify").async("Neovim configuration has been reloaded\n(Not plugins and keymaps)")
    end)
end

function M.get_random_ascii_art()
    return {
    }
end
function M.get_random_ascii_art_contextualized()
    return {
    }
end

function M.tbl_concat(t1, t2)
    if type(t1) ~= "table" or type(t2) ~= "table" then
        return {}
    end

    local concat = {}

    table.foreach(t1, function(_, v) table.insert(concat, v) end)
    table.foreach(t2, function(_, v) table.insert(concat, v) end)

    return concat
end

function M.toList(t, keys)
    if type(keys) == "string" then
        keys = { keys }
    end
    if type(t) ~= "table" or type(keys) ~= "table" then
        return {}
    end

    local list = {}

    for _,elem in ipairs(t) do
        for _,key in ipairs(keys) do
            if elem[key] ~= nil then
                table.insert(list, elem[key])
                break
            end
        end
    end

    return list
end

function M.tbl_has_value(tbl, value)
    for _,v in ipairs(tbl) do
        if value == v then
            return true
        end
    end

    return false
end

local function copy(obj, seen)
  if type(obj) ~= 'table' then
      return obj
  end

  if seen and seen[obj] then
      return seen[obj]
  end

  local s = seen or {}
  local res = setmetatable({}, getmetatable(obj))
  s[obj] = res
  for k, v in pairs(obj) do
      res[copy(k, s)] = copy(v, s)
  end

  return res
end
function M.tbl_copy(tbl)
    return copy(tbl)
end

return M
