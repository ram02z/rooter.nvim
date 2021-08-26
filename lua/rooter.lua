local M = {}

local current_working_directory
local root_fn

local function get_new_root()
  local root_fn = require("lspconfig").util.root_pattern({
    ".git",
    "go.mod",
    "Cargo.toml",
  })
  local start_path = vim.fn.expand[[%:p:h]]
  local root = root_fn(start_path)
  local gsd = vim.b.gitsigns_status_dict
  if root then
    return root
  elseif gsd and gsd.root then
    return gsd.root
  else
    return start_path
  end
end

function M.root()
  if vim.bo.buftype ~= "" and vim.bo.buftype ~= "nofile" then
    return
  end

  local stat = vim.loop.fs_stat(vim.fn.expand[[%:p]])
  if stat == nil or (stat and stat.type ~= "file") then
    return
  end

  local new_root = get_new_root()

  if new_root == current_working_directory then return end
  if new_root == nil or new_dir == "" then return end


  vim.cmd("cd " .. new_root)
  vim.notify("cwd changed to " .. new_root, vim.log.levels.INFO, { title = "[rooter]" })
  current_working_directory = new_root
end

return M
