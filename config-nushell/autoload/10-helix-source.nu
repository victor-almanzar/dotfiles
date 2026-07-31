let helix_source_dir = ($nu.home-dir | path join "src" "helix" "target" "release")

if (($helix_source_dir | path join "hx") | path exists) and ($helix_source_dir not-in $env.PATH) {
  $env.PATH = ($env.PATH | prepend $helix_source_dir)
}
