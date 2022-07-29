return {
  settings = {
    gopls = {
      gofumpt = true,
      codelenses = {
        generate = false,
        gc_details = true
      },
      usePlaceholders = true,
      analyses = {
        shadow = true,
        unreachable = true,
        unsafeptr = true,
        unusedparams = true,
        unusedvariable = true
      },
      staticcheck = true
    }
  }
}
