-- Save the local require here
local require = require

local ok, plenary_reload = pcall(require, "plenary.reload")
local reloader = require
if ok then
  reloader = plenary_reload.reload_module
end

P = function(v)
  print(vim.inspect(v))
  return v
end

RELOAD = function(...)
  local ok, plenary_reload = pcall(require, "plenary.reload")
  if ok then
    reloader = plenary_reload.reload_module
  end

  return reloader(...)
end

R = function(name)
  RELOAD(name)
  return require(name)
end

vim.api.nvim_create_autocmd('BufWrite', {
  pattern = '*.scm',
  callback = function()
    print('scm cache cleaned!');
    require 'nvim-treesitter.query'.invalidate_query_cache('apex');
  end,
})
