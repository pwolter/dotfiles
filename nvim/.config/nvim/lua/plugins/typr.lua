-- Typing practice
return {
  -- https://github.com/nvzone/typr
  'nvzone/typr',
  dependencies = 'nvzone/volt', -- required UI library
  cmd = { 'Typr', 'TyprStats' }, -- lazy-load on these commands
  opts = {},
}
