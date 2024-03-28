-- Load forge.core modules
local core_modules = {
  'forge.core.options',
  'forge.core.lazy',
  'forge.core.autocmds',
  'forge.core.keymaps',
}

for _, mod in ipairs(core_modules) do
  local ok, err = pcall(require, mod)
  if not ok then
    error(('Error loading %s...\n\n%s'):format(mod, err))
  end
end
