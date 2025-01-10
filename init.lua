require("core.options") -- Load general options
require("core.keymaps") -- Load general keymaps
require("core.snippets") -- Custom code snippets

-- Set up the Lazy plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end
vim.opt.rtp:prepend(lazypath)
-- Set up plugins
require("lazy").setup({
	require("plugins.neotree"),
	require("plugins.colortheme"),
	require("plugins.bufferline"),
	require("plugins.lualine"),
	require("plugins.treesitter"),
	require("plugins.telescope"),
--	require("plugins.lsp"),
	require("plugins.autocompletion"),
	--	require("plugins.none-ls"),
	require("plugins.gitsigns"),
	require("plugins.alpha"),
	require("plugins.indent-blankline"),
	require("plugins.misc"),
	require("plugins.comment"),
})
-- lua/keymaps.lua

-- Map 'jk' to behave like <Esc> in insert mode
vim.keymap.set('i', 'jk', '<Esc>', { noremap = true, silent = true })

--require('floaterm')
-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
--
-- lua/keymaps.lua










-- lua/keymaps.lua

-- Store terminal buffer and window IDs
local terminal_buf = nil  -- Buffer ID for the terminal
local terminal_win = nil  -- Window ID for the floating terminal

-- Function to toggle terminal
local function toggle_terminal()
  if terminal_win and vim.api.nvim_win_is_valid(terminal_win) then
    -- Close the terminal window if it is open
    vim.api.nvim_win_close(terminal_win, true)
    terminal_win = nil  -- Reset the window ID
    -- Do not reset terminal_buf to keep its content
  else
    -- Create a new terminal buffer if not already available
    if not terminal_buf or not vim.api.nvim_buf_is_valid(terminal_buf) then
      terminal_buf = vim.api.nvim_create_buf(false, true)  -- Create an unlisted buffer
    end

    -- Open a floating window with the terminal buffer
    terminal_win = vim.api.nvim_open_win(terminal_buf, true, {
      relative = 'editor',
      width = math.floor(vim.o.columns * 0.8),  -- 80% width
      height = math.floor(vim.o.lines * 0.8),   -- 80% height
      row = math.floor(vim.o.lines * 0.1),      -- Center vertically
      col = math.floor(vim.o.columns * 0.1),    -- Center horizontally
      style = 'minimal',
      border = 'single',  -- Optional: 'single', 'double', 'rounded'
    })

    -- Start terminal in the buffer
    vim.cmd('terminal')  -- Start terminal in the new buffer

    -- Set the buffer as the terminal
    vim.api.nvim_set_current_buf(terminal_buf)  -- Set the terminal buffer as the current buffer

    vim.cmd('startinsert')  -- Switch to insert mode for terminal input

    -- Keymap for closing the terminal while in terminal buffer
    vim.keymap.set('t', '<leader>t', function()
      vim.api.nvim_win_close(terminal_win, true)  -- Close terminal window
      terminal_win = nil  -- Reset the window ID
      -- Do not reset terminal_buf to keep its content
    end, { buffer = terminal_buf, noremap = true, silent = true })
  end
end

-- Keymaps for normal and insert mode to toggle the terminal
vim.keymap.set('n', '<leader>t', toggle_terminal, { noremap = true, silent = true })
--vim.keymap.set('i', '<leader>t', function()
 -- vim.cmd('stopinsert')  -- Exit insert mode first
  --toggle_terminal()
-- end, { noremap = true, silent = true })





-- -- Store terminal buffer and window IDs
-- local terminal_buf = nil  -- Buffer ID for the terminal
-- local terminal_win = nil  -- Window ID for the floating terminal
--
-- -- Function to toggle terminal
-- function _G.toggle_floating_terminal()
--   if terminal_win and vim.api.nvim_win_is_valid(terminal_win) then
--     -- Close the terminal window if it is open
--     vim.api.nvim_win_close(terminal_win, true)
--     terminal_win = nil  -- Reset the window ID
--     -- Do not reset terminal_buf to keep its content
--   else
--     -- Create a new terminal buffer if not already available
--     if not terminal_buf or not vim.api.nvim_buf_is_valid(terminal_buf) then
--       terminal_buf = vim.api.nvim_create_buf(false, true)  -- Create an unlisted buffer
--     end
--
--     -- Open a floating window with the terminal buffer
--     terminal_win = vim.api.nvim_open_win(terminal_buf, true, {
--       relative = 'editor',
--       width = math.floor(vim.o.columns * 0.8),  -- 80% width
--       height = math.floor(vim.o.lines * 0.8),   -- 80% height
--       row = math.floor(vim.o.lines * 0.1),      -- Center vertically
--       col = math.floor(vim.o.columns * 0.1),    -- Center horizontally
--       style = 'minimal',
--       border = 'single',  -- Optional: 'single', 'double', 'rounded'
--     })
--
--     -- Start terminal in the buffer
--     vim.cmd('terminal')  -- Start terminal in the new buffer
--
--     -- Set the buffer as the terminal
--     vim.api.nvim_set_current_buf(terminal_buf)  -- Set the terminal buffer as the current buffer
--
--     vim.cmd('startinsert')  -- Switch to insert mode for terminal input
--
--     -- Keymap for closing the terminal while in terminal buffer
--     vim.keymap.set('t', '<C-_>', function()
--       if terminal_win then
--         vim.api.nvim_win_close(terminal_win, true)  -- Close terminal window
--         terminal_win = nil  -- Reset the window ID
--       end
--     end, { buffer = terminal_buf, noremap = true, silent = true })
--   end
-- end
--
-- -- Keymaps for normal and insert mode to toggle the floating terminal
-- vim.api.nvim_set_keymap('n', '<C-_>', ":lua toggle_floating_terminal()<CR>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('i', '<C-_>', "<Esc>:lua toggle_floating_terminal()<CR>", { noremap = true, silent = true })
--
--









