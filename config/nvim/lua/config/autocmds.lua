-- =============================================================================
-- Neovim Autocommands
-- =============================================================================

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- =============================================================================
-- GENERAL
-- =============================================================================

-- Highlight on yank
autocmd("TextYankPost", {
  group = augroup("highlight_yank", {}),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Remove trailing whitespace on save
autocmd("BufWritePre", {
  group = augroup("remove_trailing_whitespace", {}),
  command = "%s/\\s\\+$//e",
})

-- =============================================================================
-- FILE TYPES
-- =============================================================================

-- Set indentation for specific file types
autocmd("FileType", {
  group = augroup("filetype_indent", {}),
  pattern = { "python", "java", "kotlin", "c", "cpp" },
  callback = function()
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4
  end,
})

-- Set markdown wrap
autocmd("FileType", {
  group = augroup("markdown_wrap", {}),
  pattern = "markdown",
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
  end,
})

-- =============================================================================
-- TERMINAL
-- =============================================================================

-- Start terminal in insert mode
autocmd("TermOpen", {
  group = augroup("terminal_start", {}),
  command = "startinsert",
})

-- Disable number column in terminal
autocmd("TermOpen", {
  group = augroup("terminal_no_numbers", {}),
  command = "setlocal nonumber norelativenumber",
})

-- =============================================================================
-- UI
-- =============================================================================

-- Resize splits when window is resized
autocmd("VimResized", {
  group = augroup("resize_splits", {}),
  command = "wincmd =",
})

-- =============================================================================
-- GIT
-- =============================================================================

-- Open git commit in insert mode
autocmd("FileType", {
  group = augroup("gitcommit", {}),
  pattern = "gitcommit",
  command = "startinsert",
})
