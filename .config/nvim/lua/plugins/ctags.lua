return {
  'ludovicchabant/vim-gutentags',
  config = function()
    vim.g.gutentags_project_root = { '.forceignore', '.sfdx-project.json', '.git' }
    -- g:gutentags_exclude_filetypes
    -- g:gutentags_file_list_command
  end
}
