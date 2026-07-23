return {
  'Avi-D-coder/whisper.nvim',
  config = function()
    require('whisper').setup({
      model = 'tiny.en',
      on_transcription = function(text)
        vim.notify("Transcribed: " .. text)
      end,
    })
  end,
}
