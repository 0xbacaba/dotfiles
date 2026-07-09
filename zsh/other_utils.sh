function lc() {
  targets=$*

  if [ -z "$targets" ]; then
	  ls
  fi

  for target in $targets; do
    ([ -f "$target" ] && cat $target) ||
    ([ -d "$target" ] && ls $target)
  done
}
