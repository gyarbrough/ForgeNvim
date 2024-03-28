local map = vim.keymap.set

-- [[ Neo-Tree ]]
map("n", "<leader>nt", "<CMD>Neotree reveal left<CR>", { desc = "Reveal [n]eo[t]ree on the left side of the window" })
map("n", "<leader>nf", "<CMD>Neotree reveal float<CR>", { desc = "Reveal [n]eotree as a [f]loating window" })

-- [[ Telescope ]]
-- See `:help telescope.builtin`
local builtin = require 'telescope.builtin'
map('n', '<leader>sh', builtin.help_tags, { desc = '[s]earch [H]elp' })
map('n', '<leader>sk', builtin.keymaps, { desc = '[s]earch [K]eymaps' })
map('n', '<leader>sf', builtin.find_files, { desc = '[s]earch [F]iles' })
map('n', '<leader>ss', builtin.builtin, { desc = '[s]earch [S]elect Telescope' })
map('n', '<leader>sw', builtin.grep_string, { desc = '[s]earch current [W]ord' })
map('n', '<leader>sg', builtin.live_grep, { desc = '[s]earch by [G]rep' })
map('n', '<leader>sd', builtin.diagnostics, { desc = '[s]earch [D]iagnostics' })
map('n', '<leader>sr', builtin.resume, { desc = '[s]earch [R]esume' })
map('n', '<leader>s.', builtin.oldfiles, { desc = '[s]earch Recent Files ("." for repeat)' })
map('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

-- [[ Plugin Management ]]
map('n', '<leader>L', '<CMD>Lazy<CR>', { desc = 'Open [L]azy plugin manager' })

-- [[ Tab Navigation ]]
map('n', '<leader>tp', ':tabprevious<cr>', { desc = 'Prev tab' })
map('n', '<leader>tn', ':tabnext<cr>', { desc = 'Next tab' })
map('n', '<leader>td', ':tabclose<cr>', { desc = 'Close tab' })

-- [[ Buffer Navigation ]]
map('n', '<leader>bp', ':bprev<cr>', { desc = 'Prev buffer' })
map('n', '<leader>bn', ':bnext<cr>', { desc = 'Next buffer' })
map('n', '<leader>bd', ':bdelete<cr>', { desc = 'Delete buffer' })
