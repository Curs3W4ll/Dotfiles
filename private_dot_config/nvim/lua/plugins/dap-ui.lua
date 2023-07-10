return function()

    local dap = require("dap")
    local dapui = require("dapui")

    dapui.setup({
        -- Floating windows configuration
        floating = {
            -- Use rounded borders
            border = "rounded",
        },
        -- Used layouts
        layouts = {
            -- Left column
            {
                elements = {
                    -- Variables and registers content
                    {
                        id = "scopes",
                        size = 0.35,
                    },
                    -- Breakpoints list
                    {
                        id = "breakpoints",
                        size = 0.35,
                    },
                    -- Stack trace
                    {
                        id = "stacks",
                        size = 0.15,
                    },
                    -- Expressions
                    {
                        id = "watches",
                        size = 0.15,
                    },
                },
                position = "left",
                size = 60,
            },
            -- Bottom line
            {
                elements = {
                    -- Repl window interface
                    {
                        id = "repl",
                        size = 0.5,
                    },
                    -- Console of the application (stdout, stderr, stdin)
                    {
                        id = "console",
                        size = 0.5,
                    },
                },
                position = "bottom",
                size = 15,
            },
        },
    })

    -- Automatically Show/Hide DAP UI at DAP events
    dap.listeners.after.event_initialized.dapui_config = dapui.open
    dap.listeners.before.event_terminated.dapui_config = dapui.close
    dap.listeners.before.event_exited.dapui_config = dapui.close

end
