return {
    {
        "<leader>ff",
        "<cmd>Telescope find_files<CR>",
        desc = "Find file",
        mode = "n",
    },
    {
        "<leader>fb",
        "<cmd>Telescope buffers initial_mode=normal<CR>",
        desc = "Search opne buffers",
        mode = "n"
    },
    {
        "<leader>fs",
        "<cmd> Telescope live_grep<CR>",
        desc = "Search through files",
        mode = "n"
    },
    {
        "<leader>fe",
        "<cmd> Telescope file_browser path=%:p:h select_buffer=true initial_mode=normal<CR>",
        desc = "Search through files",
        mode = "n"
    },
}
