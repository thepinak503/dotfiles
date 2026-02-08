-- =============================================================================
-- Neovim Options
-- =============================================================================

local opt = vim.opt
local g = vim.g

-- =============================================================================
-- GENERAL
-- =============================================================================

-- Enable mouse support
opt.mouse = "a"

-- Enable clipboard integration
opt.clipboard = "unnamedplus"

-- Enable hidden buffers
opt.hidden = true

-- Enable persistent undo
opt.undofile = true
opt.undodir = vim.fn.stdpath("data") .. "/undo"

-- Disable swap and backup files
opt.swapfile = false
opt.backup = false
opt.writebackup = false

-- =============================================================================
-- UI
-- =============================================================================

-- Enable true colors
opt.termguicolors = true

-- Show line numbers
opt.number = true
opt.relativenumber = true

-- Show cursor line
opt.cursorline = true

-- Show color column at 80 characters
opt.colorcolumn = "80"

-- Enable sign column
opt.signcolumn = "yes"

-- Minimal number of screen lines to keep above/below cursor
opt.scrolloff = 8
opt.sidescrolloff = 8

-- Show matching brackets
opt.showmatch = true

-- Always show status line
opt.laststatus = 3

-- Show incomplete commands
opt.showcmd = true

-- =============================================================================
-- INDENTATION
-- =============================================================================

-- Use spaces instead of tabs
opt.expandtab = true

-- Set tab width
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2

-- Enable smart indentation
opt.smartindent = true
opt.autoindent = true

-- Enable break indent
opt.breakindent = true

-- =============================================================================
-- SEARCH
-- =============================================================================

-- Enable incremental search
opt.incsearch = true

-- Enable highlight search
opt.hlsearch = true

-- Ignore case in search
opt.ignorecase = true
opt.smartcase = true

-- =============================================================================
-- SPLIT
-- =============================================================================

-- Open splits to the right and below
opt.splitright = true
opt.splitbelow = true

-- =============================================================================
-- COMPLETION
-- =============================================================================

-- Set completeopt
opt.completeopt = { "menu", "menuone", "noselect" }

-- Set shortmess
opt.shortmess:append("c")

-- =============================================================================
-- FOLDING
-- =============================================================================

-- Enable folding
opt.foldenable = true
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldlevel = 99

-- =============================================================================
-- PERFORMANCE
-- =============================================================================

-- Reduce updatetime
opt.updatetime = 300

-- Reduce timeoutlen
opt.timeoutlen = 500

-- Enable lazy redraw
opt.lazyredraw = true

-- =============================================================================
-- WILDMENU
-- =============================================================================

-- Enable wildmenu
opt.wildmenu = true
opt.wildmode = "longest:full,full"
opt.wildignore:append({ "*.pyc", "*.o", "*.obj", "*.swp", "*.class" })

-- =============================================================================
-- GLOBALS
-- =============================================================================

-- Set leader key
g.mapleader = " "
g.maplocalleader = " "

-- Disable netrw
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1
