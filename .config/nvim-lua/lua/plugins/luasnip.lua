local ok, luasnip_loader = pcall(require, 'luasnip.loaders.from_vscode')
if not ok then return end

luasnip_loader.lazy_load()
