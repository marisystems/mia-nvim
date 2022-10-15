langs =
{
	'pyright',
	'rust_analyzer',
	'clangd',
	'gopls',
	'sumneko_lua',
}

for i, langs in ipairs(langs) do
	require('lspconfig')[langs].setup{}
end
