# Show current directory, two levels deep
directory() {
   echo "%B%2~%b"
}

node_version() {
   if [ command -v node &> /dev/null ]; then
       NODE_VERSION=`node --version`
       echo " \u276f %F{084}⬢ $NODE_VERSION%f"
   fi
}

current_package() {
   if [ -f "package.json" ]; then
      PACKAGE_VERSION=$(cat package.json | grep version | head -1 | awk -F: '{ print $2 }' | sed 's/[",]//g' | tr -d '[[:space:]]')
      echo " \u276f 📦 $PACKAGE_VERSION "
   fi
}

node_project() {
   if [[ -f package.json || -d node_modules || -n *.js(#qN^/) ]]; then
      echo "$(node_version)$(current_package)"
   fi
}

prompt_indicator() {
   echo $'%B\u276f%b'
}



# set the git_prompt_info text
ZSH_THEME_GIT_PROMPT_PREFIX="(%B\uE0A0 "
ZSH_THEME_GIT_PROMPT_SUFFIX=")"
ZSH_THEME_GIT_PROMPT_DIRTY=" %b%F{red}⁎%f"
ZSH_THEME_GIT_PROMPT_CLEAN=" %b%F{084}✓%f"

PROMPT='
$(directory)$(node_project)
$(prompt_indicator) '
RPROMPT='$(git_prompt_info)'
