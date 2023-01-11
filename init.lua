-- ┌──────────────────────────┐
-- │          ∷ lua          │
-- └──────────────────────────┘


-- ┌─────────────────────────────────────────────────────┐
-- │Magic line which shaves off ~25-30 ms of startup time│
-- └─────────────────────────────────────────────────────┘
pcall(require, "impatient")

-- ┌────────────────────────────────────┐
-- │plugins should be loaded before core│
-- └────────────────────────────────────┘
require("plugs")


-- ┌──────────────────┐
-- │basic VIM settings│
-- └──────────────────┘
require("core")
