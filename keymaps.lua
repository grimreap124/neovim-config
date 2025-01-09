vim.keymap.set(
        'n',
        '<F2>',
        ':Neotree toggle current reveal_force_cwd<CR>',
        { noremap = true, silent = true })

vim.keymap.set(
        { 'n', 'x' },
        '<leader>a',
        '<cmd>lua require("fastaction").code_action()<CR>',
        { buffer = bufnr }
)
