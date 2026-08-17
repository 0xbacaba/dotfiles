function tmux_start_or_attach() {
	local free_sessions=`tmux list-sessions -F "#{session_name}" -f "#{?session_attached,0,1}" 2>/dev/null`

	if [ -z "$free_sessions" ]; then
		tmux
	else
		local session
		if [ `wc -l <<< "$free_sessions"` = "1" ]; then
			session="$free_sessions"
		else
			session=`head -n1 <<< "$free_sessions"`
		fi
		tmux attach -t $session
	fi
}
