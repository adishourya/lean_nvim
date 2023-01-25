-- Treesitter configuration
-- Parsers must be installed manually via :TSInstall
require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true, -- false will disable the whole extension
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<leader>ti',
      node_incremental = '<leader>tn',
      scope_incremental = '<leader>ts',
      node_decremental = '<leader>tnd',
    },
  },
  indent = {
    -- enable = true,
    enable = false,
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
  },
}

-- luasnip setup
local luasnip = require 'luasnip'
local ts_utils = require("nvim-treesitter.ts_utils")

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
	mapping = cmp.mapping.preset.insert({
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
	}),
	-- In the order of the priority
  sources = {
    { name = "nvim_lsp",entry_filter = function(entry,context) 
			local kind = entry:get_kind()
			local node = ts_utils.get_node_at_cursor():type()
			if node == "arguments" then
				if kind == 6 then --6:correspond to variable
					return true
				else
					return false
				end
			end
		end},
    { name = "gh_issues" },
    { name = "nvim_lua" },
    { name = "path" },
    { name = "luasnip" },
		{ name= "friendly-snippets" },
    { name = "buffer"},
  },


  sorting = {
    -- TODO: Would be cool to add stuff like "See variable names before method names" in rust, or something like that.
    comparators = {
      cmp.config.compare.offset,
      cmp.config.compare.exact,
      cmp.config.compare.score,

      -- copied from cmp-under, but I don't think I need the plugin for this.
      -- I might add some more of my own.
      function(entry1, entry2)
        local _, entry1_under = entry1.completion_item.label:find "^_+"
        local _, entry2_under = entry2.completion_item.label:find "^_+"
        entry1_under = entry1_under or 0
        entry2_under = entry2_under or 0
        if entry1_under > entry2_under then
          return false
        elseif entry1_under < entry2_under then
          return true
        end
      end,

      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  },

	completion ={
		keyword_length =1,
	},
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },

	--
  experimental = {
    -- I like the new menu better! Nice work hrsh7th
    native_menu = false,

    -- Let's play with this for a day or two
    ghost_text = true,
  },
}


-- place this in one of your configuration file(s)
local hop_ok, hop = pcall(require,"hop")
if hop_ok then
	local directions = require('hop.hint').HintDirection
	-- Basics
	vim.keymap.set('', 'f', function()
		hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
	end, {remap=true})
	vim.keymap.set('', 'F', function()
		hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
	end, {remap=true})

	vim.keymap.set('', 't', function()
		hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
	end, {remap=true})
	vim.keymap.set('', 'T', function()
		hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
	end, {remap=true})

	-- Across lines
	vim.keymap.set('', 's', function()
		hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = false })
	end, {remap=true})
	vim.keymap.set('', 'S', function()
		hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = false })
	end, {remap=true})
end
