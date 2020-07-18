# shellcheck shell=bash

export HISTSIZE=1000000
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export EDITOR=vim
export PATH="${PATH}:${HOME}/bin"

# Append to the Bash history file, rather than overwriting it
shopt -s histappend;

# bash-prompt
export MY_HOST_NICKNAME='mbp'
#export SHOW_AWS_PROFILE='true'
export SHOW_K8S_CONTEXT='true'
export SHOW_K8S_NS='true'

# Colors
Y='\033[1;33m'
C='\033[0;36m'
G='\033[1;32m'
R='\033[1;31m'
N='\033[0m'

function echo_color {
	echo -e "${1}${2}${N}"
}

function yellow {
	echo_color "${Y}" "${1}"
}

function cyan {
	echo_color "${C}" "${1}"
}

function green {
	echo_color "${G}" "${1}"
}

function red {
	echo_color "${R}" "${1}"
}

# Functions and misc stuff
if [[ -f ~/.dwim ]]; then
	source ~/.dwim
fi

# Homebrew
alias b='brew'
complete -o bashdefault -o default -F _brew b

alias buc='brew update; brew upgrade; brew cleanup'
export PATH="${PATH}:/usr/local/bin:/usr/local/sbin"

# Pip
alias puc='pip3 list --outdated | cut -f1 -d\ | xargs -n1 -I% pip3 install --upgrade %'

# bash-completion
BASH_CMP_SCRIPT='/usr/local/etc/profile.d/bash_completion.sh'
test -r  "$BASH_CMP_SCRIPT" && source "$BASH_CMP_SCRIPT"

# More completion
FILES=$({ find ~/.completion -type l & find ~/.completion -type f; })

for f in ${FILES}
do
	source "$f"
done

# GNU tools by default
alias sed='gsed'
alias grep='pcre2grep'

# Quality of life
alias watch='watch --color '
alias xargs='xargs '
alias mc='mc --nocolor'

alias e="\$EDITOR"
eval "$(complete | pcre2grep " $EDITOR\$" | sed "s/ $EDITOR\$/ e/")"

alias ge='goland'

alias i='pcre2grep -i --color'
complete -o default -F _longopt i

alias f=find
complete -F _find f

alias ll='ls -Gltrh'
alias la='ls -GlAtrh'

alias lock='pmset displaysleepnow'
alias tftpd-start='sudo launchctl load -F /System/Library/LaunchDaemons/tftp.plist; sudo launchctl start com.apple.tftpd'
alias tftpd-stop='sudo launchctl unload -F /System/Library/LaunchDaemons/tftp.plist'
alias dnsflush='sudo killall -HUP mDNSResponder'
alias wanip='dig +short myip.opendns.com @resolver1.opendns.com'
alias lanip='ipconfig getifaddr en0'
alias ifactive="ifconfig | pcre2grep -M -o '^[^\t:]+:([^\n]|\n\t)*status: active'"
alias upgrade='sudo softwareupdate -i -a'
alias pubkey='more ~/.ssh/id_rsa.pub | pbcopy'

# Clean up LaunchServices to remove duplicates in the “Open With” menu
alias lscleanup='/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user && killall Finder'

# URL-encode strings
alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1]);"'

# Merge PDF files
# Usage: `mergepdf -o output.pdf input{1,2,3}.pdf`
alias mergepdf='/System/Library/Automator/Combine\ PDF\ Pages.action/Contents/Resources/join.py'

# Airport CLI alias
alias airport='/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport'

# Print each PATH entry on a separate line
alias path='echo -e ${PATH//:/\\n}'

# Use newer nano from brew when available
nano='/usr/local/bin/nano'
test -x "$nano" && alias nano="$nano"

# Better cat
export BAT_STYLE='plain'
BAT_THEME=$(dark_mode_enabled && printf "TwoDark" || printf "ansi-light")
alias bat="bat --paging=never --theme $BAT_THEME"

# Golang
export GOPATH="${HOME}/src/third_party/go"
export GOROOT='/usr/local/opt/go/libexec'

export PATH="${PATH}:/usr/local/opt/go/libexec/bin"
export PATH="${PATH}:${GOPATH}/bin"
export PATH="${PATH}:${GOROOT}/bin"

complete -C ~/src/third_party/go/bin/gocomplete go

# Rust
export PATH="${HOME}/.cargo/bin:${PATH}"

# Kubernetes
alias k='kubectl'
alias kcl='kubectl'
complete -o default -o nospace -F __start_kubectl k
complete -o default -o nospace -F __start_kubectl kcl

alias kcx='kubectx'
complete -F _kube_contexts kcx

alias kns='kubens'
complete -F _kube_namespaces kns

alias kg='kubectl get'
alias kd='kubectl delete'

alias kgp='k get pods -o wide'
alias kga='k get pods --all-namespaces -o wide'
alias kgk='k get pods -n kube-system -o wide'
alias kgs='k get svc -o wide'
alias kgr='k get rc -o wide'
alias kgd='k get deployments -o wide'
alias kgn='k get namespaces -o wide'
alias kca='k apply'
alias kgl='k logs'
alias kgi='k describe'

alias kgrs='k get rs -o wide'

alias mk='minikube'
complete -o default -o nospace -F __start_minikube mk

# Docker
alias d='docker'

DOCKER_COMPLETION_FILE='/Applications/Docker.app/Contents/Resources/etc/docker.bash-completion'
test -r "$DOCKER_COMPLETION_FILE" && source "$DOCKER_COMPLETION_FILE"

complete -F _docker d

alias di='d images'
alias da='d ps -a'

## Git
alias g='git'
complete -o bashdefault -o default -o nospace -F __git_wrap__git_main g

alias gs='g s'
alias gl='g l'
alias gf='g fetch'
alias ga='g a'
alias gd='g d'

alias gaa='g aa'
alias gdh='g d HEAD^'

alias gll='g ll'
alias glll='g lll'

function gcm {
	git commit -m "$*"
}

alias g-='g reset '
alias g+='g add'

alias ggg='g push'
alias gg='g pull'

# Multirepo stuff
alias gr='gr '
alias grs='gr status'

# AWS
function ap {
	# AWS Profile

	if ! test -z "$1"; then
		export AWS_PROFILE=$1
	else
		if ! test -z "$AWS_PROFILE"; then
			echo "$AWS_PROFILE"
		fi
	fi
}

function apl {
	# AWS Profile List

	local profiles
	local profile
	local current_profile

	profiles="${HOME}/.aws/credentials"
	if ! test -f "$profiles"; then
		echo 'No profiles have been configured'
		return 1
	fi

	profiles=$(grep \\[ "${profiles}" | tr -d '[]')
	current_profile=$(ap)

	for profile in ${profiles[@]}
	do
		if test "$current_profile" == "$profile"; then
			yellow "$profile"
		else
			echo "$profile"
		fi
	done
}

# Python
export PATH="${HOME}/Library/Python/$(python3 --version | cut -d' ' -f2 | cut -d. -f1,2)/bin:${PATH}"

# This .bashrc will be symlinked, so adding auto-generated stuff here would be a bad idea
if [[ -f ~/.bashrc_local ]]; then
	source ~/.bashrc_local
fi

# Company specific stuff that does not belong in public repo
if [[ -f ~/.companyrc ]]; then
	source ~/.companyrc
fi
