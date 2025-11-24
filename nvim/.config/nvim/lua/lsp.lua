-- NATIVE LSP
--------------------------------------------------------------------------------

local lsp = vim.lsp

-- Run formatting before saving the buffer im.lsp.buf.formatting is deprecated.
-- Use vim.lsp.buf.format { async = true } instead
vim.api.nvim_command([[
    autocmd BufWritePre *.rs,*.js,*.jsx,*.ts,*.tsx lua vim.lsp.buf.format()
]])

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = true,
  severity_sort = true,
  float = {
    border = 'rounded',
    source = 'always',
  },
})

-------------------------------------------------------------------------------
-- LANGUAGE SERVERS CONFIGURATION
-------------------------------------------------------------------------------

local schemastore = require('schemastore')
lsp.config['biome'] = {
  cmd = { 'biome', 'lsp-proxy' },
  filetypes = {
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
    'json',
    'jsonc',
    'css',
    'vue',
    'astro',
    'svelte'
  },
  root_markers = {
    'biome.json',
    'biome.jsonc',
    'package.json',
    '.git'
  },
  single_file_support = true,
  settings = {
    biome = {
      -- Enable formatting
      formatter = {
        enabled = true,
        formatOnSave = true,
        indentStyle = "space",
        indentSize = 2,
        lineWidth = 80
      },
      -- Enable linting
      linter = {
        enabled = true,
        rules = {
          recommended = true
        }
      },
      -- Enable code actions
      codeAction = {
        enabled = true
      }
    }
  }
}
lsp.config['cssls'] = {
  cmd = { 'vscode-css-language-server', '--stdio' },
  filetypes = { 'css', 'scss', 'less' },
  root_markers = { 'package.json', '.git' },
  settings = {
    css = {
      validate = true,
      lint = {
        unknownAtRules = "ignore"
      }
    },
    scss = {
      validate = true,
      lint = {
        unknownAtRules = "ignore"
      }
    },
    less = {
      validate = true,
      lint = {
        unknownAtRules = "ignore"
      }
    }
  }
}
lsp.config['docker_compose_language_service'] = {
  cmd = { 'docker-compose-langserver', '--stdio' },
  filetypes = { 'yaml.docker-compose', 'yaml' },
  root_markers = { 'docker-compose.yml', 'docker-compose.yaml', 'compose.yml', 'compose.yaml' },
  settings = {}
}
lsp.config['dotenv-linter'] = {
  cmd = { 'dotenv-linter', '--stdin' },
  filetypes = { 'dotenv' },
  root_markers = { '.env', '.env.local', '.env.development', '.env.production' },
  settings = {}
}
lsp.config['graphql'] = {
  cmd = { 'graphql-lsp', 'server', '-m', 'stream' },
  filetypes = { 'graphql', 'gql', 'typescriptreact', 'javascriptreact' },
  root_markers = { '.graphqlrc', '.graphqlrc.json', 'package.json', '.git' },
  settings = {}
}
lsp.config['jsonls'] = {
  cmd = { 'vscode-json-language-server', '--stdio' },
  filetypes = { 'json', 'jsonc' },
  root_markers = { 'package.json', '.git' },
  settings = {
    json = {
      schemastore.json.schemas(),
      validate = { enable = true }
    }
  }
}
lsp.config['lua_ls'] = {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = { { '.luarc.json', '.luarc.jsonc' }, '.git' },
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
        -- Disable the missing-fields warning
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
      completion = {
        callSnippet = "Replace"
      },
      hint = {
        enable = true,
      },
    },
  },
}
lsp.config['rust_analyzer'] = {
  cmd = { 'rust-analyzer' },
  filetypes = { 'rust' },
  root_markers = { 'Cargo.toml', 'rust-project.json', '.git' },
}
lsp.config['tailwindcss'] = {
  cmd = { 'tailwindcss-language-server', '--stdio' },
  root_markers = {
    'tailwind.config.js',
    'tailwind.config.cjs',
    'tailwind.config.ts',
    'tailwind.config.tsx',
    'tailwind.config.json',
    'tailwind.config.mjs',
    'package.json' -- fallback for npm projects
  },
  filetypes = {
    'html',
    'css',
    'scss',
    'sass',
    'postcss',
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
    'vue',
    'svelte',
    'astro',
    'jsx',
    'tsx'
  },
  settings = {
    tailwindCSS = {
      classAttributes = { "class", "className", "classList", "ngClass" },
      lint = {
        cssConflict = "warning",
        invalidApply = "error",
        invalidConfigPath = "error",
        invalidScreen = "error",
        invalidTailwindDirective = "error",
        invalidVariant = "error",
        recommendedVariantOrder = "warning"
      },
      validate = true
    }
  }
}
lsp.config['vtsls'] = {
  cmd = { 'vtsls', '--stdio' },
  root_markers = {
    'package.json',
    'tsconfig.json',
    'jsconfig.json',
    '.git'
  },
  filetypes = {
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
    'vue'
  },
  settings = {
    complete_function_calls = true,
    vtsls = {
      enableMoveToFileCodeAction = true,
      autoUseWorkspaceTsdk = true,
      experimental = {
        completion = {
          enableServerSideFuzzyMatch = true,
        },
      },
    },
    typescript = {
      updateImportsOnFileMove = { enabled = "always" },
      suggest = {
        completeFunctionCalls = true,
      },
      inlayHints = {
        enumMemberValues = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        parameterNames = { enabled = "literals" },
        parameterTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        variableTypes = { enabled = false },
      },
    },
    javascript = {
      updateImportsOnFileMove = { enabled = "always" },
      suggest = {
        completeFunctionCalls = true,
      },
      inlayHints = {
        enumMemberValues = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        parameterNames = { enabled = "literals" },
        parameterTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        variableTypes = { enabled = false },
      },
    },
  },
}
lsp.config['yamlls'] = {
  cmd = { 'yaml-language-server', '--stdio' },
  filetypes = { 'yaml', 'yml' },
  root_markers = { '.yamllint', '.yamllint.yml', 'package.json', '.git' },
  settings = {
    yaml = {
      schemas = schemastore.yaml.schemas(),
      validate = true,
      completion = true,
      hover = true
    }
  }
}
lsp.config['taplo'] = {
  cmd = { 'taplo', 'lsp', 'stdio' },
  filetypes = { 'toml' },
  root_markers = { 'Cargo.toml', 'pyproject.toml', '.git' },
  settings = {
    taplo = {
      configFile = {
        enabled = true
      },
      schema = {
        enabled = true,
        catalogs = {
          "https://www.schemastore.org/api/json/catalog.json"
        }
      }
    }
  }
}
lsp.config['bashls'] = {
  cmd = { 'bash-language-server', 'start' },
  filetypes = { 'sh', 'bash' },
  root_markers = { '.git' },
  single_file_support = true,
  settings = {
    bashIde = {
      globPattern = "**/*@(.sh|.inc|.bash|.command)"
    }
  }
}

lsp.enable(require('lsp-list'))
