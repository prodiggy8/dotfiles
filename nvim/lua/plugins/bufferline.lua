return {
    {
        'akinsho/bufferline.nvim', 
        version = "*", 
        dependencies = {
            'nvim-tree/nvim-web-devicons',
            'moll/vim-bbye',
        },
        config = function()
            bufferline = require('bufferline')
            bufferline.setup({
                options = {
                    mode = 'buffers',
                    themable = true,
                    always_show_bufferline = false,
                    style_preset = {
                        bufferline.style_preset.no_italic,
                        bufferline.style_preset.no_bold,
                    },
                    diagnostics = false,
                    diagnostics_update_in_insert = false,
                    offsets = {
                        {
                            filetype = "neo-tree",
                            text = "Neo-tree",
                            highlight = "Directory",
                            text_align = "left",
                        },
                    }
                }
            })
        end
    }
}
