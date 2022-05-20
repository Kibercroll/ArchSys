main() {
	local file="$1"
	echo "$file"
	if ! [[ -e "$file" ]]; then
		exit 1
	fi

	xclip -selection clipboard -t image/png -i "$file"
	rm "$file"
}
main "$@"
