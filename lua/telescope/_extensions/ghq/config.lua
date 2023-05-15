local action_set = require("telescope.actions.set")
local find_files = require("telescope.builtin").find_files

local ghq_actions = require("telescope._extensions.ghq.actions")

local config = {}

config.values = {
  quiet = false,
  bin = "ghq",
  mappings = {
    ["i"] = {
      ["<c-c>"] = ghq_actions.cd,
      ["<c-t>"] = ghq_actions.tcd,
      ["<c-l>"] = ghq_actions.lcd,
    },
    ["n"] = {
      ["c"] = ghq_actions.cd,
      ["t"] = ghq_actions.tcd,
      ["l"] = ghq_actions.lcd,
    },
  },
  select = find_files,
}

config.setup = function(opts)
  config.values = vim.tbl_deep_extend("force", config.values, opts)
end

config.build_picker_opts = function(opts)
  opts = opts or {}

  local picker_opts = config.values.theme and require("telescope.themes")["get_" .. config.values.theme](config.values)
    or vim.deepcopy(config.values)

  picker_opts.bin = vim.fn.expand(picker_opts.bin)

  picker_opts.attach_mappings = function(prompt_bufnr, map)
    if config.values.select then
      action_set.select:replace(function()
        config.values.select({ cwd = ghq_actions.get_selected_dir(prompt_bufnr) })
      end)
    end

    if config.values.attach_mappings then
      config.values.attach_mappings(prompt_bufnr, map)
    end

    if config.values.mappings then
      for mode, tbl in pairs(config.values.mappings) do
        for key, action in pairs(tbl) do
          map(mode, key, action)
        end
      end
    end

    if opts.attach_mappings then
      opts.attach_mappings(prompt_bufnr, map)
    end

    return true
  end

  return picker_opts
end

return config
