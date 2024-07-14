return {
  'skywind3000/vim-quickui',
  init = function ()
    vim.g.quickui_show_tip = 1
    vim.g.quickui_border_style = 2
    vim.g.quickui_color_scheme = 'gruvbox'
  end,
  config = function ()
    vim.keymap.set('n', '<space><space>', '<Cmd>call quickui#menu#open()<CR>', {
      desc = 'open menu'
    })

    -- clear all the menus
    vim.fn['quickui#menu#reset']()
  end,
}
