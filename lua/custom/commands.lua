local typst_job = nil
local zathura_job = nil

vim.api.nvim_create_user_command('Preview', function()
  local file = vim.api.nvim_buf_get_name(0)
  if not file:match '%.typ$' then
    vim.notify('Preview: current file is not a .typ file', vim.log.levels.ERROR)
    return
  end

  local pdf = file:gsub('%.typ$', '.pdf')

  if typst_job then
    vim.notify('Preview: typst watch already running', vim.log.levels.WARN)
    return
  end

  typst_job = vim.fn.jobstart({ 'typst', 'watch', file }, {
    detach = false,
    on_exit = function()
      typst_job = nil
    end,
  })

  -- Give typst a moment to produce the initial PDF before opening zathura
  vim.defer_fn(function()
    zathura_job = vim.fn.jobstart({ 'zathura', pdf }, {
      detach = false,
      on_exit = function()
        zathura_job = nil
        if typst_job then
          vim.fn.jobstop(typst_job)
          typst_job = nil
        end
        vim.notify 'Preview stopped'
      end,
    })
  end, 500)

  vim.notify('Preview started: ' .. vim.fn.fnamemodify(file, ':t'))
end, { desc = 'Start typst watch + zathura preview for current .typ file' })

vim.api.nvim_create_user_command('PreviewStop', function()
  if typst_job then
    vim.fn.jobstop(typst_job)
    typst_job = nil
  end
  if zathura_job then
    vim.fn.jobstop(zathura_job)
    zathura_job = nil
  end
  vim.notify 'Preview stopped'
end, { desc = 'Stop typst watch and zathura preview' })
