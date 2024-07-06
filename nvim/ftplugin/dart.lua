local opt = vim.opt;

-- indentation
opt.tabstop = 2
opt.shiftwidth = 2

-- vim.api.nvim_create_autocmd('FileType', {
--     group = vim.api.nvim_create_augroup('FlutterHotReload', {}),
--     pattern = 'dart',
--     callback = function(opts)
--         vim.api.nvim_create_autocmd('BufWritePre', {
--             buffer = opts.buf,
--             command = 'FlutterReload',
--         })
--     end,
-- })
