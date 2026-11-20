-- Nikso: a GitHub Light High Contrast-inspired colorscheme for Neovim.
-- Palette references:
-- https://github.com/thenikso/nikso-vscode-theme
-- https://github.com/projekt0n/github-nvim-theme
vim.o.termguicolors = true
vim.o.background = "light"
vim.cmd("highlight clear")

if vim.fn.exists("syntax_on") == 1 then
  vim.cmd("syntax reset")
end

vim.g.colors_name = "nikso"

local c = {
  bg = "#ffffff",
  bg_soft = "#e7ecf0",
  bg_hover = "#dff7ff",
  bg_selection = "#0e1116",
  bg_search = "#744500",
  bg_add = "#d2fedb",
  bg_change = "#ffc67b",
  bg_delete = "#fff0ee",
  bg_warning = "#fbf0cb",
  fg = "#0e1116",
  muted = "#4b535d",
  subtle = "#66707b",
  disabled = "#88929d",
  border = "#20252c",
  guide = "#acb6c0",
  blue = "#023b95",
  blue_bright = "#1168e3",
  blue_accent = "#0349b4",
  navy = "#032563",
  red = "#a0111f",
  orange = "#702c00",
  purple = "#622cbc",
  green = "#055d20",
  green_dark = "#024c1a",
  teal = "#1b7c83",
  yellow = "#744500",
  yellow_dark = "#3f2200",
  white = "#ffffff",
}

for index, color in ipairs({
  c.fg,
  c.red,
  c.green,
  c.orange,
  c.blue_accent,
  c.purple,
  c.teal,
  c.subtle,
  c.disabled,
  c.red,
  c.green,
  c.yellow,
  c.blue_bright,
  c.purple,
  c.teal,
  c.white,
}) do
  vim.g["terminal_color_" .. tostring(index - 1)] = color
end

local function set(groups, opts)
  for _, group in ipairs(groups) do
    vim.api.nvim_set_hl(0, group, opts)
  end
end

local function link(groups, target)
  set(groups, { link = target })
end

-- Editor and window chrome.
set({ "Normal", "NormalNC", "MsgArea", "Terminal" }, { fg = c.fg, bg = c.bg })
set({ "NormalFloat", "Pmenu", "PmenuExtra", "PmenuKind" }, { fg = c.fg, bg = c.bg })
set({ "EndOfBuffer", "NonText", "Whitespace", "SpecialKey" }, { fg = c.guide })
set({ "WinSeparator", "VertSplit", "FloatBorder", "PopupMenuBorder" }, { fg = c.border })
set({ "CursorLine", "ColorColumn", "Folded", "FoldColumn" }, { bg = c.bg_soft })
set({ "CursorColumn" }, { bg = c.bg_soft })
set({ "LineNr" }, { fg = c.disabled })
set({ "CursorLineNr" }, { fg = c.blue_accent, bold = true })
set({ "SignColumn" }, { fg = c.disabled, bg = c.bg })
set({ "Visual", "VisualNOS" }, { fg = c.white, bg = c.bg_selection })
set({ "Search", "CurSearch" }, { fg = c.white, bg = c.bg_search })
set({ "IncSearch" }, { fg = c.white, bg = c.orange, bold = true })
set({ "MatchParen" }, { fg = c.blue, bg = c.bg_hover, bold = true })
set({ "PmenuSel" }, { fg = c.fg, bg = c.bg_soft, bold = true })
set({ "PmenuSbar" }, { bg = c.bg_soft })
set({ "PmenuThumb" }, { bg = c.disabled })
set({ "StatusLine", "WinBar" }, { fg = c.fg, bg = c.bg_soft })
set({ "StatusLineNC", "WinBarNC" }, { fg = c.muted, bg = c.bg_soft })
set({ "TabLine" }, { fg = c.muted, bg = c.bg_soft })
set({ "TabLineSel" }, { fg = c.fg, bg = c.bg, bold = true, underline = true, sp = c.orange })
set({ "TabLineFill" }, { bg = c.bg_soft })
set({ "Directory", "Title" }, { fg = c.purple, bold = true })
set({ "Question", "MoreMsg", "ModeMsg" }, { fg = c.green_dark })
set({ "WarningMsg" }, { fg = c.yellow })
set({ "ErrorMsg" }, { fg = c.red, bold = true })
set({ "SpellBad" }, { undercurl = true, sp = c.red })
set({ "SpellCap" }, { undercurl = true, sp = c.blue_accent })
set({ "SpellRare" }, { undercurl = true, sp = c.purple })
set({ "SpellLocal" }, { undercurl = true, sp = c.teal })
set({ "QuickFixLine" }, { bg = c.bg_hover, bold = true })
set({ "Conceal" }, { fg = c.muted })

