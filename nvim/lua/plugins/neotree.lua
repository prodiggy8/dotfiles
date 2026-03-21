return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "nvim-tree/nvim-web-devicons", -- optional, but recommended
        },
        lazy = false, -- neo-tree will lazily load itself
        config = function ()
            require('neo-tree').setup({
                close_if_last_window = true,
                popup_border_style = 'rounded',
                -- Don't sync neo-tree root with vim's cwd (avoids cwd jumping to ~ when
                -- opening files from the tree in a non-git folder like ~/.config/nvim).
                filesystem = {
                    bind_to_cwd = false,
                },
                window = {
                    mappings = {
                        ["l"] = "open",
                        ["h"] = "close_node",
                        ["space"] = "none",
                        ["Y"] = {
                            function(state)
                                local node = state.tree:get_node()
                                local path = node:get_id()
                                vim.fn.setreg("+", path, "c")
                            end,
                            desc = "Copy path to clipboard",
                        },
                    }
                },
                default_component_configs = {
                    indent = {
                        with_markers = false,
                        indent_marker = " ",
                        last_indent_marker = " ",
                        with_expanders = true,
                        expander_collapsed = "",
                        expander_expanded = "",
                        expander_highlight = "NeoTreeExpander",
                    },
                    git_status = {
                        symbols = {
                            unstaged = "󰄱",
                            staged = "󰱒",
                        },
                    },
                },
            })
            
            -- key mappings
            vim.keymap.set('n', '<leader>e', ':Neotree filesystem toggle<CR>', { noremap = true, silent = true })
            vim.keymap.set('n', '<leader>fe', ':Neotree filesystem focus<CR>', { noremap = true, silent = true })
        end
    },
}
