return {
    {
        '<A-h>',
        function() require('smart-splits').resize_left(1) end,
        mode = 'n',
    },
    {
        '<A-j>',
        function() require('smart-splits').resize_down(1) end,
        mode = 'n',
    },
    {
        '<A-k>',
        function() require('smart-splits').resize_up(1) end,
        mode = 'n',
    },
    {
        '<A-l>',
        function() require('smart-splits').resize_right(1) end,
        mode = 'n',
    },
    {
        '<C-h>',
        function() require('smart-splits').move_cursor_left() end,
        mode = 'n',
    },
    {
        '<C-j>',
        function() require('smart-splits').move_cursor_down() end,
        mode = 'n',
    },
    {
        '<C-k>',
        function() require('smart-splits').move_cursor_up() end,
        mode = 'n',
    },
    {
        '<C-l>',
        function() require('smart-splits').move_cursor_right() end,
        mode = 'n',
    },
    {
        '<leader><leader>h',
        function() require('smart-splits').swap_buf_left() end,
        mode = 'n',
    },
    {
        '<leader><leader>j',
        function() require('smart-splits').swap_buf_down() end,
        mode = 'n',
    },
    {
        '<leader><leader>k',
        function() require('smart-splits').swap_buf_up() end,
        mode = 'n',
    },
    {
        '<leader><leader>l',
        function() require('smart-splits').swap_buf_right() end,
        mode = 'n',
    },
}
