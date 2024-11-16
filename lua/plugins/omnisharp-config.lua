local suppressed_diagnostics = {
  'IDE0008', -- Verwende explizite Typen statt var
  'IDE0058', -- Der Ausdruckwert wird niemals verwendet
  'IDE0072', -- Der Ausdruckwert wird niemals verwendet
  'CA1707', -- Variablennamen dürfen keine Unterstriche enthalten
}

local function filter_diagnostics(diagnostic)
  for _, code in ipairs(suppressed_diagnostics) do
    if diagnostic.code == code then
      return false -- Suppress this diagnostic
    end
  end
  return true -- Keep other diagnostics
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

-- Advertise snippet support to LSP
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Include additional completion capabilities for better integration with completion plugins (e.g., nvim-cmp)
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

return {
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    -- Optionally disable certain features of OmniSharp that may interfere with snippets
    -- For example, disabling semantic tokens if needed:
    client.server_capabilities.semanticTokensProvider = nil

    -- Set key bindings for snippets (using luasnip, not OmniSharp)
    vim.api.nvim_buf_set_keymap(bufnr, 'i', '<C-k>', "<cmd>lua require'luasnip'.expand_or_jump()<CR>", { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(bufnr, 's', '<C-k>', "<cmd>lua require'luasnip'.expand_or_jump()<CR>", { noremap = true, silent = true })

    -- Enable omnisharp completion if needed
    require('cmp_nvim_lsp').default_capabilities(capabilities)
  end,
  handlers = {
    ['textDocument/publishDiagnostics'] = function(_, result, ctx, config)
      if result.diagnostics then
        -- Apply filtering by removing diagnostics with code 'IDE0009'
        result.diagnostics = vim.tbl_filter(filter_diagnostics, result.diagnostics)
      end
      -- Call the default handler after filtering
      vim.lsp.diagnostic.on_publish_diagnostics(_, result, ctx, config)
    end,
  },
  settings = {
    -- https://github.com/OmniSharp/omnisharp-roslyn/wiki/Configuration-Options
    msbuild = {
      enabled = true,
      ToolsVersion = nil,
      VisualStudioVersion = nil,
      Configuration = nil,
      Platform = nil,
      EnablePackageAutoRestore = false,
      MSBuildExtensionsPath = nil,
      TargetFrameworkRootPath = nil,
      MSBuildSDKsPath = nil,
      RoslynTargetsPath = nil,
      CscToolPath = nil,
      CscToolExe = nil,
      loadProjectsOnDemand = false,
      GenerateBinaryLogs = false,
    },
    RoslynExtensionsOptions = {
      documentAnalysisTimeoutMs = 30000,
      enableDecompilationSupport = true,
      enableImportCompletion = true,
      enableAnalyzersSupport = true,
      diagnosticWorkersThreadCount = 8,
      locationPaths = { '//path_to/code_actions.dll' },
      inlayHintsOptions = {
        enableForParameters = true,
        forLiteralParameters = true,
        forIndexerParameters = true,
        forObjectCreationParameters = true,
        forOtherParameters = true,
        suppressForParametersThatDifferOnlyBySuffix = false,
        suppressForParametersThatMatchMethodIntent = false,
        suppressForParametersThatMatchArgumentName = false,
        enableForTypes = true,
        forImplicitVariableTypes = false,
        forLambdaParameterTypes = true,
        forImplicitObjectCreation = true,
      },
    },
  },
}
