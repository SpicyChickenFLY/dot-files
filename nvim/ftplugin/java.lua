local jdk8_path = vim.env.JDK8
local jdk17_path = vim.env.JDK17
local jdk21_path = vim.env.JDK21
local jdk24_path = vim.env.JDK24

-- JDTLS
local jdtls_path = vim.env.JDTLS_PATH
local jdtls_launcher_jar = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")
local jdtls_lombok_jar = jdtls_path .. "/plugins/lombok.jar"
local jdtls_cache_path = jdtls_path .. "/cache"
local jdtls_cache_data = jdtls_cache_path .. "/jdtls-" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local jdtls_config_path = jdtls_path .. "/config_win"
-- Debugger
local debugger_path = vim.env.JAVA_DEBUG_PATH
local debugger_jar = vim.fn.glob(
	debugger_path .. "/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar")
-- Decompiler
local decompiler_path = vim.env.JAVA_DECOMPILER_PATH
local decompiler_jars = vim.split(vim.fn.glob(decompiler_path .. "/server/*.jar"), "\n")

local bundles = { debugger_jar }
vim.list_extend(bundles, decompiler_jars)

local config = {
	cmd = {
		jdk24_path .. "/bin/java",
		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-Xms1g",
		"--add-modules=ALL-SYSTEM",
		"--add-opens", "java.base/java.util=ALL-UNNAMED",
		"--add-opens", "java.base/java.lang=ALL-UNNAMED",
		"-javaagent:" .. jdtls_lombok_jar,
		"-jar", jdtls_launcher_jar,
		"-configuration", jdtls_config_path,
		"-data", jdtls_cache_data,
	},

	-- This is the default if not provided, you can remove it. Or adjust as needed.
	-- One dedicated LSP server & client will be started per unique root_dir
	root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew" }),

	-- Here you can configure eclipse.jdt.ls specific settings
	-- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
	-- for a list of options
	settings = {
		java = {
			runtimes = {
				{ name = "javaSE-8",  path = jdk8_path },
				{ name = "javaSE-17", path = jdk17_path },
				{ name = "javaSE-21", path = jdk21_path },
				{ name = "javaSE-24", path = jdk24_path },
			},
			contentProvider = { preferred = "fernflower" },
			signatureHelp = { enabled = true },
			completion = {
				favoriteStaticMembers = {
					"org.hamcrest.MatcherAssert.assertThat",
					"org.hamcrest.Matchers.*",
					"org.hamcrest.CoreMatchers.*",
					"org.junit.jupiter.api.Assertions.*",
					"java.util.Objects.requireNonNull",
					"java.util.Objects.requireNonNullElse",
					"org.mockito.Mockito.*"
				},
				filteredTypes = {
					"com.sun.*",
					"io.micrometer.shaded.*",
					"java.awt.*",
					"jdk.*",
					"sun.*",
				},
			},
			-- Specify any options for organizing imports
			sources = {
				organizeImports = {
					starThreshold = 9999,
					staticStarThreshold = 9999,
				},
			},
			-- How code generation should act
			codeGeneration = {
				toString = {
					template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}"
				},
				hashCodeEquals = {
					useJava7Objects = true,
				},
				useBlocks = true,
			},
		},
	},

	init_options = { bundles = bundles, },

	on_attach = function(client, bufnr)
		-- 'auto'  try to apply code changes
		-- You can use the `JdtHotcodeReplace` command to trigger it manually
		require("jdtls").setup_dap({
			hotcodereplace = "auto",
			config_overrides = {},
		})
	end
}

require("jdtls").start_or_attach(config)
