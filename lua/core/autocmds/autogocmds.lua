local Job = require("plenary.job") 

local function chained_jobs(bufnr,arguments)
  local results = {}
	local cwd = vim.fn.expand(vim.fn.getcwd())
	-- Print Ran on:
  local first_job = Job:new {
		command = "date",
		args={"+File Ran at --> %T"},
		cwd = cwd,
    on_stdout = function(_, line)
      table.insert(results, line)
    end,
    on_stderr = function(_, line)
      table.insert(results, line)
    end,
  }
	
  local second_job = Job:new {
		command = "./AutoGo",
		args=arguments,
		cwd = cwd,
    on_stdout = function(_, line)
      table.insert(results, line)
    end,
    on_stderr = function(_, line)
      table.insert(results, line)
    end,
  }

  local third_job = Job:new {
		command = "rm",
		args={"AutoGo"},
		cwd = cwd,
    on_stdout = function(_, line)
      table.insert(results, line)
    end,
    on_stderr = function(_, line)
      table.insert(results, line)
    end,
  }



  first_job:and_then(second_job)
  second_job:and_then(third_job)

  first_job:sync()
  second_job:wait()
  third_job:wait()

	vim.api.nvim_buf_set_lines(bufnr,0,-1,false,results)
end

local attach_to_buffer = function(bufnr,pattern)
	vim.api.nvim_create_autocmd("BufWritePost",{
		group = vim.api.nvim_create_augroup("RunCode",{clear = true}),
		pattern = pattern or "*.go",
		callback = function ()
			local build_job = Job:new {
				command = "go",
				args = {"build","-o","AutoGo"},
				on_stdout = function(_,data)
					print(data)
				end,
				on_stderr = function(_,data)
					print(data)
				end,
			}
			build_job:start()
			-- By the time you ask for input build operation would be done
			arguments = vim.split(vim.fn.input "./AutoGo args :"," ")
			chained_jobs(bufnr,arguments)
		end,
	})
end

-- User Commands

-- Build my go files on save :: Not really taxing as go is fast to compile
vim.api.nvim_create_user_command("AutoGo", function()
	-- TO switch back to the main window
	local og_win = vim.api.nvim_get_current_win()
	vim.cmd('vsplit')
	vim.cmd('vertical resize 85')
	local win = vim.api.nvim_get_current_win()
	local buf = vim.api.nvim_create_buf(true, true)
	vim.api.nvim_win_set_buf(win, buf)
	-- local bufnr = tonumber(vim.fn.input "Buffer Number:")
	local bufnr = vim.api.nvim_get_current_buf()
	local pattern = vim.fn.input "Enter File/Pattern :"
	-- local cmd = vim.split(vim.fn.input "Command :"," ")
	vim.api.nvim_set_current_win(og_win)
	attach_to_buffer(bufnr,pattern)
end, {})
