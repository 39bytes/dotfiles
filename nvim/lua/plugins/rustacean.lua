local disabled_features = {}

local function rust_analyzer_client()
  for _, client in ipairs(vim.lsp.get_clients { bufnr = 0 }) do
    if client.name == 'rust-analyzer' then
      return client
    end
  end
end

local function workspace_features(client)
  local result = vim
    .system({ 'cargo', 'metadata', '--format-version=1', '--no-deps' }, {
      cwd = client.config.root_dir or vim.fn.getcwd(),
      text = true,
    })
    :wait()

  if result.code ~= 0 then
    return nil, vim.trim(result.stderr or 'cargo metadata failed')
  end

  local ok, metadata = pcall(vim.json.decode, result.stdout)
  if not ok then
    return nil, 'Could not parse cargo metadata'
  end

  local members = {}
  for _, id in ipairs(metadata.workspace_members or {}) do
    members[id] = true
  end

  local packages = {}
  for _, package in ipairs(metadata.packages or {}) do
    if members[package.id] then
      table.insert(packages, package)
    end
  end

  local features = {}
  local multiple_packages = #packages > 1
  for _, package in ipairs(packages) do
    for feature in pairs(package.features or {}) do
      -- `default` is an alias, not an independently switchable feature.
      if feature ~= 'default' then
        table.insert(features, multiple_packages and (package.name .. '/' .. feature) or feature)
      end
    end
  end

  table.sort(features)
  return features
end

local function complete_feature(arg_lead)
  local client = rust_analyzer_client()
  if not client then
    return {}
  end

  local features = workspace_features(client) or {}
  return vim.tbl_filter(function(feature)
    return vim.startswith(feature, arg_lead)
  end, features)
end

local function toggle_feature(opts)
  local client = rust_analyzer_client()
  if not client then
    vim.notify('No rust-analyzer client is attached to this buffer', vim.log.levels.ERROR)
    return
  end

  local features, err = workspace_features(client)
  if not features then
    vim.notify(err, vim.log.levels.ERROR)
    return
  end

  local feature = opts.args
  if not vim.tbl_contains(features, feature) then
    vim.notify(('Unknown Cargo feature: %s'):format(feature), vim.log.levels.ERROR)
    return
  end

  local disabled = disabled_features[client.id] or {}
  disabled_features[client.id] = disabled
  disabled[feature] = not disabled[feature] or nil

  local enabled = vim.tbl_filter(function(item)
    return not disabled[item]
  end, features)
  local has_disabled_features = next(disabled) ~= nil

  client.config.settings = client.config.settings or {}
  local settings = client.config.settings
  settings['rust-analyzer'] = settings['rust-analyzer'] or {}
  local rust_analyzer = settings['rust-analyzer']
  rust_analyzer.cargo = rust_analyzer.cargo or {}
  rust_analyzer.cargo.allFeatures = nil
  rust_analyzer.cargo.features = has_disabled_features and enabled or 'all'
  rust_analyzer.cargo.noDefaultFeatures = has_disabled_features

  client:notify('workspace/didChangeConfiguration', { settings = settings })
  vim.notify(('%s Cargo feature: %s'):format(disabled[feature] and 'Disabled' or 'Enabled', feature))
end

return {
  'mrcjkb/rustaceanvim',
  version = '^6', -- Recommended
  lazy = false,
  init = function()
    vim.g.rustaceanvim = {
      server = {
        default_settings = {
          ['rust-analyzer'] = {
            cargo = {
              features = 'all',
            },
          },
        },
      },
    }

    vim.api.nvim_create_user_command('RustToggleFeature', toggle_feature, {
      nargs = 1,
      complete = complete_feature,
      desc = 'Toggle a Cargo feature for rust-analyzer',
    })
  end,
}
