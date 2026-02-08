-- =============================================================================
-- Neovim Keymaps
-- =============================================================================

local map = vim.keymap.set

-- =============================================================================
-- GENERAL
-- =============================================================================

-- Clear search highlight
map("n", "<leader>h", ":nohlsearch<CR>", { desc = "Clear highlights" })

-- Save file
map("n", "<C-s>", ":w<CR>", { desc = "Save file" })
map("i", "<C-s>", "<Esc>:w<CR>a", { desc = "Save file" })

-- Quit
map("n", "<C-q>", ":q<CR>", { desc = "Quit" })

-- Better window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Resize windows with arrows
map("n", "<C-Up>", ":resize -2<CR>", { desc = "Decrease height" })
map("n", "<C-Down>", ":resize +2<CR>", { desc = "Increase height" })
map("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease width" })
map("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase width" })

-- Better indenting
map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })

-- Move text up and down
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move text down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move text up" })

-- Stay in indent mode
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move text down" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move text up" })

-- =============================================================================
-- LSP
-- =============================================================================

-- LSP keymaps (will be set up by lspconfig)
map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
map("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
map("n", "gr", vim.lsp.buf.references, { desc = "Go to references" })
map("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
map("n", "K", vim.lsp.buf.hover, { desc = "Hover documentation" })
map("n", "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature help" })
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename" })
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
map("n", "<leader>f", vim.lsp.buf.format, { desc = "Format" })

-- =============================================================================
-- TELESCOPE
-- =============================================================================

map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help tags" })
map("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Recent files" })

-- =============================================================================
-- FILE EXPLORER
-- =============================================================================

map("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle file explorer" })
map("n", "<leader>o", "<cmd>NvimTreeFocus<cr>", { desc = "Focus file explorer" })

-- =============================================================================
-- TERMINAL
-- =============================================================================

map("n", "<leader>t", "<cmd>terminal<cr>", { desc = "Open terminal" })
map("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- =============================================================================
-- BUFFER MANAGEMENT
-- =============================================================================

map("n", "<leader>bd", ":bd<CR>", { desc = "Delete buffer" })
map("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer" })
map("n", "<leader>bp", ":bprevious<CR>", { desc = "Previous buffer" })
