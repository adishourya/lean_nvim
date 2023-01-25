-- ┌────────────────────────────────────┐
-- │plugins should be loaded before core│
-- └────────────────────────────────────┘
pcall(require, "impatient")
require("plugs")
require("core")