-- Classic syntax groups.
set({ "Comment" }, { fg = c.muted, italic = true })
set({ "Constant", "Number", "Boolean", "Float" }, { fg = c.blue })
set({ "String", "Character" }, { fg = c.navy })
set({ "Identifier" }, { fg = c.fg })
set({ "Function" }, { fg = c.purple })
set({ "Statement", "Conditional", "Repeat", "Label", "Exception" }, { fg = c.red })
set({ "Keyword", "StorageClass", "Structure", "Typedef" }, { fg = c.red })
set({ "Operator" }, { fg = c.fg })
set({ "Type" }, { fg = c.purple })
set({ "Special", "SpecialChar" }, { fg = c.green })
set({ "Tag" }, { fg = c.green_dark })
set({ "PreProc", "Include", "Define", "Macro", "PreCondit" }, { fg = c.red })
set({ "Underlined" }, { fg = c.blue, underline = true })
set({ "Ignore" }, { fg = c.disabled })
set({ "Error" }, { fg = c.red, undercurl = true, sp = c.red })
set({ "Todo" }, { fg = c.purple, bg = c.bg_hover, bold = true })
set({ "Delimiter", "Punctuation" }, { fg = c.subtle })
set({ "SpecialKey" }, { fg = c.disabled })

-- Treesitter captures, including current and commonly used legacy names.
set({ "@comment", "@comment.documentation" }, { fg = c.muted, italic = true })
set({ "@string", "@string.documentation", "@string.regexp" }, { fg = c.navy })
set({ "@string.escape", "@string.special" }, { fg = c.red })
set({ "@character", "@character.special" }, { fg = c.green })
set({ "@number", "@float", "@boolean", "@constant", "@constant.builtin" }, { fg = c.blue })
set({ "@variable", "@variable.builtin" }, { fg = c.fg })
set({ "@variable.parameter", "@variable.parameter.builtin" }, { fg = c.orange })
set({ "@property", "@field" }, { fg = c.blue })
set({ "@function", "@function.call", "@function.method", "@function.method.call" }, { fg = c.purple })
set({ "@function.builtin", "@constructor" }, { fg = c.purple })
set({ "@method", "@method.call" }, { fg = c.purple })
set({ "@type", "@type.builtin", "@type.definition", "@namespace" }, { fg = c.purple })
set({ "@attribute", "@attribute.builtin", "@tag.attribute" }, { fg = c.purple })
set({ "@keyword", "@keyword.function", "@keyword.return", "@keyword.operator" }, { fg = c.red })
set({ "@conditional", "@repeat", "@exception", "@include", "@preproc" }, { fg = c.red })
set({ "@operator" }, { fg = c.fg })
set({ "@punctuation.bracket", "@punctuation.delimiter", "@punctuation.special" }, { fg = c.subtle })
set({ "@tag", "@tag.builtin" }, { fg = c.green_dark })
set({ "@tag.delimiter" }, { fg = c.subtle })
set({ "@markup.heading", "@markup.heading.1", "@markup.heading.2", "@markup.heading.3", "@markup.heading.4", "@markup.heading.5", "@markup.heading.6" }, { fg = c.blue, bold = true })
set({ "@markup.strong" }, { fg = c.fg, bold = true })
set({ "@markup.italic" }, { fg = c.fg, italic = true })
set({ "@markup.link", "@markup.link.url", "@markup.link.label" }, { fg = c.blue, underline = true })
set({ "@markup.raw", "@markup.raw.block" }, { fg = c.navy, bg = c.bg_soft })
set({ "@markup.list", "@markup.quote" }, { fg = c.muted })
set({ "@diff.plus", "@diff.add" }, { fg = c.green })
set({ "@diff.minus", "@diff.delete" }, { fg = c.red })
set({ "@diff.delta", "@diff.change" }, { fg = c.blue })

