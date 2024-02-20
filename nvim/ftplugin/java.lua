local jdk8_path = "/usr/local/jdk8"
local jdk17_path = "/usr/local/jdk17"
local jdtls_path = "/usr/local/jdtls"
local jdtls_cache_path = "/home/chow/.cache/jdtls"
local java_debug_path = "/usr/local/java-debug"
local java_decompiler_path = "/usr/local/java-decompiler"

local bundles = {
	vim.fn.glob(java_debug_path .. "/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar", 1),
}
vim.list_extend(bundles, vim.split(vim.fn.glob(java_decompiler_path .. "/server/*.jar", 1), "\n"))

local config = {
	cmd = {
		jdk17_path .. "/bin/java",
		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-Xms1g",
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",
		"-javaagent:" .. jdtls_path .. "/plugins/lombok.jar",
		"-jar",
		jdtls_path .. "/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar",
		"-configuration",
		jdtls_path .. "/config_linux",
		"-data",
		jdtls_cache_path .. "/jdtls-" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t"),
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
				{ name = "javaSE-8", path = jdk8_path },
				{ name = "javaSE-17", path = jdk17_path },
			},
			contentProvider = { preferred = "fernflower" },
		},
	},

	-- Language server `initializationOptions`
	-- You need to extend the `bundles` with paths to jar files
	-- if you want to use additional eclipse.jdt.ls plugins.
	--
	-- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
	--
	-- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
	init_options = {
		bundles = bundles,
	},
}

config["on_attach"] = function(client, bufnr)
	-- With `hotcodereplace = 'auto' the debug adapter will try to apply code changes
	-- you make during a debug session immediately.
	-- Remove the option if you do not want that.
	-- You can use the `JdtHotcodeReplace` command to trigger it manually
	require("jdtls").setup_dap({
		hotcodereplace = "auto",
		config_overrides = {},
	})
	vim.cmd([[ command! JdtRefresh lua require('jdtls.dap').setup_dap_main_class_configs() ]])
end

-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
require("jdtls").start_or_attach(config)
