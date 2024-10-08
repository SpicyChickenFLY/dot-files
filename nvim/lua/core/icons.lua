local icons = {

	listchars = {
		tab = "│  ",
		trail = "·",
		space = " ",
		lead = " ",
		extends = "»",
		precedes = "«",
		nbsp = "×",
	},

	border = {
		rounded_left_filled = "",
		rounded_right_filled = "",
		arrow_left_filled = "",
		arrow_right_filled = "",
		arrow_left = "",
		arrow_right = "",
		sep = "|",
		long_sep = "│",
		corner = "└",
		bottom = "─",
		middle = "├",
	},

	left = "",
	right = "",

	ghost = "󰊠",
	vim = " ",
	star = "★",
	search = " ",
	symlink = "",
	symlink_arrow = "➛",
	bookmark = "",
	close = "󰅖",
	dot = "●",

	status = { pass = "", sync = "", sync_ignored = "", error = "", question = "", watch = "" },

	lazy = {
		ft = "",
		lazy = "󰂠 ",
		loaded = "",
		not_loaded = "",
	},

	-- NOTE: level
	info = "",
	warn = "󰀪",
	error = "",
	hint = "",
	information = "",
	trace = "✎",
	note = "",
	debug = "",
	flame = "",
	test = "",
	perf = "󱫍",

	branch = "󰘬",
	ellipsis = "…",
	line_number = "",
	check = "",
	cross = "",

	empty_file = "",
	file = "",
	file1 = "",
	file2 = "",

	clock = "",
	word = "",

	diff = { add = " ", modified = " ", remove = " " },
	git = {
		unstaged = "✗",
		staged = "✓",
		unmerged = "",
		renamed = "➜",
		untracked = "★",
		deleted = "",
		ignored = "◌",
	},
	folder = {
		arrow_open = "",
		arrow_closed = "",
		default = "",
		open = "",
		empty = "",
		empty_open = "",
		symlink = "",
		symlink_open = "",
	},

	db_icons = {
		mysql = "",
		postgresql = "",
		sqlite = "",
	},

	kind_icons = {
		Array = "󰅪", -- "",
		Boolean = "",
		BreakStatement = "󰙧",
		Call = "󰃷",
		CaseStatement = "󱃙",
		Class = "󰠱", -- "", " ","",
		Color = "",
		Component = "󰮄",
		Constant = "󰏿", -- "", "", "",
		Constructor = "", -- "", " ",
		ContinueStatement = "→",
		Copilot = "",
		Declaration = "󰙠",
		Delete = "󰩺",
		DoStatement = "󰑖",
		Enum = "",
		EnumMember = "", -- "",
		Event = "", -- "",
		Field = "", -- "", "", " ", "",
		File = "", -- "",
		Folder = "",
		ForStatement = "󰑖",
		Fragment = "◮",
		Function = "󰊕", -- "", " ",
		H1Marker = "󰉫", -- Used by markdown treesitter parser
		H2Marker = "󰉬",
		H3Marker = "󰉭",
		H4Marker = "󰉮",
		H5Marker = "󰉯",
		H6Marker = "󰉰",
		Identifier = "󰀫",
		IfStatement = "󰇉",
		Interface = "", -- "",
		Keyword = "", -- "", " ",
		Key = "", -- "", " ",
		List = "󰅪",
		Log = "󰦪",
		Lsp = "",
		Macro = "󰁌",
		MarkdownH1 = "󰉫", -- Used by builtin markdown source
		MarkdownH2 = "󰉬",
		MarkdownH3 = "󰉭",
		MarkdownH4 = "󰉮",
		MarkdownH5 = "󰉯",
		MarkdownH6 = "󰉰",
		Method = "󰆧", -- "𝑚",
		Module = "󰏗", -- "󰕳 ",
		Namespace = "󰅩",
		Null = "󰢤",
		Number = "󰎠", -- , "#",
		Object = "󰅩",
		Operator = "",
		Package = "",
		Pair = "󰅪",
		Parameter = " ",
		Property = "", -- "ﰠ", "", "",
		Reference = "",
		Regex = "",
		Repeat = "󰑖 ",
		Scope = "󰅩",
		Snippet = "󰩫", -- "", "﬌ ",
		Specifier = "󰦪",
		Statement = "󰅩",
		String = "",
		Struct = "", -- "", " ",
		SwitchStatement = "󰺟",
		Text = " ", -- "󰊄", "",
		Type = "",
		TypeAlias = " ",
		TypeParameter = "", -- "", "",
		Unit = "", -- " ",
		Value = "#",
		Variable = "", -- "", "", " ",
		WhileStatement = "󰑖",
	},
}

return icons
