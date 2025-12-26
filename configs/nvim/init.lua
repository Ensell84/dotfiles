pcall(function() vim.loader.enable(true) end)

vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

--vim.o.netrw
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 30
vim.g.netrw_liststyle = 1

vim.o.number = true
vim.o.mouse = 'a'

vim.schedule(function()
	vim.o.clipboard = 'unnamedplus'
end)

vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.updatetime = 250

vim.o.splitright = true
vim.o.splitbelow = true

vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.o.inccommand = 'split'
vim.o.scrolloff = 10

vim.o.wrap = false
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.signcolumn = "yes"

vim.keymap.del('n', 'grt')
vim.keymap.del('n', 'grn')
vim.keymap.del({ 'n', 'x' }, 'gra')
vim.keymap.del('n', 'gri')
vim.keymap.del('n', 'grr')

--vim.keymap.set('n', '<C-p>', '<cmd>cprev<CR>')
--vim.keymap.set('n', '<C-n>', '<cmd>cnext<CR>')

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set('n', '<C-j>', '<C-w><C-j>')
vim.keymap.set('n', '<C-k>', '<C-w><C-k>')

vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<C-d>', '<C-d>zz')

vim.keymap.set({ 'n', 'v', 'x' }, ';', ':')
vim.keymap.set('n', '<leader>e', ':Ex<CR>')

vim.keymap.set('n', '<leader>nt', ':tabnew<CR>')
vim.keymap.set('n', '<leader>c', ':tabclose<CR>')
vim.keymap.set('n', '<C-h>', ':tabprev<CR>')
vim.keymap.set('n', '<C-l>', ':tabnext<CR>')

vim.keymap.set('n', '<M-,>', '<C-o>')

vim.keymap.set('i', '<M-h>', '<C-left>')
vim.keymap.set('i', '<M-l>', '<C-right>')
vim.keymap.set('i', '<M-j>', '<C-o>}')
vim.keymap.set('i', '<M-k>', '<C-o>{')

vim.keymap.set('i', '<M-a>', '<Home>')
vim.keymap.set('i', '<M-e>', '<End>')
vim.keymap.set('i', '<M-BS>', '<C-w>')
vim.keymap.set('i', '<M-d>', '<C-o>dw')

vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)

vim.diagnostic.config({
	float = {
		source = "always",
		border = "rounded",
	},
	signs = true,

	underline = true,
	virtual_text = true,
	update_in_insert = true
})

