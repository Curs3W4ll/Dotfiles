# Default target
.DEFAULT_GOAL := all

# ============================
# ===     OS Detection     ===
# ============================
.OS_WINDOWS = Windows
.OS_MACOS = MacOS
.OS_LINUX = Linux
.OS_UNKNOWN = Unknown
.CURRENT_OS = $(.OS_UNKNOWN)
ifeq ($(OS),Windows_NT)
	.CURRENT_OS = $(.OS_WINDOWS)
else
	.UNAME_S := $(shell uname -s)
	ifeq ($(.UNAME_S),Linux)
		.CURRENT_OS = $(.OS_LINUX)
	endif
	ifeq ($(.UNAME_S),Darwin)
		.CURRENT_OS = $(.OS_MACOS)
	endif
endif

.PHONY: .check-install-inotifywait
.check-install-inotifywait: # Check if the inotifywait command is installed
	@which inotifywait >/dev/null || (echo "Could not find inotifywait command, please install it (part of inotify-tools)" && false)

.PHONY: .check-install-fswatch
.check-install-fswatch: # Check if the inotifywait command is installed
	@which fswatch >/dev/null || (echo "Could not find fswatch command, please install it" && false)

.PHONY: .watch-nvim-linux
.watch-nvim-linux: .check-install-inotifywait
	@inotifywait -m -r -e close_write --format %e private_dot_config/nvim/ | \
		while read events; do \
			chezmoi apply ~/.config/nvim; \
		done

.PHONY: .watch-nvim-macos
.watch-nvim-macos: .check-install-fswatch
	@fswatch -b -r --event=Updated private_dot_config/nvim/ | \
		while read; do \
			chezmoi apply ~/.config/nvim; \
		done

.PHONY: watch-nvim
watch-nvim: # Update nvim Lua configuration using chezmoi everytime 
ifeq ($(.CURRENT_OS),$(.OS_MACOS))
	@make --no-print-directory .watch-nvim-macos
else ifeq ($(.CURRENT_OS),$(.OS_LINUX))
	@make --no-print-directory .watch-nvim-linux
endif

.PHONY: help
help: # Print help on Makefile
	@grep '^[^.#]\+:\s\+.*#' Makefile | \
	sed "s/\(.\+\):\s*\(.*\) #\s*\(.*\)/`printf "\033[93m"`\1`printf "\033[0m"`	\3 [\2]/" | \
	expand -t20

.PHONY: all
all: help # Default target
