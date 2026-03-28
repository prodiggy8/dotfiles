return {
    { 
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        lazy = false,
        opts = {
            integrations = {
                indent_blankline = { enabled = true },
                mini = true,
                neotree = true,
                noice = true,
                notify = true,
                telescope = true,
                treesitter_context = true,
                which_key = true,
            }
        },
        config = function()
            -- load colorscheme
            local t = false 

            local toggle_flavour = function()
                t = not t
                require("catppuccin").setup({
                    flavour = 'mocha',
                    transparent_background = t,
                })

                vim.cmd.colorscheme("catppuccin")
            end
            
            toggle_flavour()

            -- keymaps
            vim.keymap.set('n', '<leader>bg', toggle_flavour, { noremap = true, silent = true })
        end
    },
}
