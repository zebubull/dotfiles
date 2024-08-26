local mason = require('mason')
local mason_lspconfig = require('mason-lspconfig')
local lspsaga = require('lspsaga')
local lspconfig = require('lspconfig')
local cmp_nvim_lsp = require('cmp_nvim_lsp')

function transform(table, f)
    local out = {}
    for k, v in pairs(table) do
        out[k] = f(v)
    end
    return out
end

local lsp_on_attach = function(ev)
    local keymap = vim.keymap

    local bufnr = ev.buf
    local opts = { noremap = true, silent = true, buffer = bufnr }

    keymap.set("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", opts)
    keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts)
    keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)
    keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts)
    keymap.set("n", "<leader>d", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)
    keymap.set("n", "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts)
    keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
    keymap.set("n", "[D", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
    keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
end

local lua_settings = {
    Lua = {
        diagnostics = {
            globals = { "vim" },
        },
        workspace = {
            library = {
                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                [vim.fn.stdpath("config") .. "/lua"] = true,
            }
        }
    }
}

local lsps = {
    { 'gopls' },
    { 'rust_analyzer' },
    { 'clangd' },
    { 'zls' },
    { 'lua_ls', settings = lua_settings },
}

mason.setup()
mason_lspconfig.setup({
    ensure_installed = transform(lsps, function(s) return s[1] end),
})

lspsaga.setup({
    move_in_saga = { prev = '<C-k>', next = '<C-j>' },
    finder_action_keys = { open = '<CR>' },
    definition_action_keys = { edit = '<CR>' },
    ui = {
        code_action = '!',
    },
})

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = lsp_on_attach,
})

-- used for autocompletion
local capabilities = cmp_nvim_lsp.default_capabilities()

for _, server in pairs(lsps) do
    if server.settings ~= nil then
        lspconfig[server[1]].setup({
            capabilities = capabilities,
            settings = server.settings,
        })
    else
        lspconfig[server[1]].setup({
            capabilities = capabilities,
        })
    end
end