-- LSP semantic tokens and diagnostics.
set({ "@lsp.type.class", "@lsp.type.enum", "@lsp.type.interface", "@lsp.type.struct", "@lsp.type.type", "@lsp.type.typeParameter", "@lsp.type.namespace" }, { fg = c.purple })
set({ "@lsp.type.function", "@lsp.type.method" }, { fg = c.purple })
set({ "@lsp.type.parameter" }, { fg = c.orange })
set({ "@lsp.type.property", "@lsp.type.enumMember" }, { fg = c.blue })
set({ "@lsp.type.keyword", "@lsp.type.macro" }, { fg = c.red })
set({ "@lsp.typemod.variable.readonly", "@lsp.typemod.property.readonly" }, { fg = c.blue })
set({ "@lsp.typemod.function.defaultLibrary" }, { fg = c.purple })
set({ "@lsp.typemod.class.abstract" }, { fg = c.purple, italic = true })
set({ "DiagnosticError", "DiagnosticSignError", "DiagnosticFloatingError" }, { fg = c.red })
set({ "DiagnosticWarn", "DiagnosticSignWarn", "DiagnosticFloatingWarn" }, { fg = c.yellow })
set({ "DiagnosticInfo", "DiagnosticSignInfo", "DiagnosticFloatingInfo" }, { fg = c.blue })
set({ "DiagnosticHint", "DiagnosticSignHint", "DiagnosticFloatingHint" }, { fg = c.teal })
set({ "DiagnosticOk", "DiagnosticSignOk" }, { fg = c.green })
set({ "DiagnosticVirtualTextError" }, { fg = c.red, bg = c.bg_delete })
set({ "DiagnosticVirtualTextWarn" }, { fg = c.yellow_dark, bg = c.bg_warning })
set({ "DiagnosticVirtualTextInfo" }, { fg = c.blue, bg = c.bg_hover })
set({ "DiagnosticVirtualTextHint" }, { fg = c.teal, bg = c.bg_soft })
set({ "DiagnosticUnderlineError" }, { undercurl = true, sp = c.red })
set({ "DiagnosticUnderlineWarn" }, { undercurl = true, sp = c.yellow })
set({ "DiagnosticUnderlineInfo" }, { undercurl = true, sp = c.blue })
set({ "DiagnosticUnderlineHint" }, { undercurl = true, sp = c.teal })
set({ "LspReferenceText", "LspReferenceRead", "LspReferenceWrite" }, { bg = c.bg_hover })
set({ "LspInlayHint" }, { fg = c.muted, bg = c.bg_soft, italic = true })
set({ "LspCodeLens" }, { fg = c.muted, italic = true })
set({ "LspSignatureActiveParameter" }, { fg = c.orange, bold = true })

