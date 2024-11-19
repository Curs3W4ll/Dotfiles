return {
  setup = function()
    local notify_title = "Debug Adapter Protocol"
    local notify_opts = {
      title = notify_title,
    }
    local neotree_opened_before_dap = nil

    local function is_neotree_filesystem_opened()
      local state = require("neo-tree.sources.manager").get_state("filesystem")
      if state == nil then
        return false
      end
      return require("neo-tree.ui.renderer").tree_is_visible(state)
    end

    local function open()
      neotree_opened_before_dap = is_neotree_filesystem_opened()
      require("neo-tree").close_all()
      require("dapui").open()
    end
    local function close()
      if neotree_opened_before_dap == true then
        vim.cmd.Neotree("show")
      end
      require("dapui").close()
    end
    local function continue()
      local dap = require("dap")
      local notify = require("notify")

      if dap.session() == nil then
        notify.notify("No active debug session, creating a new one", "warn", notify_opts)
      else
        notify.notify("Continue execution until next breakpoint", "info", notify_opts)
      end
      dap.continue()
    end
    local function reverse_continue()
      local dap = require("dap")
      local notify = require("notify")

      if dap.session() == nil then
        notify.notify("No active debug session", "error", notify_opts)
        dap.reverse_continue()
      else
        notify.notify("Running current debug session backwards", "info", notify_opts)
      end
    end
    local function pause()
      local dap = require("dap")
      local notify = require("notify")

      if dap.session() == nil then
        notify.notify("No active debug session", "warn", notify_opts)
      else
        notify.notify("Current debug session paused", "info", notify_opts)
        dap.pause()
      end
    end
    local function run_last()
      local dap = require("dap")
      local notify = require("notify")

      notify.notify("Starting new debug session based on last one", "info", notify_opts)
      dap.run_last()
      open()
    end
    local function start()
      local dap = require("dap")
      local notify = require("notify")

      if dap.session() ~= nil then
        notify.notify("A debug session is already active", "error", notify_opts)
      else
        notify.notify("Starting a new debug session", "info", notify_opts)
        dap.continue()
      end
      open()
    end
    local function stop()
      local dap = require("dap")
      local notify = require("notify")

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
      local dap = require("dap")
      local notify = require("notify")

      if dap.session() == nil then
        notify.notify("No active debug session", "error", notify_opts)
      else
        notify.notify("Restarting current debug session...", "info", notify_opts)
        dap.restart()
      end
    end
    local function goto_()
      local dap = require("dap")
      local notify = require("notify")

      if dap.session() == nil then
        notify.notify("No active debug session", "error", notify_opts)
      else
        local line = vim.fn.input("Line number (empty if cursor line): ")
        notify.notify("Jumping to line " .. line, "info", notify_opts)
        dap.goto_(line)
      end
    end
    local function set_breakpoint()
      require("dap").set_breakpoint(nil, nil, vim.fn.input("Comment (empty if none): "))
    end
    local function step_into()
      local dap = require("dap")
      local notify = require("notify")

      if dap.session() == nil then
        notify.notify("No active debug session", "error", notify_opts)
      else
        notify.notify("Trying to go deeper in current statement", "info", notify_opts)
        dap.step_into()
      end
    end
    local function step_out()
      local dap = require("dap")
      local notify = require("notify")

      if dap.session() == nil then
        notify.notify("No active debug session", "error", notify_opts)
      else
        notify.notify("Trying to go out of current statement", "info", notify_opts)
        dap.step_out()
      end
    end
    local function step_over()
      local dap = require("dap")
      local notify = require("notify")

      if dap.session() == nil then
        notify.notify("No active debug session", "error", notify_opts)
      else
        notify.notify("Going one step forward", "info", notify_opts)
        dap.step_over()
      end
    end
    local function step_back()
      local dap = require("dap")
      local notify = require("notify")

      if dap.session() == nil then
        notify.notify("No active debug session", "error", notify_opts)
      else
        notify.notify("Going one step backward", "info", notify_opts)
        dap.step_back()
      end
    end
    local function run_to_cursor()
      local dap = require("dap")
      local notify = require("notify")

      if dap.session() == nil then
        notify.notify("No active debug session", "error", notify_opts)
      else
        notify.notify("Continue execution until current cursor line", "info", notify_opts)
        dap.run_to_cursor()
      end
    end

    local wk = require("which-key")

    wk.add({
      { "<leader>d", group = "DAP" },
      { "<leader>dc", continue, desc = "Continue until breakpoint" },
      { "<leader>dC", reverse_continue, desc = "Reverse until breakpoint" },
      { "<leader>dp", pause, desc = "Pause debug session" },
      { "<leader>dr", restart, desc = "Restart debug session" },
      { "<leader>dl", run_last, desc = "Start last debug session config" },
      { "<leader>ds", start, desc = "Start a new debug session" },
      { "<leader>dS", stop, desc = "Stop debug session" },
      { "<leader>di", step_into, desc = "Go into function/method" },
      { "<leader>do", step_out, desc = "Go out function/method" },
      { "<leader>dn", step_over, desc = "Go one step below" },
      { "<leader>dN", step_back, desc = "Go back one step" },
      { "<leader>dg", goto_, desc = "Go to specific line" },
      { "<leader>db", group = "Breakpoints" },
      {
        "<leader>dbt",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "Toggle breakpoint on cursor",
      },
      { "<leader>dbs", set_breakpoint, desc = "Add breakpoint on cursor" },
      {
        "<leader>dbl",
        function()
          require("dap").list_breakpoints()
        end,
        desc = "List breakpoints",
      },
      { "<leader>dbc", run_to_cursor, desc = "Run to cursor (skip breakpoints)" },
      {
        "<leader>dbC",
        function()
          require("dap").clear_breakpoints()
        end,
        desc = "Run to cursor (skip breakpoints)",
      },
      { "<leader>du", group = "DAP UI" },
      {
        "<leader>dut",
        function()
          require("dapui").toggle()
        end,
        desc = "Toggle DAP UI",
      },
      { "<leader>duo", open, desc = "Show DAP UI" },
      { "<leader>duc", close, desc = "Hide DAP UI" },
      {
        "<leader>dur",
        function()
          require("dapui").open({ reset = true })
        end,
        desc = "Reset DAP UI",
      },
    })
  end,
}
