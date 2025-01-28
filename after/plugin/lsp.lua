local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({buffer = bufnr})
end)

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {},
  handlers = {
    lsp_zero.default_setup,
  },
})


local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

cmp.setup({
  mapping = cmp.mapping.preset.insert({
    -- `Enter` key to confirm completion
    ['<CR>'] = cmp.mapping.confirm({select = false}),

    -- Ctrl+Space to trigger completion menu
    ['<C-Space>'] = cmp.mapping.complete(),
       
    -- Ctrl + vim to move through autocomplete selections
    [ '<C-j>' ]   = cmp.mapping.select_next_item(),
    [ '<C-k>' ]   = cmp.mapping.select_prev_item(),

    -- Navigate between snippet placeholder
    ['<C-f>'] = cmp_action.luasnip_jump_forward(),
    ['<C-b>'] = cmp_action.luasnip_jump_backward(),

    -- Scroll up and down in the completion documentation
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
  })
})

-- Highlight entire line for errors
-- Highlight the line number for warnings
local config = {
    virtual_text = true,
    signs = {
        active = signs, 
    },

    update_in_insert = true,
    underline = true,
    severity_sort = true,

    float = {
        focusable = true,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
    },
}

-- Remove existing autocommand
-- vim.api.nvim_create_augroup("float_diagnostic", { clear = true })

-- Set the update time for diagnostics (no change here)
vim.o.updatetime = 250


-- Define the keybinding to open the diagnostic float window
vim.keymap.set('n', '<leader>pe', function()
        vim.diagnostic.open_float(nil, { 
            focus = false
        })
    end, 
    { 
        noremap = true,
        silent = true,
    }
)

-- Bind <leader>d to open the Telescope diagnostics window
vim.keymap.set("n", "<leader>pd", "<cmd>Telescope diagnostics<CR>", { 
    desc = "Open diagnostics with Telescope" 
})

vim.diagnostic.config(config)

