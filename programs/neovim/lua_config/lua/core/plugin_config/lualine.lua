require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'oceanicnext',
  },
  sections = {
    lualine_a = {
      {
        'filename',
        path = 0,
      }
    }
  }
}
