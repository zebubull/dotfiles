return {
    {
        '<leader>fm',
        function()
            require('harpoon.mark').add_file()
        end,
        mode = "n",
        desc = 'Mark file',
    },
    {
        '<leader>fu',
        function()
            require('harpoon.ui').toggle_quick_menu()
        end,
        mode = "n",
        desc = 'Open file marks',
    },
}
