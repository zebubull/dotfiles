--
-- Built with,
--
--        ,gggg,
--       d8" "8I                         ,dPYb,
--       88  ,dP                         IP'`Yb
--    8888888P"                          I8  8I
--       88                              I8  8'
--       88        gg      gg    ,g,     I8 dPgg,
--  ,aa,_88        I8      8I   ,8'8,    I8dP" "8I
-- dP" "88P        I8,    ,8I  ,8'  Yb   I8P    I8
-- Yb,_,d88b,,_   ,d8b,  ,d8b,,8'_   8) ,d8     I8,
--  "Y8P"  "Y888888P'"Y88P"`Y8P' "YY8P8P88P     `Y8
--

local lush = require('lush')
local hsl = lush.hsl

-- LSP/Linters mistakenly show `undefined global` errors in the spec, they may
-- support an annotation like the following. Consult your server documentation.
local theme = lush(function(injected_functions)
  local sym = injected_functions.sym

  local dark_bg = hsl("#14171A")
  local text = hsl("#E8FAED")
  local black = hsl("#30383E")
  local green = hsl("#5DAF9F")
  local sat_green = hsl("#1CD1AB")
  local bro = hsl("#D29576")
  local sat_bro = hsl("#B27151")
  local red = hsl("#C84D4F")
  local blue = hsl("#A3D3D3")
  local yellow = hsl("#C7DC82")
  local gray = hsl("#C6C1BD")
  local magenta = hsl("#BD5BB9")

  return {
    -- The following are the Neovim (as of 0.8.0-dev+100-g371dfb174) highlight
    -- groups, mostly used for styling UI elements.
    -- Comment them out and add your own properties to override the defaults.
    -- An empty definition `{}` will clear all styling, leaving elements looking
    -- like the 'Normal' group.
    -- To be able to link to a group, it must already be defined, so you may have
    -- to reorder items as you go.
    --
    -- See :h highlight-groups
    --
    Normal         { bg = dark_bg, fg = text }, -- Normal text
    Visual         { bg = green.sa(15).li(30), fg = Normal.bg }, -- Visual mode selection
    Search         { fg = Normal.bg, bg = yellow.da(30).sa(15) }, -- Last search pattern highlighting (see 'hlsearch'). Also used for similar items that need to stand out.
    ColorColumn    { Normal, bg = black}, -- Columns set with 'colorcolumn'
    Conceal        { fg = black.li(30) , bg = black }, -- Placeholder characters substituted for concealed text (see 'conceallevel')
    Cursor         { bg = Normal.fg.da(15), fg = Normal.bg.da(15) }, -- Character under the cursor
    -- CurSearch      { }, -- Highlighting a search pattern under the cursor (see 'hlsearch')
    -- lCursor        { }, -- Character under the cursor when |language-mapping| is used (see 'guicursor')
    -- CursorIM       { }, -- Like Cursor, but used when in IME mode |CursorIM|
    CursorLine     { Cursor, bg = Cursor.bg.li(30).sa(-30) }, -- Screen-line at the cursor, when 'cursorline' is set. Low-priority if foreground (ctermfg OR guifg) is not set.
    CursorColumn   { CursorLine }, -- Screen-column at the cursor, when 'cursorcolumn' is set.
    Directory      { Normal, fg = blue.da(30).sa(30), gui = "bold" }, -- Directory names (and other special names in listings)
    DiffAdd        { bg = Normal.bg, fg = sat_green.ro(-30) }, -- Diff mode: Added line |diff.txt|
    DiffChange     { bg = Normal.bg, fg = magenta.li(15) }, -- Diff mode: Changed line |diff.txt|
    DiffDelete     { bg = Normal.bg, fg = red.sa(30).da(10) }, -- Diff mode: Deleted line |diff.txt|
    DiffText       { bg = DiffDelete.fg, fg = DiffDelete.bg }, -- Diff mode: Changed text within a changed line |diff.txt|
    -- EndOfBuffer    { }, -- Filler lines (~) after the end of the buffer. By default, this is highlighted like |hl-NonText|.
    TermCursor     { Cursor }, -- Cursor in a focused terminal
    TermCursorNC   { Normal }, -- Cursor in an unfocused terminal
    ErrorMsg       { DiffText }, -- Error messages on the command line
    Folded         { bg = Normal.fg, fg = sat_green.da(30).ro(-30) }, -- Line used for closed folds
    FoldColumn     { Folded }, -- 'foldcolumn'
    LineNr         { fg = sat_green.li(5).sa(5), bg = dark_bg}, -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
    SignColumn     { LineNr }, -- Column where |signs| are displayed
    IncSearch      { Search, bg = Search.bg.li(15).sa(-15) }, -- 'incsearch' highlighting; also used for the text replaced with ":s///c"
    -- Substitute     { }, -- |:substitute| replacement text highlighting
    -- LineNrAbove    { }, -- Line number for when the 'relativenumber' option is set, above the cursor line
    -- LineNrBelow    { }, -- Line number for when the 'relativenumber' option is set, below the cursor line
    CursorLineNr   { LineNr }, -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
    CursorLineFold { LineNr, bg = gray.da(40) }, -- Like FoldColumn when 'cursorline' is set for the cursor line
    CursorLineSign { CursorLineFold }, -- Like SignColumn when 'cursorline' is set for the cursor line
    MatchParen     { bg = blue, fg = dark_bg }, -- Character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
    ModeMsg        { Normal, fg = Normal.fg.da(30), gui = "bold" }, -- 'showmode' message (e.g., "-- INSERT -- ")
    MsgArea        { Normal, fg = gray}, -- Area for messages and cmdline
    MsgSeparator   { bg = black, fg = normal.bg }, -- Separator for scrolled messages, `msgsep` flag of 'display'
    MoreMsg        { MsgSeparator, gui = "bold" }, -- |more-prompt|
    VertSplit      { Normal }, -- Column separating vertically split windows
    NonText        { Normal, gui = "bold" }, -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
    NormalFloat    { Normal, fg = sat_green }, -- Normal text in floating windows.
    FloatBorder    { bg = dark_bg, fg = text}, -- Border of floating windows.
    FloatTitle     { NormalFloat, gui = "bold" }, -- Title of floating windows.
    NormalNC       { Normal, fg = Normal.fg.da(15) }, -- normal text in non-current windows
    Pmenu          { Normal }, -- Popup menu: Normal item.
    PmenuSel       { Visual }, -- Popup menu: Selected item.
    -- PmenuKind      { }, -- Popup menu: Normal item "kind"
    -- PmenuKindSel   { }, -- Popup menu: Selected item "kind"
    -- PmenuExtra     { }, -- Popup menu: Normal item "extra text"
    -- PmenuExtraSel  { }, -- Popup menu: Selected item "extra text"
    PmenuSbar      { PmenuSel }, -- Popup menu: Scrollbar.
    PmenuThumb     { PmenuSel, bg = PmenuSel.bg.da(30).sa(15) }, -- Popup menu: Thumb of the scrollbar.
    Question       { Normal, gui = "bold" }, -- |hit-enter| prompt and yes/no questions
    -- QuickFixLine   { }, -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
    SpecialKey     { NormalFloat }, -- Unprintable characters: text displayed differently from what it really is. But not 'listchars' whitespace. |hl-Whitespace|
    -- SpellBad       { }, -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
    -- SpellCap       { }, -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
    -- SpellLocal     { }, -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
    -- SpellRare      { }, -- Word that is recognized by the spellchecker as one that is hardly ever used. |spell| Combined with the highlighting used otherwise.
    StatusLine     { Normal, gui = "bold" }, -- Status line of current window
    -- StatusLineNC   { }, -- Status lines of not-current windows. Note: If this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
    TabLine        { Normal, gui = "italic"}, -- Tab pages line, not active tab page label
    TabLineFill    { Normal }, -- Tab pages line, where there are no labels
    TabLineSel     { Normal, gui = "bold" }, -- Tab pages line, active tab page label
    Title          { FloatTitle }, -- Titles for output from ":set all", ":autocmd" etc.
    VisualNOS      { Visual, bg = Visual.bg.sa(-100) }, -- Visual mode selection when vim is "Not Owning the Selection".
    WarningMsg     { DiffDelete }, -- Warning messages
    Whitespace     { Normal, gui = "bold" }, -- "nbsp", "space", "tab" and "trail" in 'listchars'
    -- Winseparator   { }, -- Separator between window splits. Inherts from |hl-VertSplit| by default, which it will replace eventually.
    WildMenu       { Search }, -- Current match in 'wildmenu' completion
    -- WinBar         { }, -- Window bar of current window
    -- WinBarNC       { }, -- Window bar of not-current windows

    -- Common vim syntax groups used for all kinds of code and markup.
    -- Commented-out groups should chain up to their preferred (*) group
    -- by default.
    --
    -- See :h group-name
    --
    -- Uncomment and edit if you want more specific syntax highlighting.

    Comment        { Normal, fg = gray.da(20) }, -- Any comment

    Constant       { Normal, fg = sat_green.ro(-30).li(30)}, -- (*) Any constant
    String         { Normal, fg = magenta.li(15).sa(-10) }, --   A string constant: "this is a string"
    Character      { String }, --   A character constant: 'c', '\n'
    -- Number         { }, --   A number constant: 234, 0xff
    -- Boolean        { }, --   A boolean constant: TRUE, false
    -- Float          { }, --   A floating point constant: 2.3e10

    Statement      { Normal, fg = yellow.da(20).sa(20) }, -- (*) Any statement
    -- Conditional    { }, --   if, then, else, endif, switch, etc.
    -- Repeat         { }, --   for, do, while, etc.
    -- Label          { }, --   case, default, etc.
    Operator       { Statement, gui = "italic" }, --   "sizeof", "+", "*", etc.
    -- Keyword        { }, --   any other keyword
    -- Exception      { }, --   try, catch, throw

    PreProc        { Normal, fg = magenta.li(60).sa(40) }, -- (*) Generic Preprocessor
    -- Include        { }, --   Preprocessor #include
    -- Define         { }, --   Preprocessor #define
    -- Macro          { }, --   Same as Define
    -- PreCondit      { }, --   Preprocessor #if, #else, #endif, etc.

    Identifier     { Normal, fg = text.ro(-30).sa(20).da(20), gui = "italic" }, -- (*) Any variable name
    Function       { Normal, fg = text.ro(-30).sa(20).da(20), gui = "bold" }, --   Function name (also: methods for classes)

    Type           { Normal, fg = blue.sa(30).da(30), gui = "bold" }, -- (*) int, long, char, etc.
    StorageClass   { Statement, gui = "bold" }, --   static, register, volatile, etc.
    -- Structure      { }, --   struct, union, enum, etc.
    -- Typedef        { }, --   A typedef

    Special        { Normal, fg = sat_bro.li(30).sa(20) }, -- (*) Any special symbol
    -- SpecialChar    { }, --   Special character in a constant
    -- Tag            { }, --   You can use CTRL-] on this
    -- Delimiter      { }, --   Character that needs attention
    -- SpecialComment { }, --   Special things inside a comment (e.g. '\n')
    -- Debug          { }, --   Debugging statements

    Underlined     { Normal, fg = blue.sa(30).da(30), gui = "underline" }, -- Text that stands out, HTML links
    -- Ignore         { }, -- Left blank, hidden |hl-Ignore| (NOTE: May be invisible here in template)
    Error          { fg = Normal.bg, bg = red.sa(10).da(10)}, -- Any erroneous construct
    Todo           { fg = Normal.bg, bg = green.sa(20).li(20).ro(-15)}, -- Anything that needs extra attention; mostly the keywords TODO FIXME and XXX

    -- These groups are for the native LSP client and diagnostic system. Some
    -- other LSP clients may use these groups, or use their own. Consult your
    -- LSP client's documentation.

    -- See :h lsp-highlight, some groups may not be listed, submit a PR fix to lush-template!
    --
    -- LspReferenceText            { } , -- Used for highlighting "text" references
    -- LspReferenceRead            { } , -- Used for highlighting "read" references
    -- LspReferenceWrite           { } , -- Used for highlighting "write" references
    -- LspCodeLens                 { } , -- Used to color the virtual text of the codelens. See |nvim_buf_set_extmark()|.
    -- LspCodeLensSeparator        { } , -- Used to color the seperator between two or more code lens.
    -- LspSignatureActiveParameter { } , -- Used to highlight the active parameter in the signature help. See |vim.lsp.handlers.signature_help()|.

    -- See :h diagnostic-highlights, some groups may not be listed, submit a PR fix to lush-template!
    --
    DiagnosticError            { Normal, fg = red.sa(30), gui = "bold" } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
    DiagnosticWarn             { Normal, fg = yellow.da(30), gui = "bold" } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
    DiagnosticInfo             { Normal, fg = blue.da(30).sa(30).ro(30), gui = "italic" } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
    DiagnosticHint             { Normal, fg = blue.ro(30), gui = "italic" } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
    DiagnosticOk               { Normal, fg = sat_green, gui = "italic bold" } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
    -- DiagnosticVirtualTextError { } , -- Used for "Error" diagnostic virtual text.
    -- DiagnosticVirtualTextWarn  { } , -- Used for "Warn" diagnostic virtual text.
    -- DiagnosticVirtualTextInfo  { } , -- Used for "Info" diagnostic virtual text.
    -- DiagnosticVirtualTextHint  { } , -- Used for "Hint" diagnostic virtual text.
    -- DiagnosticVirtualTextOk    { } , -- Used for "Ok" diagnostic virtual text.
    -- DiagnosticUnderlineError   { } , -- Used to underline "Error" diagnostics.
    -- DiagnosticUnderlineWarn    { } , -- Used to underline "Warn" diagnostics.
    -- DiagnosticUnderlineInfo    { } , -- Used to underline "Info" diagnostics.
    -- DiagnosticUnderlineHint    { } , -- Used to underline "Hint" diagnostics.
    -- DiagnosticUnderlineOk      { } , -- Used to underline "Ok" diagnostics.
    -- DiagnosticFloatingError    { } , -- Used to color "Error" diagnostic messages in diagnostics float. See |vim.diagnostic.open_float()|
    -- DiagnosticFloatingWarn     { } , -- Used to color "Warn" diagnostic messages in diagnostics float.
    -- DiagnosticFloatingInfo     { } , -- Used to color "Info" diagnostic messages in diagnostics float.
    -- DiagnosticFloatingHint     { } , -- Used to color "Hint" diagnostic messages in diagnostics float.
    -- DiagnosticFloatingOk       { } , -- Used to color "Ok" diagnostic messages in diagnostics float.
    -- DiagnosticSignError        { } , -- Used for "Error" signs in sign column.
    -- DiagnosticSignWarn         { } , -- Used for "Warn" signs in sign column.
    -- DiagnosticSignInfo         { } , -- Used for "Info" signs in sign column.
    -- DiagnosticSignHint         { } , -- Used for "Hint" signs in sign column.
    -- DiagnosticSignOk           { } , -- Used for "Ok" signs in sign column.

    -- Tree-Sitter syntax groups.
    --
    -- See :h treesitter-highlight-groups, some groups may not be listed,
    -- submit a PR fix to lush-template!
    --
    -- Tree-Sitter groups are defined with an "@" symbol, which must be
    -- specially handled to be valid lua code, we do this via the special
    -- sym function. The following are all valid ways to call the sym function,
    -- for more details see https://www.lua.org/pil/5.html
    --
    -- sym("@text.literal")
    -- sym('@text.literal')
    -- sym"@text.literal"
    -- sym'@text.literal'
    --
    -- For more information see https://github.com/rktjmp/lush.nvim/issues/109

    -- sym"@text.literal"      { }, -- Comment
    -- sym"@text.reference"    { }, -- Identifier
    -- sym"@text.title"        { }, -- Title
    -- sym"@text.uri"          { }, -- Underlined
    -- sym"@text.underline"    { }, -- Underlined
    -- sym"@text.todo"         { }, -- Todo
    -- sym"@comment"           { }, -- Comment
    -- sym"@punctuation"       { }, -- Delimiter
    -- sym"@constant"          { }, -- Constant
    -- sym"@constant.builtin"  { }, -- Special
    -- sym"@constant.macro"    { }, -- Define
    -- sym"@define"            { }, -- Define
    -- sym"@macro"             { }, -- Macro
    -- sym"@string"            { }, -- String
    -- sym"@string.escape"     { }, -- SpecialChar
    -- sym"@string.special"    { }, -- SpecialChar
    -- sym"@character"         { }, -- Character
    -- sym"@character.special" { }, -- SpecialChar
    -- sym"@number"            { }, -- Number
    -- sym"@boolean"           { }, -- Boolean
    -- sym"@float"             { }, -- Float
    -- sym"@function"          { }, -- Function
    -- sym"@function.builtin"  { }, -- Special
    -- sym"@function.macro"    { }, -- Macro
    sym"@parameter"         { Identifier, gui = "bold italic" }, -- Identifier
    -- sym"@method"            { }, -- Function
    -- sym"@field"             { }, -- Identifier
    -- sym"@property"          { }, -- Identifier
    -- sym"@constructor"       { }, -- Special
    -- sym"@conditional"       { }, -- Conditional
    -- sym"@repeat"            { }, -- Repeat
    -- sym"@label"             { }, -- Label
    -- sym"@operator"          { }, -- Operator
    -- sym"@keyword"           { }, -- Keyword
    -- sym"@exception"         { }, -- Exception
    -- sym"@variable"          { }, -- Identifier
    -- sym"@type"              { }, -- Type
    -- sym"@type.definition"   { }, -- Typedef
    -- sym"@storageclass"      { }, -- StorageClass
    -- sym"@structure"         { }, -- Structure
    -- sym"@namespace"         { }, -- Identifier
    -- sym"@include"           { }, -- Include
    -- sym"@preproc"           { }, -- PreProc
    -- sym"@debug"             { }, -- Debug
    -- sym"@tag"               { }, -- Tag
}
end)

-- Return our parsed theme for extension or use elsewhere.
return theme

-- vi:nowrap
