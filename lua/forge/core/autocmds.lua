local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local cmd = vim.api.nvim_create_user_command
local namespace = vim.api.nvim_create_namespace

-- enables suport for inlay hints with virtual text
  autocmd("LspAttach", {
    group = augroup("LspAttach_inlayhints", { clear = true }),
    callback = function(args)
      if not (args.data and args.data.client_id) then
        return
      end
      local bufnr = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      require("lsp-inlayhints").on_attach(client, bufnr)
    end,
  })

-- Removes any trailing whitespace when saving a file
  autocmd({ "BufWritePre" }, {
    desc = "remove trailing whitespace on save",
    group = augroup("remove trailing whitespace", { clear = true }),
    command = [[%s/\s\+$//e]],
  })

-- gives you a notification upon saving a session
  autocmd({ "User" }, {
    desc = "notify session saved",
    group = augroup("session save", { clear = true }),
    pattern = "SessionSavePost",
    command = "lua vim.notify('Session Saved', 'info')",
  })

-- enables coloring hexcodes and color names in css, jsx, etc.
  autocmd({ "Filetype" }, {
    desc = "activate colorizer",
    pattern = "css,scss,html,xml,svg,js,jsx,ts,tsx,php,vue",
    group = augroup("colorizer", { clear = true }),
    callback = function()
      require("colorizer").attach_to_buffer(0, {
        mode = "background",
        css = true,
      })
    end,
  })

-- disables autocomplete in some filetypes
  autocmd({ "FileType" }, {
    desc = "disable cmp in certain filetypes",
    pattern = "gitcommit,gitrebase,text,markdown",
    group = augroup("cmp_disable", { clear = true }),
    command = "lua require('cmp').setup.buffer { enabled = false}",
  })

vim.on_key(function(char)
  if vim.fn.mode() == "n" then
    local new_hlsearch = vim.tbl_contains({ "<CR>", "n", "N", "*", "#", "?", "/" }, vim.fn.keytrans(char))
    if vim.opt.hlsearch:get() ~= new_hlsearch then vim.opt.hlsearch = new_hlsearch end
  end
end, namespace "auto_hlsearch")

autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  desc = "Check if buffers changed on editor focus",
  group = augroup("checktime", { clear = true }),
  command = "checktime",
})

local terminal_settings_group = augroup("terminal_settings", { clear = true })
-- TODO: drop when dropping support for Neovim v0.9
if vim.fn.has "nvim-0.9" == 1 and vim.fn.has "nvim-0.9.4" == 0 then
  -- HACK: Disable custom statuscolumn for terminals because truncation/wrapping bug
  -- https://github.com/neovim/neovim/issues/25472
  autocmd("TermOpen", {
    group = terminal_settings_group,
    desc = "Disable custom statuscolumn for terminals to fix neovim/neovim#25472",
    callback = function() vim.opt_local.statuscolumn = nil end,
  })
end
autocmd("TermOpen", {
  group = terminal_settings_group,
  desc = "Disable foldcolumn and signcolumn for terinals",
  callback = function()
    vim.opt_local.foldcolumn = "0"
    vim.opt_local.signcolumn = "no"
  end,
})

autocmd("BufWritePre", {
  desc = "Automatically create parent directories if they don't exist when saving a file",
  group = augroup("create_dir", { clear = true }),
  callback = function(event)
    if event.match:match("^%w%w+:[\\/][\\/]") then
      return
    end
    local file = vim.loop.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

autocmd("BufWinEnter", {
  desc = "Make q close help, man, quickfix, dap floats",
  group = augroup("q_close_windows", { clear = true }),
  callback = function(args)
    local buftype = vim.api.nvim_get_option_value("buftype", { buf = args.buf })
    if vim.tbl_contains({ "help", "nofile", "quickfix" }, buftype) and vim.fn.maparg("q", "n") == "" then
      vim.keymap.set("n", "q", "<cmd>close<cr>", {
        desc = "Close window",
        buffer = args.buf,
        silent = true,
        nowait = true,
      })
    end
  end,
})

autocmd("TextYankPost", {
  desc = "Highlight yanked text",
  group = augroup("highlightyank", { clear = true }),
  callback = function() vim.highlight.on_yank() end,
})

  autocmd({ "User", "BufWinEnter" }, {
    desc = "Disable status, tablines, and cmdheight for alpha",
    group = augroup("alpha_settings", { clear = true }),
    callback = function(args)
      if
        (
          (args.event == "User" and args.file == "AlphaReady")
          or (args.event == "BufWinEnter" and vim.api.nvim_get_option_value("filetype", { buf = args.buf }) == "alpha")
        ) and not vim.g.before_alpha
      then
        vim.g.before_alpha = {
          showtabline = vim.opt.showtabline:get(),
          laststatus = vim.opt.laststatus:get(),
          cmdheight = vim.opt.cmdheight:get(),
        }
        vim.opt.showtabline, vim.opt.laststatus, vim.opt.cmdheight = 0, 0, 0
      elseif
        vim.g.before_alpha
        and args.event == "BufWinEnter"
        and vim.api.nvim_get_option_value("buftype", { buf = args.buf }) ~= "nofile"
      then
        vim.opt.laststatus, vim.opt.showtabline, vim.opt.cmdheight =
          vim.g.before_alpha.laststatus, vim.g.before_alpha.showtabline, vim.g.before_alpha.cmdheight
        vim.g.before_alpha = nil
      end
    end,
  })
  autocmd("VimEnter", {
    desc = "Start Alpha when vim is opened with no arguments",
    group = augroup("alpha_autostart", { clear = true }),
    callback = function()
      local should_skip
      local lines = vim.api.nvim_buf_get_lines(0, 0, 2, false)
      if
        vim.fn.argc() > 0 -- don't start when opening a file
        or #lines > 1 -- don't open if current buffer has more than 1 line
        or (#lines == 1 and lines[1]:len() >0) -- don't open the current buffer if it has anything on the first line
        or #vim.tbl_filter(function(bufnr) return vim.bo[bufnr].buflisted end, vim.api.nvim_list_bufs()) >1 -- don't open if any listed buffers
        or not vim.o.modifiable -- don't open if not modifiable
      then
        should_skip = true
      else
        for _, arg in pairs(vim.v.argv) do
          if arg == "-b" or arg == "-c" or vim.startswith(arg, "+") or arg == "-S" then
            should_skip = true
            break
          end
        end
      end
      if should_skip then return end
      require("alpha").start(true)
      vim.schedule(function() vim.cmd.doautocmd "FileType" end)
    end,
  })

-- dont list quickfix buffers
autocmd("FileType", {
  pattern = "qf",
  callback = function()
    vim.opt_local.buflisted = false
  end,
})
