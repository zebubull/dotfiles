local opt = vim.opt

-- line numbers
opt.relativenumber = true
opt.number = true

-- indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true

-- wrapping
opt.wrap = false

-- search
opt.ignorecase = true
opt.smartcase = true

-- appearance
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"
opt.showmode = false

-- backspace
opt.backspace = "indent,eol,start"

-- clipboard
opt.clipboard:append("unnamedplus")

-- splitting
opt.splitright = true
opt.splitbelow = true

opt.iskeyword:append("-")

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

opt.showtabline = 2

vim.api.nvim_create_autocmd('TermOpen', {
    callback = function(args)
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
    end
})
