---@tag telescope-ghq
---@config { ["module"] = "telescope-ghq" }
---@brief [[
--- `telescope-ghq.nvim` is an extension that integrates the ghq repository manager with telescope.nvim.
--- You can configure `telescope-ghq` the same way you would configure any other telescope built-in picker.nvim`.
---
--- This is the default configuration:
--- <code>
--- require("telescope").setup({
---   extensions = {
---     ghq = {
---       quiet = false,
---       bin = "ghq",
---       mappings = {
---         ["i"] = {
---           ["<c-c>"] = require("telescope").extensions.ghq.actions.cd,
---           ["<c-t>"] = require("telescope").extensions.ghq.actions.tcd,
---           ["<c-l>"] = require("telescope").extensions.ghq.actions.lcd,
---         },
---         ["n"] = {
---           ["c"] = require("telescope").extensions.ghq.actions.cd,
---           ["t"] = require("telescope").extensions.ghq.actions.tcd,
---           ["l"] = require("telescope").extensions.ghq.actions.lcd,
---         },
---       },
---       select = require("telescope.builtin").find_files,
---     },
---   },
--- })
--- </code>
---
--- You can configure the telescope theme
--- <code>
--- require("telescope").setup({
---   extensions = {
---     ghq = {
---       theme = "ivy",
---     },
---   },
--- })
--- </code>
---
---
--- To load the extension call telescope.load_extension somewhere after the setup call:
--- <code>
--- require("telescope").load_extension("ghq")
--- </code>
---
--- The extension exports the `ghq` and `actions` modules via telescope extensions:
--- <code>
--- require("telescope").extensions.ghq
--- </code>
--- - `ghq`: the main picker of the extension
--- - `actions`: extension actions make accessible for remapping and custom usage
---
--- <pre>
--- To find out more:
--- https://github.com/rcoedo/telescope-ghq.nvim
---
---   :h |telescope-ghq.actions|
--- </pre>
---@brief ]]

local has_telescope, telescope = pcall(require, "telescope")
if not has_telescope then
  error("This extension requires telescope.nvim (https://github.com/nvim-telescope/telescope.nvim)")
end

local pickers = require("telescope.pickers")
local config = require("telescope.config")
local finders = require("telescope.finders")

local ghq_actions = require("telescope._extensions.ghq.actions")
local ghq_config = require("telescope._extensions.ghq.config")

local ghq = function(opts)
  opts = ghq_config.build_picker_opts(opts)

  pickers
    .new(opts, {
      prompt_title = "ghq list",
      finder = finders.new_oneshot_job({ opts.bin, "list", "--full-path" }, opts),
      sorter = config.values.file_sorter(opts),
    })
    :find()
end

local extension = telescope.register_extension({
  setup = ghq_config.setup,
  exports = {
    ghq = ghq,
    actions = ghq_actions,
  },
})

return extension
