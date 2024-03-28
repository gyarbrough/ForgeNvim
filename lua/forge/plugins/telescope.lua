return {
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  branch = '0.1.x',

  dependencies = {
    'nvim-lua/popup.nvim',
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope-ui-select.nvim',
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
  },

  config = function()
    local actions = require('telescope.actions')
    require('telescope').setup {
      defaults = {
        git_worktrees = vim.g.git_worktrees,
        prompt_prefix = "   ",
        selection_caret = "|> ",
        windblend = 0,
        color_devicons = true,
        path_display = { 'smart' },
        initial_mode = 'insert',
        selection_strategy = 'reset',
        sorting_strategy = 'ascending',
        layout_strategy = nil,
        layout_config = {},
        set_env = { ["COLORTERM"] = "truecolor" },
        border = {},
        borderchars = {
          prompt = {"━", "┃", "━", "┃", "┏", "┓", "┛", "┗"},
          -- preview = {"━", "┃", "━", "┃", "┏", "┓", "┛", "┗"},
          -- results = {"━", "┃", "━", "┃", "┏", "┓", "┛", "┗"},
          -- prompt = {" ", " ", " ", " ", " ", " ", " ", " "},
          preview = {"─", "│", "─", "│", "┌", "┐", "┘", "└"},
          results = {"─", "│", "─", "│", "┌", "┐", "┘", "└"},
        },
        vimgrep_arguments = {
          'rg',
          '--ignore',
          '--hidden',
          '--color=never',
          '--no-heading',
          '--with-filename',
          '--line-number',
          '--column',
          '--smart-case',
          '--trim',
        },
        mappings = {
          i = {
            ["<C-n>"] = actions.move_selection_next,
            ["<C-p>"] = actions.move_selection_previous,
            ["<C-c>"] = actions.close,
            ["<C-j>"] = actions.cycle_history_next,
            ["<C-k>"] = actions.cycle_history_prev,
            ["<C-q>"] = function(...)
              actions.smart_send_to_qflist(...)
              actions.open_qflist(...)
            end,
            ["<CR>"] = actions.select_default,
          },
          n = {
            ["<C-n>"] = actions.move_selection_next,
            ["<C-p>"] = actions.move_selection_previous,
            ["<C-q>"] = function(...)
              actions.smart_send_to_qflist(...)
              actions.open_qflist(...)
            end,
            q = actions.close,
          },
        },
        file_ignore_patterns = {
          '.git/',
        },
      },
      pickers = {
        find_files = {
          hidden = true,
        },
        live_grep = {
          --@usage don't include the filename in the search results
          only_sort_text = true,
        },
        grep_string = {
          only_sort_text = true,
        },
        buffers = {
          initial_mode = "normal",
          mappings = {
            i = {
              ["<C-d>"] = actions.delete_buffer,
            },
            n = {
              ["dd"] = actions.delete_buffer,
            },
          },
        },
        git_files = {
          hidden = true,
          show_untracked = true,
        },
        planets = {
          show_pluto = true,
          show_moon = true,
        },
        colorscheme = {
          enable_preview = true,
        },
      },
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = 'smart_case',
        },
      },
    }

    -- Enable Telescope extensions if they are installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')

  end,
}
