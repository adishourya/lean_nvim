-- Dappers
require("mason-nvim-dap").setup({
	ensure_installed = {}
})


-- ┌────────────────────────────────────────────────────────────────────────────────┐
-- │-- "Neovim needs to instruct the debug adapter .. how to launch and connect to t│
-- │he debugee. The debugee is the application you want to debug."                  │
-- └────────────────────────────────────────────────────────────────────────────────┘


local dap_ok, dap = pcall(require, "dap")
if not (dap_ok) then
	print("nvim-dap not installed!")
	return
end

require('dap').set_log_level('INFO') -- Helps when configuring DAP, see logs with :DapShowLog

dap.configurations.go = {
	{
		type = "go", -- Which adapter to use
		name = "Debug", -- Human readable name
		request = "launch", -- Whether to "launch" or "attach" to program
		program = "${file}", -- The buffer you are focused on when running nvim-dap
	},
}


local file = require("plugs.dap_setup.checkFile")
dap.configurations.cpp = {
  {
    name = "C++ Debug And Run",
    type = "codelldb",
    request = "launch",
    program = function()
      -- First, check if exists CMakeLists.txt
      local cwd = vim.fn.getcwd()
      if file.exists(cwd, "CMakeLists.txt") then
        -- Then invoke cmake commands
        -- Then ask user to provide execute file
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
      else
        local fileName = vim.fn.expand("%:t:r")
        -- create this directory
        os.execute("mkdir -p " .. "bin")
        local cmd = "!g++ -g % -o bin/" .. fileName
        -- First, compile it
        vim.cmd(cmd)
        -- Then, return it
        return "${fileDirname}/bin/" .. fileName
      end
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    runInTerminal = true,
    console = "integratedTerminal",
  },
}

-- ┌────────┐
-- │Adapters│
-- └────────┘

dap.adapters.go = {
	type = "server",
	port = "${port}",
	executable = {
		command = vim.fn.stdpath("data") .. '/mason/bin/dlv',
		args = { "dap", "-l", "127.0.0.1:${port}" },
	},
}

-- cpp
dap.adapters.codelldb = {
  type = "server",
  port = "${port}",
  executable = {
		command = vim.fn.stdpath("data") .. '/mason/bin/codelldb',
    args = { "--port", "${port}" },
  }
}
