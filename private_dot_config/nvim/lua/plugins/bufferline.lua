return function()

    local signs = require("plugins.signs")

    require("bufferline").setup({
        options = {
            -- Only show buffers, set to "tabs" to only show tabpages instead
            mode = "buffers",
            -- Show buffer id and number
            -- numbers = "both",
            -- Selected buffer style
            indicator = {
                style = "underline",
            },
            -- Trunc too long names
            truncate_names = true,
            -- Use to retrieve diagnostics
            diagnostics = "nvim_lsp",
            -- Do not update diagnostics while in insert mode
            diagnostics_update_in_insert = false,
            -- Text to translate diagnostics informations
            diagnostics_indicator = function(_, _, diagnostics_dict, _)
                local diagnostics = {
                    error = 0,
                    warning = 0,
                    info = 0,
                    hint = 0,
                }
                local s = ""

                for e, n in pairs(diagnostics_dict) do
                    diagnostics[e] = diagnostics[e] + n
                end

                if (diagnostics.error ~= 0) then
                    s = s .. diagnostics.error .. signs.diagnostics.error .. " "
                end
                if (diagnostics.warning ~= 0) then
                    s = s .. diagnostics.warning .. signs.diagnostics.warning .. " "
                end
                if (diagnostics.info ~= 0) then
                    s = s .. diagnostics.info .. signs.diagnostics.info .. " "
                end
                if (diagnostics.hint ~= 0) then
                    s = s .. diagnostics.hint .. signs.diagnostics.hint .. " "
                end

                return s
            end,
            offsets = {
                -- Set an offset so it ignore the neo-tree window
                {
                    filetype = "neo-tree",
                    text = "File Explorer",
                    fg = "#ff0000",
                    text_align = "center",
                    separator = true,
                },
            },
            -- Show prefix on duplicated names
            show_duplicate_prefix = true,
            -- Use colors on filetype icons
            color_icons = true,
            -- Style of the separators
            separator_style = "slant",
            highlights = {
                separator_selected = {
                    fg = "#ffd43b",
                    bg = "#ffd43b",
                },
                separator_visible = {
                    fg = "#ffd43b",
                },
                separator = {
                    fg = "#ffd43b",
                },
            },
            groups = {
                items = {
                    {
                        name = "Tests",
                        highlight = {
                            underline = true,
                            sp = "green",
                        },
                        auto_close = true,
                        priority = 1,
                        icon = "",
                        matcher = function(buf)
                            return buf.name:match("%_test") or buf.name:match("%_spec")
                        end,
                    },
                    {
                        name = "Config",
                        highlight = {
                            underline = true,
                            sp = "grey",
                        },
                        auto_close = true,
                        priority = 2,
                        matcher = function(buf)
                            return buf.name:match("%.json") or buf.name:match("%.yml") or buf.name:match("%.yaml")
                        end,
                    },
                    {
                        name = "Docs",
                        highlight = {
                            underline = true,
                            sp = "lightblue",
                        },
                        auto_close = true,
                        priority = 3,
                        icon = "󰙏",
                        matcher = function(buf)
                            return buf.name:match("%.md") or buf.name:match("%.txt")
                        end,
                    },
                },
            },
        },
    })

end
