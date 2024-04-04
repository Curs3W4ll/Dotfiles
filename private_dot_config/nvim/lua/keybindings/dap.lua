local dap = require("dap")
local dapui = require("dapui")
local notify = require("notify")

local neotree = require("neo-tree")
local neotree_manager = require("neo-tree.sources.manager")
local neotree_renderer = require("neo-tree.ui.renderer")

local function is_neotree_filesystem_opened()
    local state = neotree_manager.get_state("filesystem")
    if state == nil then
        return false
    end
    return neotree_renderer.tree_is_visible(state)
end

local notify_title = "Debug Adapter Protocol"
local notify_opts = {
    title = notify_title,
}
local neotree_opened_before_dap = nil
local function open()
    neotree_opened_before_dap = is_neotree_filesystem_opened()
    neotree.close_all()
    dapui.open()
end
local function close()
    if neotree_opened_before_dap == true then
        vim.cmd.Neotree("show")
    end
    dapui.close()
end
local function continue()
    if dap.session() == nil then
        notify.notify("No active debug session, creating a new one", "warn", notify_opts)
    else
        notify.notify("Continue execution until next breakpoint", "info", notify_opts)
    end
    dap.continue()
end
local function reverse_continue()
    if dap.session() == nil then
        notify.notify("No active debug session", "error", notify_opts)
        dap.reverse_continue()
    else
        notify.notify("Running current debug session backwards", "info", notify_opts)
    end
end
local function pause()
    if dap.session() == nil then
        notify.notify("No active debug session", "warn", notify_opts)
    else
        notify.notify("Current debug session paused", "info", notify_opts)
        dap.pause()
    end
end
local function run_last()
    notify.notify("Starting new debug session based on last one", "info", notify_opts)
    dap.run_last()
    open()
end
local function start()
    if dap.session() ~= nil then
        notify.notify("A debug session is already active", "error", notify_opts)
    else
        notify.notify("Starting a new debug session", "info", notify_opts)
        dap.continue()
    end
    open()
end
local function stop()
    if dap.session() == nil then
        notify.notify("No active debug session", "warn", notify_opts)
    else
        notify.notify("Stopping current debug session...", "info", notify_opts)
        dap.terminate({}, { terminateDebuggee = true }, function()
            notify.notify("Debug session stopped", "success", notify_opts)
        end)
        dap.repl.close()
    end
    close()
end
local function restart()
    if dap.session() == nil then
        notify.notify("No active debug session", "error", notify_opts)
    else
        notify.notify("Restarting current debug session...", "info", notify_opts)
        dap.restart()
    end
end
local function goto_()
    if dap.session() == nil then
        notify.notify("No active debug session", "error", notify_opts)
    else
        local line = vim.fn.input("Line number (empty if cursor line): ")
        notify.notify("Jumping to line " .. line, "info", notify_opts)
        dap.goto_(line)
    end
end
local function set_breakpoint()
    dap.set_breakpoint(nil, nil, vim.fn.input("Comment (empty if none): "))
end
local function step_into()
    if dap.session() == nil then
        notify.notify("No active debug session", "error", notify_opts)
    else
        notify.notify("Trying to go deeper in current statement", "info", notify_opts)
        dap.step_into()
    end
end
local function step_out()
    if dap.session() == nil then
        notify.notify("No active debug session", "error", notify_opts)
    else
        notify.notify("Trying to go out of current statement", "info", notify_opts)
        dap.step_out()
    end
end
local function step_over()
    if dap.session() == nil then
        notify.notify("No active debug session", "error", notify_opts)
    else
        notify.notify("Going one step forward", "info", notify_opts)
        dap.step_over()
    end
end
local function step_back()
    if dap.session() == nil then
        notify.notify("No active debug session", "error", notify_opts)
    else
        notify.notify("Going one step backward", "info", notify_opts)
        dap.step_back()
    end
end
local function run_to_cursor()
    if dap.session() == nil then
        notify.notify("No active debug session", "error", notify_opts)
    else
        notify.notify("Continue execution until current cursor line", "info", notify_opts)
        dap.run_to_cursor()
    end
end

require("which-key").register({
    d = {
        name = "DAP, Debug Adapter Protocol",
        -- =============================
        -- ===        Sessions       ===
        -- =============================
        c = { continue, "Continue execution until breakpoint" },
        C = { reverse_continue, "Reverse execution until breakpoint" },
        p = { pause, "Pause current debug session" },
        r = { restart, "Restart current debug session" },
        l = { run_last, "Start last debug session with same config" },
        s = { start, "Start a new debug session" },
        S = { stop, "Stop current debug session" },
        i = { step_into, "Go into function/method" },
        o = { step_out, "Go out function/method" },
        n = { step_over, "Go one step below" },
        N = { step_back, "Go back one step" },
        g = { goto_, "Go to specific line" },
        b = {
            name = "Breakpoints",
            t = { dap.toggle_breakpoint, "Add/Remove breakpoint at cursor line" },
            s = { set_breakpoint, "Add/Replace breakpoint at cursor line" },
            l = { dap.list_breakpoints, "List breakpoints of current debug session" },
            c = { run_to_cursor, "Run to cursor line (skip breakpoints)" },
            C = { dap.clear_breakpoints, "Clear all breakpoints" },
        },
        u = {
            name = "UI",
            t = { dapui.toggle, "Show/Hide DAP UI" },
            o = { open, "Show DAP UI" },
            c = { close, "Hide DAP UI" },
            r = { function() dapui.open({ reset = true }) end, "Reset/Reload DAP UI" },
        },
    },
}, {
    mode = "n",
    prefix = "<leader>",
})
