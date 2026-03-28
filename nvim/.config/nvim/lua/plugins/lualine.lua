return {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    dependencies = {
        -- 'folke/noice.nvim',
        -- 'MunifTanjim/nui.nvim',
    },
    config = function ()
        vim.opt.laststatus = 3
        vim.opt.showmode = false
        vim.opt.cmdheight = 0
        
        local function hide_in_width()
            return vim.fn.winwidth(0) > 100
        end
        
        local function get_pretty_path()
            local path = vim.fn.expand('%:~:.')
            local filename = vim.fn.expand('%:t')
      
            if path == '' or path == '.' then return '[No Name]' end
      
            if path == filename then return filename end

            return path
        end

        require('lualine').setup({
            options = {
                theme = 'catppuccin-mocha',
                globalstatus = true,
            },
            sections = {
                lualine_a = { 'mode' },
                lualine_b = { 'branch' },
                lualine_c = {
                    {
                        'diagnostics',
                        symbols = {
                            error = ' ',
                            warn = ' ',
                            info = ' ',
                            hint = ' ',
                        },
                        sources = { 'nvim_diagnostic' },
                        sections = { 'error', 'warn' },
                        colored = false,
                        update_in_insert = false,
                        always_visible = false,
                        cond = hide_in_width
                    },
                    { 'filetype', icon_only = true, separator = '', padding = { left = 1, right = 0 } },
                    { get_pretty_path }
                },
                lualine_x = {
                        { 'searchcount', maxcount = 999, timeout = 500 },
                        {
                            -- command being typed
                            function() return require("noice").api.status.mode.get() end,
                            cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
                        },
                        {
                            -- macro recording
                            function() return require("noice").api.status.command.get() end,
                            cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
                        },
                        {
                            "diff",
                            symbols = {
                                added = " ",
                                modified = " ",
                                removed = " ",
                            },
                            cond = hide_in_width,
                        },
                },
                lualine_y = {
                    'progress',
                    { 'location', padding = { left = 0, right = 1 } },
                },
                lualine_z = { 
                        function() return ' ' .. os.date('%R') end 
                },
            },
            extensions = { 'neo-tree', 'lazy', 'fzf', 'trouble' },
        })
    end,
}
