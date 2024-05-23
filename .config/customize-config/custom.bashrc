########
# main #
########

__MODULES=(
	"dotnet"
	"fancy_prompt"
)

__setup_modules() {
	local module_name

	for module_name in "${__MODULES[@]}"; do
		local setup_module="__setup_${module_name}"

        declare -F "${setup_module}" >/dev/null 2>&1 && ${setup_module}
	done
}

__clean_modules() {
	local module_name

	for module_name in "${__MODULES[@]}"; do
		local setup_module="__setup_${module_name}"
		local clean_module="__clean_${module_name}"

		declare -F "${clean_module}" >/dev/null 2>&1 && ${clean_module}

		unset -f "${setup_module}" >/dev/null 2>&1
		unset -f "${clean_module}" >/dev/null 2>&1
	done

	unset __MODULES
	unset -f __setup_modules
	unset -f __clean_modules
}



##########
# dotnet #
##########

__setup_dotnet() {
	alias dotnet="CheckEolTargetFramework=false dotnet"
}

__clean_dotnet() {
	true
}



################
# fancy prompt #
################

__setup_fancy_prompt() {
	[[ "$-" == *i* ]] || return

	# view history
	bind '"\e[A": history-search-backward'
	bind '"\e[B": history-search-forward'

	# set default prompt
	local __default_prompt_user_begin="\[\e[1;32m\]"
	local __default_prompt_user="\u@$(. /etc/os-release; echo "${ID}-${VERSION_ID%%.*}")"
	local __default_prompt_user_end="\[\e[0m\]"
	local __default_prompt_path_begin="\[\e[1;34m\]"
	local __default_prompt_path="\w"
	local __default_prompt_path_end="\[\e[0m\]"
	local __default_prompt_symbol="\$ "

	PS1="\
${__default_prompt_user_begin}\
${__default_prompt_user}\
${__default_prompt_user_end}\
:\
${__default_prompt_path_begin}\
${__default_prompt_path}\
${__default_prompt_path_end}\
${__default_prompt_symbol}\
"

	[ -z "$SSH_TTY" ] || return
	[ -z "$SSH_CONNECTION" ] || return
	[ -z "$SSH_CLIENT" ] || return
	[ -z "$WSL_DISTRO_NAME" ] || return
	[ "$TERM_PROGRAM" == "vscode" ] && return

	local separator=""

	[ "$(. /etc/os-release; echo $ID)" == "ubuntu" ] && separator=$'\u25e4'

	__custom_prompt_normal_begin="\[\e[37;47m\]"
	__custom_prompt_normal=" "
	__custom_prompt_normal_end="\[\e[0m\]\[\e[37;44m\]${separator}\[\e[0m\]"
	__custom_prompt_notice_begin="\[\e[1;5;91;47m\]"
	__custom_prompt_notice="!"
	__custom_prompt_notice_end="\[\e[0m\]\[\e[37;44m\]${separator}\[\e[0m\]"
	__custom_prompt_user_begin="\[\e[1;37;44m\] "
	__custom_prompt_user="\u@$(. /etc/os-release; echo "${ID}-${VERSION_ID%%.*}")"
	__custom_prompt_user_end=" \[\e[0m\]\[\e[34;48;5;8m\]${separator}\[\e[0m\]"
	__custom_prompt_path_begin="\[\e[1;37;48;5;8m\] "
	__custom_prompt_path=""
	__custom_prompt_path_end=" \[\e[0m\]\[\e[38;5;8m\]${separator}\[\e[0m\]"
	__custom_prompt_symbol="\n\$ "

	PROMPT_COMMAND=__fancy_prompt
}

__clean_fancy_prompt() {
	true
}

__fancy_prompt() {
	local exit_code=$?

	__custom_prompt_path="$PWD"

	if [ $exit_code -eq 0 ]; then
		PS1="\
${__custom_prompt_normal_begin}\
${__custom_prompt_normal}\
${__custom_prompt_normal_end}\
${__custom_prompt_user_begin}\
${__custom_prompt_user}\
${__custom_prompt_user_end}\
${__custom_prompt_path_begin}\
${__custom_prompt_path}\
${__custom_prompt_path_end}\
${__custom_prompt_symbol}\
"
	else
		PS1="\
${__custom_prompt_notice_begin}\
${__custom_prompt_notice}\
${__custom_prompt_notice_end}\
${__custom_prompt_user_begin}\
${__custom_prompt_user}\
${__custom_prompt_user_end}\
${__custom_prompt_path_begin}\
${__custom_prompt_path}\
${__custom_prompt_path_end}\
${__custom_prompt_symbol}\
"
	fi
}



###############
# entry point #
###############

__setup_modules
__clean_modules
