local actions = require('telescope.actions')
require('telescope').setup({
    pickers = {
        buffers = {
            show_all_buffers = true,
            sort_mru = true,
            mappings = {
                n = {
                    ["<c-d>"] = "delete_buffer",
                },
            }
        }
    }
})
