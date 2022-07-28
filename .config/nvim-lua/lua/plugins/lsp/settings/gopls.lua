return {
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
        shadow = true,
      },
      gofumpt = true,
      staticcheck = true,
      codelenses = {
        gc_details = true,
      }
    },
  },
  -- init_options = {
  --   usePlaceholders = true,
  -- }
}