-- Diff, version control, and navigation.
set({ "DiffAdd", "diffAdded" }, { fg = c.green, bg = c.bg_add })
set({ "DiffChange", "diffChanged" }, { fg = c.blue, bg = c.bg_hover })
set({ "DiffDelete", "diffRemoved" }, { fg = c.red, bg = c.bg_delete })
set({ "DiffText" }, { fg = c.fg, bg = c.bg_change, bold = true })
set({ "Added", "GitSignsAdd", "GitSignsAddNr", "GitSignsAddLn" }, { fg = c.green })
set({ "Changed", "GitSignsChange", "GitSignsChangeNr", "GitSignsChangeLn" }, { fg = c.blue })
set({ "Removed", "GitSignsDelete", "GitSignsDeleteNr", "GitSignsDeleteLn" }, { fg = c.red })
set({ "GitSignsCurrentLineBlame" }, { fg = c.muted, italic = true })
set({ "DiffviewFilePanelTitle", "DiffviewFolderName" }, { fg = c.purple, bold = true })
set({ "DiffviewStatusAdded" }, { fg = c.green })
set({ "DiffviewStatusModified" }, { fg = c.orange })
set({ "DiffviewStatusDeleted" }, { fg = c.red })

-- Common completion, picker, file tree, and statusline plugins.
set({ "TelescopeNormal", "TelescopePromptNormal", "TelescopeResultsNormal", "TelescopePreviewNormal" }, { fg = c.fg, bg = c.bg })
set({ "TelescopeBorder", "TelescopePromptBorder", "TelescopeResultsBorder", "TelescopePreviewBorder" }, { fg = c.border, bg = c.bg })
set({ "TelescopeTitle", "TelescopePromptTitle", "TelescopePreviewTitle" }, { fg = c.purple, bold = true })
set({ "TelescopeSelection" }, { fg = c.fg, bg = c.bg_hover })
set({ "TelescopeMatching" }, { fg = c.blue, bold = true })
set({ "CmpItemAbbrMatch", "CmpItemAbbrMatchFuzzy", "BlinkCmpLabelMatch" }, { fg = c.blue, bold = true })
set({ "CmpItemAbbrDeprecated", "BlinkCmpLabelDeprecated" }, { fg = c.muted, strikethrough = true })
set({ "CmpItemKindFunction", "CmpItemKindMethod", "BlinkCmpKindFunction", "BlinkCmpKindMethod" }, { fg = c.purple })
set({ "CmpItemKindVariable", "CmpItemKindField", "CmpItemKindProperty", "BlinkCmpKindVariable", "BlinkCmpKindField", "BlinkCmpKindProperty" }, { fg = c.blue })
set({ "CmpItemKindKeyword", "BlinkCmpKindKeyword" }, { fg = c.red })
set({ "CmpItemKindClass", "CmpItemKindInterface", "CmpItemKindStruct", "BlinkCmpKindClass", "BlinkCmpKindInterface", "BlinkCmpKindStruct" }, { fg = c.purple })
set({ "CmpItemKindSnippet", "BlinkCmpKindSnippet" }, { fg = c.green })
set({ "CmpItemKindText", "BlinkCmpKindText" }, { fg = c.muted })
set({ "NeoTreeNormal", "NeoTreeNormalNC", "NvimTreeNormal", "OilNormal" }, { fg = c.fg, bg = c.bg })
set({ "NeoTreeDirectoryIcon", "NeoTreeDirectoryName", "NvimTreeFolderIcon", "NvimTreeFolderName", "OilDir" }, { fg = c.blue })
set({ "NeoTreeGitAdded", "NvimTreeGitNew", "OilCreate" }, { fg = c.green })
set({ "NeoTreeGitModified", "NvimTreeGitDirty", "OilChange" }, { fg = c.orange })
set({ "NeoTreeGitDeleted", "NvimTreeGitDeleted", "OilDelete" }, { fg = c.red })
set({ "NeoTreeGitConflict" }, { fg = c.red, bold = true })
set({ "WhichKey", "WhichKeyGroup" }, { fg = c.purple })
set({ "WhichKeyDesc" }, { fg = c.fg })
set({ "WhichKeySeparator", "WhichKeyBorder" }, { fg = c.border })
set({ "LazyNormal", "MasonNormal", "TroubleNormal", "SnacksNormal" }, { fg = c.fg, bg = c.bg })
set({ "LazyButton", "MasonHeader", "TroubleTitle", "SnacksPickerTitle" }, { fg = c.purple, bold = true })
set({ "LazyButtonActive", "SnacksPickerCursorLine" }, { fg = c.fg, bg = c.bg_hover, bold = true })
set({ "NoiceCmdlinePopup", "NoicePopup", "NotifyBackground" }, { fg = c.fg, bg = c.bg })
set({ "NoiceCmdlinePopupBorder", "NoicePopupBorder", "NotifyBorder" }, { fg = c.border, bg = c.bg })
set({ "MiniStatuslineModeNormal" }, { fg = c.white, bg = c.blue, bold = true })
set({ "MiniStatuslineModeInsert" }, { fg = c.white, bg = c.green, bold = true })
set({ "MiniStatuslineModeVisual" }, { fg = c.white, bg = c.purple, bold = true })
set({ "MiniStatuslineModeCommand" }, { fg = c.white, bg = c.orange, bold = true })
set({ "IblIndent", "IndentBlanklineChar" }, { fg = c.guide })
set({ "IblScope", "IndentBlanklineContextChar" }, { fg = c.disabled })
set({ "FlashLabel" }, { fg = c.white, bg = c.purple, bold = true })
set({ "FlashMatch" }, { fg = c.blue, bg = c.bg_hover })
set({ "FlashCurrent" }, { fg = c.white, bg = c.orange, bold = true })
set({ "BufferLineBufferSelected", "BufferLineTabSelected" }, { fg = c.fg, bg = c.bg, bold = true, underline = true, sp = c.orange })
set({ "BufferLineBufferVisible", "BufferLineTab", "BufferLineTabClose" }, { fg = c.muted, bg = c.bg_soft })
set({ "BufferLineIndicatorSelected" }, { fg = c.orange })
set({ "RenderMarkdownH1", "RenderMarkdownH2", "RenderMarkdownH3", "RenderMarkdownH4", "RenderMarkdownH5", "RenderMarkdownH6" }, { fg = c.purple, bold = true })
set({ "RenderMarkdownCode", "RenderMarkdownCodeInline" }, { fg = c.navy, bg = c.bg_soft })
set({ "RenderMarkdownLink" }, { fg = c.blue, underline = true })
set({ "FidgetTitle" }, { fg = c.purple, bold = true })
set({ "FidgetTask" }, { fg = c.muted })
set({ "DapBreakpoint" }, { fg = c.red })
set({ "DapStopped" }, { fg = c.orange, bold = true })

-- Lualine's default theme lookup uses these mode-specific groups.
set({ "lualine_a_normal", "lualine_a_insert", "lualine_a_visual", "lualine_a_replace", "lualine_a_command" }, { fg = c.white, bg = c.blue, bold = true })
set({ "lualine_b_normal", "lualine_b_insert", "lualine_b_visual", "lualine_b_replace", "lualine_b_command", "lualine_c_normal" }, { fg = c.fg, bg = c.bg_soft })
set({ "lualine_a_inactive", "lualine_b_inactive", "lualine_c_inactive" }, { fg = c.muted, bg = c.bg_soft })

-- Common aliases used by plugins and older Neovim versions.
link({ "Float", "NormalNCFloat" }, "NormalFloat")
link({ "DiagnosticVirtualText" }, "Comment")
link({ "LspDiagnosticsDefaultError" }, "DiagnosticError")
link({ "LspDiagnosticsDefaultWarning" }, "DiagnosticWarn")
link({ "LspDiagnosticsDefaultInformation" }, "DiagnosticInfo")
link({ "LspDiagnosticsDefaultHint" }, "DiagnosticHint")
