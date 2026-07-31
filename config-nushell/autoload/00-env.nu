$env.config.table.mode = "none"
$env.config.auto_cd_implicit = true
$env.config.cursor_shape.emacs = "block"
$env.config.ls.clickable_links = false
$env.config.show_banner = false
$env.config.buffer_editor = "hx"
$env.EDITOR = "hx"
$env.config.abbreviations = {
  gs: "git status"
  gd: "git diff"
  gl: "git log"
  ga: "git add"
  gap: "git add --patch"
  gc: "git commit -m"
  gr: "git restore"
  gp: "git push"
  gf: "git fetch"
  glf: "git ls-files"  
  ll: "ls | sort-by modified"
  dots: "mise bootstrap dotfiles apply"
  lg: "lazygit"
}
