return function()

    vim.cmd("let g:neo_tree_remove_legacy_commands = 1")

    require("neo-tree").setup({
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
                end
            },
        },
        default_component_configs = {
            name = {
                -- Display trailing slash at end of directories
                trailing_slash = true,
                -- Do not use git status color
                -- use_git_status_colors = false,
            },
            git_status = {
                symbols = {
                    -- Force display git signs
                    added     = "✚",
                    modified  = "",
                    deleted   = "✖",
                    renamed   = "",
                    untracked = "",
                    ignored   = "",
                    unstaged  = "",
                    staged    = "",
                    conflict  = "",
                },
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
                    ["/"] = "fuzzy_finder",
                    ["D"] = "fuzzy_finder_directory",
                    ["#"] = "fuzzy_sorter",
                    ["f"] = "filter_on_submit",
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
                }
            },
        },
        git_status = {
            window = {
                position = "float",
                mappings = {
                    ["A"]  = "git_add_all",
                    ["gu"] = "git_unstage_file",
                    ["a"] = "git_add_file",
                    ["r"] = "git_revert_file",
                    ["c"] = "git_commit",
                    ["p"] = "git_push",
                    ["g"] = "git_commit_and_push",
                }
            }
        }
    })

end
