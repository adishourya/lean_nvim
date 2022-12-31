---------  ∷ lua-----------
-- Magic line which shaves off ~25-30 ms of startup time
pcall(require,"impatient")
pcall(require,"plugs")
pcall(require,"core")
