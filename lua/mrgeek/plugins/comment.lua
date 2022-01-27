local present, nvim_comment = pcall(require, 'Comment')

if present then
  local default = {}
  nvim_comment.setup(default)
end