vim.api.nvim_create_autocmd('TextYankPost', {
	group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out,                            "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	spec = {
		{ "folke/todo-comments.nvim", opts = {},     event = "VeryLazy" },
		{
			"folke/lazydev.nvim",
			ft = "lua",
			opts = {
				library = {
					{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				},
			},
		},
		{
			'projekt0n/github-nvim-theme',
			name = 'github-theme',
			lazy = false,
			priority = 1000,
			config = function()
				require('github-theme').setup()
				vim.cmd('colorscheme github_dark_high_contrast')
			end,
		},
		{
			'lewis6991/gitsigns.nvim',
			opts = {
				signs = {
					add = { text = '+' },
					change = { text = '~' },
					delete = { text = '_' },
					topdelete = { text = '‾' },
					changedelete = { text = '~' },
				}
			},
			event = { "BufReadPost", "BufNewFile" },
		},
		{
			'echasnovski/mini.nvim',
			version = false,
			event = "VeryLazy",
			config = function()
				require('mini.statusline').setup({
					use_icons = true,
				})
				require('mini.statusline').section_location = function()
					return '%2l:%-2v'
				end
			end,
		},
		{ 'williamboman/mason.nvim',  config = true, cmd = 'Mason' },
		{ 'j-hui/fidget.nvim',        opts = {},     event = "LspAttach" },
		{
			'nvim-treesitter/nvim-treesitter',
			build = ':TSUpdate',
			event = { "BufReadPre", "BufNewFile" },
			opts = {
				ensure_installed = { 'bash', 'go', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' },
				sync_install = false,
				auto_install = true,
				highlight = { enable = true },
				indent = { enable = true },
			},
		},
		{
			'saghen/blink.cmp',
			version = '*',
			event = "InsertEnter",
			opts = {
				keymap = {
					preset = "default",
					["<cr>"] = { "accept", "fallback" },
					["<c-b>"] = { "scroll_documentation_up", "fallback" },
					["<c-f>"] = { "scroll_documentation_down", "fallback" },
					["<tab>"] = { "select_next", "snippet_forward", "fallback" },
					["<s-tab>"] = { "select_prev", "snippet_backward", "fallback" },
				},
				cmdline = { enabled = true },

				appearance = {
					nerd_font_variant = 'mono',
				},

				completion = {
					documentation = {
						auto_show = true,
						auto_show_delay_ms = 500,
					},
					menu = {
						auto_show = true,
						draw = {
							columns = {
								{ "label",     "label_description", gap = 1 },
								{ "kind_icon", "kind",              gap = 1 }
							},
							padding = { 0, 0 },
						}
					},
					ghost_text = { enabled = true },
				},
				sources = {
					default = { 'lsp', 'lazydev', 'path', 'snippets', 'buffer' },
					providers = {
						lazydev = {
							name = "LazyDev",
							module = "lazydev.integrations.blink",
							score_offset = 100,
						},
					},
				},

				fuzzy = { implementation = "prefer_rust_with_warning" },
				signature = { enabled = true },
			},
		},
		{
			'nvim-telescope/telescope.nvim',
			dependencies = { 'nvim-lua/plenary.nvim' },
			keys = {
				{ "<leader>f",  function() require("telescope.builtin").find_files() end },
				{ "<M-/>",      function() require("telescope.builtin").live_grep() end },
				{ "<M-b>",      function() require("telescope.builtin").buffers() end },
				{ "<leader>gl", function() require("telescope.builtin").git_commits() end },
				{ "<leader>gb", function() require("telescope.builtin").git_branches() end },
				{ "<leader>gs", function() require("telescope.builtin").git_status() end },
				{ "<leader>\'", function() require("telescope.builtin").marks() end },
				{ "<leader>j",  function() require("telescope.builtin").jumplist() end },
				{ "<leader>\"", function() require("telescope.builtin").registers() end },
			},
			opts = {
				defaults = {
					layout_strategy = "horizontal",
					layout_config = {
						vertical = { width = 0.5 },
						horizontal = { width = 0.9, prompt_position = "top", preview_width = 0.6 },
					},
				},
			},
		},
		{
			'neovim/nvim-lspconfig',
			event = { "BufReadPre", "BufNewFile" },
			config = function()
				vim.lsp.config("*", {
					capabilities = require("blink.cmp").get_lsp_capabilities(),
				})

				vim.lsp.config("gopls", {
					cmd = { "gopls" },
					filetypes = { "go", "gomod", "gowork", "gotmpl" },
					root_dir = function(bufnr, on_dir)
						on_dir(vim.fs.root(bufnr, { "go.work", "go.mod", ".git" }))
					end,
					settings = {
						gopls = {
							analyses = { unusedparams = true },
							staticcheck = true,
							gofumpt = true,
						},
					},
				})

				vim.lsp.enable({ 'lua_ls', 'gopls', 'clangd' })

				vim.api.nvim_create_autocmd('LspAttach', {
					desc = 'lsp actions',
					callback = function(event)
						local map = function(keys, func, desc)
							vim.keymap.set('n', keys, func, { buffer = event.buf, desc = desc })
						end

						local builtin = require('telescope.builtin')
						map('K', vim.lsp.buf.hover)
						map('<M-.>', builtin.lsp_definitions)
						map('gtD', vim.lsp.buf.declaration)
						map('gti', builtin.lsp_implementations)
						map('<M-r>', vim.lsp.buf.rename)
						map('<M-CR>', vim.lsp.buf.code_action)
						map('gtr', builtin.lsp_references)
						map('gtt', builtin.lsp_type_definitions)
						map('gs', builtin.lsp_document_symbols)
						map('gw', builtin.lsp_dynamic_workspace_symbols)

						vim.api.nvim_create_autocmd("BufWritePre", {
							buffer = event.buf,
							callback = function()
								vim.lsp.buf.format({ async = false })
							end,
						})
					end,
				})
			end,
		},
		{
			"folke/trouble.nvim",
			opts = {},
			cmd = "Trouble",
			keys = {
				{ "<leader>tq", "<cmd>Trouble diagnostics toggle<cr>" },
				{ "<leader>td", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>" },
				{ "<leader>ts", "<cmd>Trouble symbols toggle focus=false<cr>" },
				{ "<leader>tr", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>" },
				{ "<leader>tl", "<cmd>Trouble loclist toggle<cr>" },
				{ "<leader>o",  "<cmd>Trouble qflist toggle<cr>" },
			},
		},
		{
			'goolord/alpha-nvim',
			dependencies = { 'nvim-mini/mini.icons' },
			config = function()
				require 'alpha'.setup(require 'alpha.themes.startify'.config)
			end
		},
	},
	checker = { enabled = true },
})
