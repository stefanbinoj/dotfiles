-- Override every RenderMarkdown* highlight group to match GitHub's Primer
-- dark palette. Colors are taken from the github_dark_dimmed palette
-- (projekt0n/github-nvim-theme) so they stay in sync with the theme.
--
-- Applied from lua/plugins/render-markdown.lua after render-markdown.setup().

local M = {}

local function set_hl(group, opts)
	opts.default = false
	vim.api.nvim_set_hl(0, group, opts)
end

function M.apply()
	-- Core palette (github_dark_dimmed)
	local bg           = "#22272e" -- canvas.default        (page bg)
	local code_bg      = "#2d333b" -- canvas.subtle         (code block bg, table alt rows, table head)
	local fg           = "#adbac7" -- fg.default            (body text, headings H1-H5)
	local fg_muted     = "#768390" -- fg.muted              (blockquote text, bullets, H6)
	local fg_subtle    = "#636e7b" -- fg.subtle             (code info text)
	local border       = "#444c56" -- border.default        (table borders, hr, blockquote bar)
	local border_muted = "#373e47" -- border.muted          (unused since heading borders off)
	-- inline code bg: rgba(110,118,129,0.4) over #22272e ≈ #373e47
	local inline_bg    = "#373e47"

	-- Semantic accent colors
	local accent_fg    = "#539bf5" -- accent.fg             (links, note)
	local success_fg   = "#539bf5" -- success.fg            (tip — blue accent)
	local done_fg      = "#b083f0" -- done.fg               (important — purple)
	local attention_fg = "#c69026" -- attention.fg          (warning — yellow)
	local danger_fg    = "#f47067" -- danger.fg             (caution — red)

	-- Headings: semibold body color, no border, transparent bg.
	-- H6 is muted like GitHub's CSS.
	for i = 1, 5 do
		set_hl("RenderMarkdownH" .. i, { fg = fg, bg = bg, bold = true })
		set_hl("RenderMarkdownH" .. i .. "Bg", { fg = fg, bg = bg })
	end
	set_hl("RenderMarkdownH6",     { fg = fg_muted, bg = bg, bold = true })
	set_hl("RenderMarkdownH6Bg",   { fg = fg_muted, bg = bg })

	-- Code blocks
	set_hl("RenderMarkdownCode",         { fg = fg,        bg = code_bg })
	set_hl("RenderMarkdownCodeInline",   { fg = fg,        bg = inline_bg })
	set_hl("RenderMarkdownCodeBorder",   { fg = border,    bg = code_bg })
	set_hl("RenderMarkdownCodeInfo",     { fg = fg_subtle, bg = code_bg })
	set_hl("RenderMarkdownCodeFallback", { fg = fg_muted,  bg = code_bg })

	-- Blockquote
	set_hl("RenderMarkdownQuote", { fg = fg_muted, bg = bg })
	for i = 1, 6 do
		set_hl("RenderMarkdownQuote" .. i, { fg = fg_muted, bg = bg })
	end

	-- Links
	set_hl("RenderMarkdownLink",      { fg = accent_fg, bg = bg })
	set_hl("RenderMarkdownLinkTitle", { fg = accent_fg, bg = bg })
	set_hl("RenderMarkdownWikiLink",  { fg = accent_fg, bg = bg })

	-- Horizontal rule
	set_hl("RenderMarkdownDash", { fg = border, bg = bg })

	-- Tables: head row muted bg + bold, body rows default bg
	set_hl("RenderMarkdownTableHead", { fg = fg, bg = code_bg, bold = true })
	set_hl("RenderMarkdownTableRow", { fg = fg, bg = bg })

	-- Bullets & checkboxes
	set_hl("RenderMarkdownBullet",    { fg = fg_muted,    bg = bg })
	set_hl("RenderMarkdownUnchecked", { fg = fg_muted,    bg = bg })
	set_hl("RenderMarkdownChecked",   { fg = success_fg,  bg = bg })
	set_hl("RenderMarkdownTodo",      { fg = attention_fg, bg = bg })

	-- Callouts (GitHub alert palette: note / tip / important / warning / caution)
	set_hl("RenderMarkdownInfo",    { fg = accent_fg,    bg = bg })
	set_hl("RenderMarkdownSuccess", { fg = success_fg,   bg = bg })
	set_hl("RenderMarkdownHint",    { fg = done_fg,      bg = bg })
	set_hl("RenderMarkdownWarn",    { fg = attention_fg, bg = bg })
	set_hl("RenderMarkdownError",   { fg = danger_fg,    bg = bg })

	-- Sign column / indent / inline highlight
	set_hl("RenderMarkdownSign",            { fg = fg_muted, bg = bg })
	set_hl("RenderMarkdownIndent",          { fg = border,   bg = bg })
	set_hl("RenderMarkdownInlineHighlight", { fg = fg,       bg = "#3a2e0a" }) -- bgColor-attention-muted

	-- Latex (disabled, defined for safety)
	set_hl("RenderMarkdownMath", { fg = fg, bg = code_bg })
end

return M
