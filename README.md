# rcoedo/telescope-ghq.nvim


 `rcoedo/telescope-ghq` is an extension that integrates the [ghq repository manager](https://github.com/x-motemen/ghq) with telescope.nvim.

[telescope.nvim]: https://github.com/nvim-telescope/telescope.nvim
[x-motemen/ghq]: https://github.com/x-motemen/ghq

## Installation

### Lazy

```lua
{
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "rcoedo/telescope-ghq.nvim",
  },
  config = function()
    require("telescope").load_extension("ghq")
  end,
},
```

### Packer

```lua
use({
  "nvim-telescope/telescope.nvim",
  requires = {
    "rcoedo/telescope-ghq.nvim",
  },
  config = function()
    require("telescope").load_extension("ghq")
  end,
}),
```

## Usage

`:Telescope ghq` lists all repositories.

## Examples

### Defaults

`telescope-ghq` has the following default settings:

```lua
require("telescope").setup({
  extensions = {
    ghq = {
      quiet = false,
      bin = "ghq",
      mappings = {
        ["i"] = {
          ["<c-c>"] = require("telescope").extensions.ghq.actions.cd,
          ["<c-t>"] = require("telescope").extensions.ghq.actions.tcd,
          ["<c-l>"] = require("telescope").extensions.ghq.actions.lcd,
        },
        ["n"] = {
          ["c"] = require("telescope").extensions.ghq.actions.cd,
          ["t"] = require("telescope").extensions.ghq.actions.tcd,
          ["l"] = require("telescope").extensions.ghq.actions.lcd,
        },
      },
      select = require("telescope.builtin").find_files,
    },
  },
})
```

### Configuring telescope themes

```lua
require("telescope").setup({
  extensions = {
    ghq = {
      theme = "ivy",
    },
  },
})
```

### Using `git_files` instead of `find_files`

```lua
require("telescope").setup({
  extensions = {
    ghq = {
      select = require("telescope.builtin").git_files,
    },
  },
})
```

### Using a custom select function

```lua
require("telescope").setup({
  extensions = {
    ghq = {
      select = function(opts)
        local selected_dir = opts.cwd
        require("telescope.builtin").git_files({ cwd = selected_dir })
      end,
    },
  },
})
```
