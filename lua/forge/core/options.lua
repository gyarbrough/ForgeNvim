-- [[ Neovim Options ]]
-- See `:help vim.opt`
-- NOTE: These options can be changed to suit your needs.
-- For more options, see `:help option-list`

local opt = vim.opt
local g = vim.g

-- Set `space` as <Leader>
g.mapleader = ' '
g.maplocalleader = ' '

-- [[ vim.opt ]]
opt.autoindent = true -- Copy indent from current line when starting a new line.
opt.backspace = { 'eol', 'start', 'indent' } -- Change behavior of deleting text in insert mode.
opt.backup = false -- Disable making a backup before overwriting a file.
opt.breakindent = true -- Wrapped lines will start with the same indent level.
opt.clipboard = 'unnamedplus' -- Connects Neovim to the system clipboard.
opt.cmdheight = 10 -- Number of lines to use for the command line.
opt.completeopt = { 'menu', 'menuone', 'noselect' } -- List of options for insert mode completions.
opt.cursorline = true -- Highlight the line the cursor is on.
opt.encoding = 'utf-8' -- Set Neovim string encoding.
opt.expandtab = true -- Use spaces for tabs and indents.
opt.fillchars = { eob = ' ' } -- Disables ~ on lines that don't exist.
opt.hlsearch = true -- Highlight all matches for previous search pattern.
opt.ignorecase = true -- Ignore case in search patterns.
opt.inccommand = 'split' -- Preview substitutions in the buffer
opt.laststatus = 3 -- Always shows a status line on only the last window.
opt.list = true -- Enable list mode. Changes how empty characters (tab, space, etc) are displayed.
opt.listchars = {
  tab = '❘-',
  trail = '·',
  lead = '·',
  extends = '»',
  precedes = '«',
  nbsp = '×',
} -- Sets the characters used for list mode.
opt.mouse = 'a' -- Enable mouse support for all modes.
opt.number = true -- Prints line numbers in front of each line.
opt.relativenumber = true -- Line numbers are displayed relative to where the cursor is.
opt.scrolloff = 10 -- Number of lines to display above and below the cursor.
opt.shiftwidth = 2 -- Number of spaces to use for each (auto)indent step.
opt.shortmess:append 'sI' -- Helps avoid hit-enter prompts caused by file messages.
opt.showmode = false -- Disable showing modes in the command line.
opt.signcolumn = 'yes' -- Always display the signcolumn.
opt.smartcase = true -- Override ignorecase if the search pattern contains uppercase characters.
opt.smartindent = true -- Do smart autoindenting when starting a new line.
opt.softtabstop = 2 -- Number of spaces that a <Tab> counts for while editing.
opt.splitbelow = true -- Splitting a window will open new window below the current one.
opt.splitright = true -- Splits windows to the right of the current one.
opt.tabstop = 2 -- Number of spaces that a <Tab> in a file counts for.
opt.termguicolors = true -- Enables 24-bit RGB color in the TUI.
opt.timeoutlen = 300 -- Time in milliseconds to wait for a mapped sequence to complete.
opt.title = true -- Window title will be set to the filename and path.
opt.undofile = true -- Saves undo history when writing a buffer to a file.
opt.whichwrap:append '<,>,[,],h,l'
opt.wrap = false -- Disable wrap for lines longer than the window width.
opt.writebackup = false -- Disable making a backup before overwriting a file.
