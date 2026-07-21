return {
  'Avi-D-coder/whisper.nvim',
  config = function()
    require('whisper').setup({
      model = 'base.en',
      keybind = '<c-g>',
      manual_trigger_key = '<Enter>',
    })
  end,
  keys = {
    { '<c-g>', mode = {'n','i', 'v'}, desc = 'Toggle speech-to-text' }
  },
}
