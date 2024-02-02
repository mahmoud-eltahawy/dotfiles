local ts = require('nvim-treesitter.configs')
ts.setup {
  ensure_installed = { "lua", "vim", "vimdoc", "query","rust","python","javascript","typescript" },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}
