export _EMACS_PATH='/Applications/Emacs.app/Contents/MacOS'
export _EMACS_CMD="${_EMACS_PATH}/bin/emacsclient --alternate-editor ${_EMACS_PATH}/Emacs"
export EDITOR="${_EMACS_CMD} -nw"
export CATALINA_HOME="/Users/mholm/apache-tomcat-5.5.33"
export MAVEN_HOME="/Users/mholm/apache-maven-3.1.0"
export M2_HOME=$MAVEN_HOME
export MAVEN_OPTS="-Xmx2048m -Xms512m -XX:MaxPermSize=1024m"
export JAVA_HOME="/System/Library/Frameworks/JavaVM.framework/Home"
export GRAILS_HOME="/Users/mholm/grails-1.2.2"
export GRADLE_HOME="/Users/mholm/gradle-1.1"
export GROOVY_HOME="/Users/mholm/groovy-1.8.0"
export GIT_HOME="/usr/local/git"
if [ -z $SYSTEM_PATH ]; then
  export SYSTEM_PATH=$PATH
fi
export PATH="$SYSTEM_PATH:$GRAILS_HOME/bin:$MAVEN_HOME/bin:/Users/mholm/devtools/bin:."

alias emacsclient="${_EMACS_CMD} --no-wait"
alias emacs='emacsclient'
alias ec='emacs'
alias aalias="ec ~/.bash_profile"
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias cd..='cd ..'
alias cd...='cd ../..'
alias snv='svn'
alias ls='ls -GFh'
alias la='ls -A'
alias ll='ls -lP'
alias lla='ll -A'
alias cls='clear'
alias mdcd='mkdircd'
alias mkcd='mkdircd'
alias mkdcd='mkdircd'
alias mdcp='mkdircp'
alias mkcp='mkdircp'
alias mkdcp='mkdircp'
alias clean='removeTemps'
alias rm~='removeTemps'
alias cl='cdls'
alias sha='shasum -a 256'
alias fix-maven='fix-mvn'
alias tiga='tig --all'
alias grep='grep --color -n'
alias sn='serverName.sh'
alias emasc='emacs'
alias it='git'
alias ij='open -a /Applications/IntelliJ\ IDEA\ 12.app/'
alias idea='ij'

cdls () { cd $1; ls; }

mkdircd () { mkdir ${1}; cd ${1}; }
mkdircp () { mkdir ${2}; cp -r ${1} ${2}; }

removeTemps () { rm -i ${1}/*~; }

reload () {
    . /Users/mholm/.bash_profile
}

fix-mvn () {
    ll /usr/share/maven
    sudo rm /usr/share/maven
    sudo ln -s $MAVEN_HOME /usr/share/maven
    ll /usr/share/maven
}

svnurl () {
    pattern=URL:
    line=`svn info $1 | grep $pattern`
    echo ${line#${pattern}}
}

about () {
    # validate input won't set a new alias
    if [[ $1 =~ '.*=.*' ]]; then
	echo "$1 is not an executable or alias"
	exit 1
    fi

    # print info about the argument
    which $1
    if [ "$?" -ne "0" ]; then echo "-about: $1: not found in PATH"; fi
    alias $1
}

# Setup some colors to use later in interactive shell or scripts
export COLOR_NC='\[\033[0m\]' # No Color
export COLOR_WHITE='\[\033[1;37m\]'
export COLOR_BLACK='\[\033[0;30m\]'
export COLOR_BLUE='\[\033[0;34m\]'
export COLOR_LIGHT_BLUE='\[\033[1;34m\]'
export COLOR_GREEN='\[\033[0;32m\]'
export COLOR_LIGHT_GREEN='\[\033[1;32m\]'
export COLOR_CYAN='\[\033[0;36m\]'
export COLOR_LIGHT_CYAN='\[\033[1;36m\]'
export COLOR_RED='\[\033[0;31m\]'
export COLOR_LIGHT_RED='\[\033[1;31m\]'
export COLOR_PURPLE='\[\033[0;35m\]'
export COLOR_LIGHT_PURPLE='\[\033[1;35m\]'
export COLOR_BROWN='\[\033[0;33m\]'
export COLOR_YELLOW='\[\033[1;33m\]'
export COLOR_GRAY='\[\033[1;30m\]'
export COLOR_LIGHT_GRAY='\[\033[0;37m\]'

# Completion -------------------------------------------------------

# Turn on advanced bash completion if the file exists
# Get it here: http://www.caliban.org/bash/index.shtml#completion or
# on OSX: sudo port install bash-completion
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi
if [ -f /opt/local/etc/bash_completion ]; then
    . /opt/local/etc/bash_completion
fi

# git completion
source ~/workspace/dotfiles/matthoffman/bin/git-completion.bash
# ...and svn completion
source ~/workspace/dotfiles/matthoffman/bin/svn-completion.bash

# Add completion to source and .
complete -F _command source
complete -F _command .

# Prompts ----------------------------------------------------------

export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true

prompt_func() {
    previous_return_value=$?;
    prompt="${COLOR_GREEN}[\A]${COLOR_NC}\w$(__git_ps1)$(__svn_ps1)"

    if test $previous_return_value -eq 0; then  # helpful indicator of failing processes
        PS1="${prompt}$ "
    else
        PS1="${prompt}${COLOR_RED}$ ${COLOR_NC}"
    fi
}
PROMPT_COMMAND=prompt_func
