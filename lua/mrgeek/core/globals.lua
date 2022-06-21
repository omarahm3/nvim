---Join path segments that were passed rvim input
---@return string
function _G.join_paths(...)
  local path_sep = vim.loop.os_uname().version:match "Windows" and "\\" or "/"
  local result = table.concat({ ... }, path_sep)
  return result
end

---Get the full path to `$RVIM_CACHE_DIR`
---@return string
function _G.get_cache_dir()
  local rvim_cache_dir = vim.env.RVIM_CACHE_DIR
  if not rvim_cache_dir then
    return vim.fn.stdpath "cache"
  end
  return rvim_cache_dir
end
