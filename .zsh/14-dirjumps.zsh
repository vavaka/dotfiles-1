bindkey -s "1" 'cd ~/1st_level'
bindkey -s "2" 'cd ~/dw'
bindkey -s "3" 'cd ~/dev'
bindkey -s "4" 'cd ~/pic'
bindkey -s "5" 'cd ~/vid'
bindkey -s "6" 'cd ~/trash'

# function up-one-dir   { pushd .. > /dev/null; zle redisplay; zle -M `pwd` }
# function back-one-dir { popd     > /dev/null; zle redisplay; zle -M `pwd` }
# zle -N up-one-dir
# zle -N back-one-dir
