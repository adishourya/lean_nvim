---------  ∷ lua-----------
-- Magic line which shaves off ~25-30 ms of startup time
require("impatient")

local plugins_loaded, err = pcall(require,"plugs")
if not plugins_loaded then vim.notify(string.format("Error loading plugins:\n%s", err), vim.log.levels.ERROR) end

local core_loaded, core_err = pcall(require,"core")
if not core_loaded then vim.notify(string.format("Error loading Core Defaults:\n%s", core_err), vim.log.levels.ERROR) end
