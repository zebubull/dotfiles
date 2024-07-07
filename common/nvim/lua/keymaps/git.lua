return {
    {
        '[c',
        '<Cmd>Gitsigns next_hunk<CR>',
        mode = "n",
        desc = 'Goto next hunk',
    },
    {
        ']c',
        '<Cmd>Gitsigns prev_hunk<CR>',
        mode = "n",
        desc = 'Goto previous hunk',
    },
    {
        '<leader>hs',
        '<Cmd>Gitsigns stage_hunk<CR>',
        mode = "n",
        desc = "Stage hunk",
    },
    {
        '<leader>hr',
        '<Cmd>Gitsigns reset_hunk<CR>',
        mode = "n",
        desc = "Reset hunk",
    },
    {
        '<leader>hS',
        '<Cmd>Gitsigns stage_buffer<CR>',
        mode = "n",
        desc = "Stage buffer",
    },
    {
        '<leader>hu',
        '<Cmd>Gitsigns undo_stage_hunk<CR>',
        mode = "n",
        desc = "Undo stage hunk",
    },
    {
        '<leader>hR',
        '<Cmd>Gitsigns reset_buffer<CR>',
        mode = "n",
        desc = "Reset buffer",
    },
    {
        '<leader>hp',
        '<Cmd>Gitsigns preview_hunk<CR>',
        mode = "n",
        desc = "Preview_hunk",
    },
    {
        '<leader>hB',
        '<Cmd>Gitsigns toggle_current_line_blame<CR>',
        mode = "n",
        desc = "Toggle blame"
    },
    {
        '<leader>hd',
        '<Cmd>Gitsigns diffthis<CR>',
        mode = "n",
        desc = "Show diff"
    },
    {
        '<leader>td',
        '<Cmd>Gitsigns toggle_deleted<CR>',
        mode = "n",
        desc = "Toggle deleted"
    },
}
