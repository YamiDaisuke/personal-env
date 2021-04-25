right_triangle() {
   echo $'\ue0b0'
}

arrow_start() {
   echo "%{$FG[$ARROW_FG]%}%{$BG[$ARROW_BG]%}"
}

arrow_end() {
   echo "%{$reset_color%}%{$FG[$NEXT_ARROW_FG]%}%{$BG[$NEXT_ARROW_BG]%}$(right_triangle)%{$reset_color%}"
}

# Show current directory, two levels deep
directory() {
    ARROW_FG="016"
    ARROW_BG="183"
    NEXT_ARROW_BG="139"
    NEXT_ARROW_FG="183"
    echo "$(arrow_start)  %2~ $(arrow_end)"
}

node_version() {
   ARROW_FG="016"
   ARROW_BG="139"
   NEXT_ARROW_BG="139"
   NEXT_ARROW_FG="096"
   NODE_VERSION=`node --version`
   echo "$(arrow_start) %F{000}⬢ $NODE_VERSION%f $(arrow_end)"
}

current_package() {
   ARROW_FG="016"
   ARROW_BG="139"
   NEXT_ARROW_BG=""
   NEXT_ARROW_FG="096"


   PACKAGE_VERSION=$(cat package.json | grep version | head -1 | awk -F: '{ print $2 }' | sed 's/[",]//g' | tr -d '[[:space:]]')
   echo "$(arrow_start) 📦 $PACKAGE_VERSION $(arrow_end)"
}

node_project() {
   if [ -f "package.json" ]; then
      echo "$(node_version)$(current_package)"
   fi
}

prompt_indicator() {
   echo $'%B\u276f%b'
}

# set the git_prompt_info text
ZSH_THEME_GIT_PROMPT_PREFIX="(\uE0A0"
ZSH_THEME_GIT_PROMPT_SUFFIX=")"
ZSH_THEME_GIT_PROMPT_DIRTY=" ⁎"
ZSH_THEME_GIT_PROMPT_CLEAN=" ✓"

PROMPT='$(directory)$(node_project)
$(prompt_indicator) '
RPROMPT='$(git_prompt_info)'
