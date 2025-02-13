local opts = {
  plugins = {
    presets = {
      operators = false,
      motions = false,
      text_objects = false,
      nav = true,
      z = true,
      g = true
    }
  }
}

local wk = require('which-key')
wk.setup(opts)
wk.add({
  {
    '<leader>?',
    function()
      wk.show({ global = true })
    end,
    desc = 'Show keymaps',
    -- group = ,
    mode = { 'n', 'v' },
    -- icon = ,
    -- proxy = '',
  },
})
