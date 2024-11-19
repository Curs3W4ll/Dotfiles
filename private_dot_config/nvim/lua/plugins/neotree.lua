return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  event = "VimEnter",
  init = function()
    vim.cmd("let g:neo_tree_remove_legacy_commands = 1")
  end,
  opts = function()
    local inputs = require("neo-tree.ui.inputs")
    local popups = require("neo-tree.ui.popups")
    local events = require("neo-tree.events")

    return {
      -- Used sources
      sources = {
        -- Files explorer
        "filesystem",
        -- Opened uffers
        -- "buffers",
        -- Git status
        "git_status",
        -- LSP symbols
        "document_symbols",
      },
      -- Add a blank line at the top of the tree
      add_blank_line_at_top = true,
      -- Close if the last window is neo-tree
      close_if_last_window = true,
      -- Case insensitive files and directories sorting
      sort_case_insensitive = true,
      -- Display only needed logs
      log_level = "warn",
      -- Do not use predefined mappings
      use_default_mappings = false,
      -- Display sources
      source_selector = {
        -- Display sources on top
        winbar = true,
        sources = {
          -- Files explorer
          {
            source = "filesystem",
          },
          -- Opened uffers
          {
            source = "buffers",
          },
          -- Git status
          {
            source = "git_status",
          },
          -- LSP symbols
          {
            source = "document_symbols",
          },
        },
      },
      events_handlers = {
        -- Clear search after opening a file
        {
          event = "file_opened",
          handler = function(_)
            require("neo-tree.sources.filesystem").reset_search()
          end,
        },
      },
      default_component_configs = {
        name = {
          -- Display trailing slash at end of directories
          trailing_slash = true,
        },
      },
      window = {
        mappings = {
          ["<2-LeftMouse>"] = "open",
          ["<BS>"] = "close_all_subnodes",
          ["<CR>"] = "open",
          ["<ESC>"] = "revert_preview",
          ["<SPACE>"] = {
            "toggle_node",
            nowait = false,
          },
          ["?"] = "show_help",
          -- Switch between tree sources (files, buffers, git status...)
          ["h"] = "prev_source",
          -- Switch between tree sources (files, buffers, git status...)
          ["l"] = "next_source",
          ["C"] = "close_node",
          ["f"] = "focus_preview",
          ["P"] = {
            "toggle_preview",
            config = {
              use_float = true,
            },
          },
          ["q"] = "revert_preview",
          ["r"] = "rename",
          ["R"] = "refresh",
          ["s"] = "open_vsplit",
          ["S"] = "open_split",
          -- ["S"] = "split_with_window_picker", -- TODO: Maybe use this?
          -- ["s"] = "vsplit_with_window_picker", -- TODO: Maybe use this?
          ["t"] = "open_tabnew",
          -- ["w"] = "open_with_window_picker", -- TODO: Maybe use this?
          ["z"] = "close_all_nodes",
          ["Z"] = "expand_all_nodes",
        },
      },
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = true,
          hide_hidden = true,
          hide_by_name = {
            "node_modules/",
            "build/",
          },
          never_show = {
            ".DS_Store",
          },
        },
        -- Always focus current buffer file
        follow_current_file = {
          enabled = true,
        },
        use_libuv_file_watcher = true,
        window = {
          mappings = {
            ["a"] = {
              "add",
              config = {
                -- Show relative path before name
                show_path = "relative",
              },
            },
            ["A"] = {
              "add_directory",
              config = {
                -- Show relative path before name
                show_path = "relative",
              },
            },
            ["c"] = {
              "copy",
              config = {
                -- Show relative path before name
                show_path = "relative",
              },
            },
            ["d"] = "delete",
            ["m"] = {
              "move",
              config = {
                -- Show relative path before name
                show_path = "relative",
              },
            },
            ["p"] = "paste_from_clipboard",
            ["x"] = "cut_to_clipboard",
            ["y"] = "copy_to_clipboard",
            -- Go one directory upper
            ["<"] = "navigate_up",
            -- Go one directory deeper (directory under cursor)
            [">"] = "set_root",
            ["."] = "set_root",
            ["H"] = "toggle_hidden",
            ["F"] = "fuzzy_finder",
            ["D"] = "fuzzy_finder_directory",
            ["#"] = "fuzzy_sorter",
            ["/"] = "filter_on_submit",
            ["<c-x>"] = "clear_filter",
            ["gn"] = "next_git_modified",
            ["gN"] = "prev_git_modified",
          },
          fuzzy_finder_mappings = {
            ["<down>"] = "move_cursor_down",
            ["<C-n>"] = "move_cursor_down",
            ["<up>"] = "move_cursor_up",
            ["<C-p>"] = "move_cursor_up",
          },
        },
      },
      buffers = {
        -- Always focus current buffer file
        follow_current_file = {
          enabled = true,
        },
        group_empty_dirs = false,
        show_unloaded = true,
        window = {
          mappings = {
            ["bd"] = "buffer_delete",
            -- Go one directory upper
            ["<"] = "navigate_up",
            -- Go one directory deeper (directory under cursor)
            [">"] = "set_root",
            ["."] = "set_root",
          },
        },
      },
      git_status = {
        window = {
          position = "float",
          mappings = {
            ["A"] = "git_add_all",
            ["u"] = "git_unstage_file",
            ["a"] = "git_add_file",
            ["r"] = "git_revert_file",
            ["c"] = "git_commit",
            ["p"] = "git_push",
            ["n"] = {
              function()
                local cmd = { "git", "pull" }
                local title = "git pull"

                local result = vim.fn.systemlist(cmd)
                if vim.v.shell_error ~= 0 or (#result > 0 and vim.startswith(result[1], "fatal:")) then
                  popups.alert("ERROR: " .. title, result)
                end

                events.fire_event(events.GIT_EVENT)
                popups.alert(title, result)
              end,
              desc = "git_pull",
            },
            ["b"] = {
              function()
                local width = vim.fn.winwidth(0) - 2
                local row = vim.api.nvim_win_get_height(0) - 3
                local popup_opts = {
                  relative = "win",
                  position = {
                    row = row,
                    col = 0,
                  },
                  size = width,
                }

                inputs.input("Branch name: ", "", function(msg)
                  vim.fn.systemlist({ "git", "pull" })
                  vim.fn.systemlist({ "git", "fetch", "--all" })

                  local cmd = { "git", "branch", msg }
                  local title = "git branch create switch"

                  local result = vim.fn.systemlist(cmd)
                  if vim.v.shell_error ~= 0 or (#result > 0 and vim.startswith(result[1], "fatal:")) then
                    popups.alert("ERROR: " .. title, result)
                  end

                  cmd = { "git", "switch", msg }
                  result = vim.fn.systemlist(cmd)
                  if vim.v.shell_error ~= 0 or (#result > 0 and vim.startswith(result[1], "fatal:")) then
                    popups.alert("ERROR: " .. title, result)
                  end

                  events.fire_event(events.GIT_EVENT)
                  popups.alert(title, result)
                end, popup_opts)
              end,
              desc = "git_branch_create_switch",
            },
          },
        },
      },
    }
  end,
}
