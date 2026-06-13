return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		dapui.setup()

		dap.listeners.before.attach.dapui_config = function() dapui.open() end
		dap.listeners.before.launch.dapui_config = function() dapui.open() end
		dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
		dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

		-- Native GDB Adapter Configuration
		dap.adapters.gdb = {
			type = "executable",
			command = "arm-none-eabi-gdb",
			args = { "--interpreter=dap" }
		}

		--		dap.configurations.c = {
		--			{
		--				name = "STM32 Debugging",
		--				type = "gdb",
		--				request = "attach",
		--				program = function()
		--					return vim.fn.input("Path to firmware (.elf): ", vim.fn.getcwd() .. "/", "file")
		--				end,
		--				cwd = "${workspaceFolder}",
		--				stopAtBeginningOfMainSubprogram = true,
		--
		--
		--				-- The Magic: Tell GDB to connect to st-util, load the python script, and read the SVD
		--				gdbinit = {
		--					--"target remote :4242",
		--					--"source ~/.config/nvim/svd-gdb.py",
		--					--"svd stm32.svd" -- Looks for 'stm32.svd' in your project root
		--				}
		--			},
		--		}
		--
		--		dap.configurations.cpp = dap.configurations.c
		dap.configurations.c = {
			{
				name = "STM32: Manual Pure GDB",
				type = "gdb",
				request = "launch", -- Crucial: 'launch' keeps GDB alive while empty
				program = function()
					return vim.fn.input("Path to firmware (.elf): ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopAtBeginningOfMainSubprogram = false,
			},
		}
		dap.configurations.cpp = dap.configurations.c

		-- Standard Debugging Keymaps
		vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: Connect/Continue" })
		vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Debug: Step Over" })
		vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Debug: Step Into" })
		vim.keymap.set("n", "<F12>", dap.step_out, { desc = "Debug: Step Out" })
		vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
		vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Debug: Toggle DAP UI Layout" })
	end,
}
