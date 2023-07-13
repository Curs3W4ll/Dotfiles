# Default target
.DEFAULT_GOAL := all

check-install-inotifywait: # Check if the inotifywait command is installed
	@which inotifywait >/dev/null || (echo "Could not find inotifywait command, please install it (part of inotify-tools)" && false)

watch-nvim: check-install-inotifywait # Update nvim Lua configuration using chezmoi everytime 
	@inotifywait -m -r -e close_write --format %e private_dot_config/nvim/ | \
		while read events; do \
			chezmoi apply ~/.config/nvim; \
		done

help: # Print help on Makefile
	@grep '^[^.#]\+:\s\+.*#' Makefile | \
	sed "s/\(.\+\):\s*\(.*\) #\s*\(.*\)/`printf "\033[93m"`\1`printf "\033[0m"`	\3 [\2]/" | \
	expand -t20

all: help # Default target

.PHONY: check-install-inotifywait watch-nvim all help
