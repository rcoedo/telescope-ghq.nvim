local close = require("telescope.actions").close
local action_state = require("telescope.actions.state")
local from_entry = require("telescope.from_entry")
local transform_mod = require("telescope.actions.mt").transform_mod

---@mod telescope-ghq.actions
---@brief [[
--- The ghq actions are functions that provide file navigation in ghq-managed repositories.
---
--- You can remap actions as follows:
--- <code>
--- require("telescope").setup({
---   extensions = {
---     ghq = {
---       mappings = {
---         ["i"] = {
---           ["<C-c>"] = require("telescope").extensions.ghq.actions.cd,
---           ["<C-d>"] = function(prompt_bufnr)
---             -- your custom function logic here
---           end,
---         },
---       },
---     },
---   },
--- })
--- </code>
---@brief ]]
local actions = setmetatable({}, {
  __index = function(_, k)
    error("Key does not exist for 'telescope-ghq.actions': " .. tostring(k))
  end,
})

---Returns the path for the current selected entry. This action is usually called from other actions.
---@param prompt_bufnr number The prompt bufnr
actions.get_selected_dir = function(prompt_bufnr)
  if prompt_bufnr then
    close(prompt_bufnr)
  end

  return from_entry.path(action_state.get_selected_entry())
end

---Changes the current working directory to the selected repository
---@param prompt_bufnr number The prompt bufnr
actions.cd = function(prompt_bufnr)
  vim.cmd("cd " .. actions.get_selected_dir(prompt_bufnr))
end

---Changes the current working directory to the selected repository for the current window only
---@param prompt_bufnr number The prompt bufnr
actions.lcd = function(prompt_bufnr)
  vim.cmd("lcd " .. actions.get_selected_dir(prompt_bufnr))
end

---Changes the current working directory to the selected repository for the current tab only
---@param prompt_bufnr number The prompt bufnr
actions.tcd = function(prompt_bufnr)
  vim.cmd("tcd " .. actions.get_selected_dir(prompt_bufnr))
end

actions = transform_mod(actions)

return actions
