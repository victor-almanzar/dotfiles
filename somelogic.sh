# getting tldr config paths using ripgrep
tldr --show-paths | rg -o '^Config path: *(.*?)$' -r '$1'

#  using perl
tldr --show-paths | perl -ne 'print $1 if /^Config path: *(.*)$/'
