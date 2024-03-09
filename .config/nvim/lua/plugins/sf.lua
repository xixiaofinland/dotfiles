return {
  'xixiaofinland/sf.nvim',
  branch = 'dev',
  -- dir = '~/projects/sf.nvim',

  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-telescope/telescope.nvim',
  },

  config = function()
    require('sf').setup({

      -- Hotkeys and user commands are enabled for these filetypes
      -- hotkeys_in_filetypes = {
      --   "apex", "sosl", "soql", "javascript", "html"
      -- },

      -- When set to `true`, hotkeys and user commands are only enabled when the file
      -- resides in a sf project folder (i.e. has `.forceignore` or `sfdx-project.json` in the root path)
      -- When set to `false`, filetypes defined in `hotkeys_in_filetypes` have
      -- hotkeys and user commands enabled.
      enable_hotkeys_only_in_sf_project_folder = true,

      -- Define what metadata file names to be listed in `list_md_to_retrieve()` (<leader>ml)
      -- types_to_retrieve = {
      --   "ApexClass",
      --   "ApexTrigger",
      --   "StaticResource",
      --   "LightningComponentBundle"
      -- },
    })
  end
}
