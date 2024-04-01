#!/bin/bash



readonly SCRIPT_PATH="$(dirname $(realpath $0))"



main() {
	cd "$SCRIPT_PATH"

	umask 077

	setup_bash
	setup_git
	setup_ssh
	setup_nano
	setup_tmux
}

setup_bash() {
	# setup bash completion
	cp -r .local ~

	# setup config
	cp -r .config ~

	# setup toolbox
	chmod u+x ~/.config/customize-config/toolbox

	# setup scripts
	chmod u+x ~/.config/customize-config/scripts/*

	# backup .bashrc
	cp ~/.bashrc ~/.bashrc.old

	# setup bashrc script
	awk '
		function print_custom_bashrc() {
			print "# ===== custom bashrc begin ====="
			print "[ -d ~/.config/customize-config ] && for i in ~/.config/customize-config/*.bashrc; do source \"$i\"; done"
			print "# ===== custom bashrc end ====="
		}
		/# ===== custom bashrc begin =====/ {
			skip=1
			next
		}
		skip && /# ===== custom bashrc end =====/ {
			print_custom_bashrc()
			syntax_found=1
			skip=0
			next
		}
		!skip {
			print
		}
		END {
			if (!syntax_found) {
				print ""
				print_custom_bashrc()
				print ""
			}
		}
	' ~/.bashrc.old > ~/.bashrc
}

setup_git() {
	# setup git config
	cp .gitconfig ~
}

setup_ssh() {
	# setup ssh config
	cp -r .ssh ~
}

setup_nano() {
	# setup nano config
	cp .nanorc ~
}

setup_tmux() {
	# setup tmux config
	cp .tmux.conf ~
}



main "$@"; exit
