local ok, colorizer = pcall(require, 'colorizer')
if not ok then return end

colorizer.setup({
  'css',
  'scss',
  'sass',
  'javascript',
  'html'
})
