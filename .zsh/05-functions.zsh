function chpwd() {
    if [ -x ~/bin/Z ]; then
        [ "$PWD" -ef "$HOME" ] || Z -a "$PWD"
    fi
}

# A shortcut function that simplifies usage of xclip.
# - Accepts input from either stdin (pipe), or params.
function cb() {
  local _scs_col="\e[0;32m"; local _wrn_col='\e[1;31m'; local _trn_col='\e[0;33m'
  # Check that xclip is installed.
  if ! type xclip > /dev/null 2>&1; then
    echo -e "$_wrn_col""You must have the 'xclip' program installed.\e[0m"
  # Check user is not root (root doesn't have access to user xorg server)
  elif [[ "$USER" == "root" ]]; then
    echo -e "$_wrn_col""Must be regular user (not root) to copy a file to the clipboard.\e[0m"
  else
    # If no tty, data should be available on stdin
    if ! [[ "$( tty )" == /dev/* ]]; then
      input="$(< /dev/stdin)"
    # Else, fetch input from params
    else
      input="$*"
    fi
    if [ -z "$input" ]; then  # If no input, print usage message.
      echo "Copies a string to the clipboard."
      echo "Usage: cb <string>"
      echo "       echo <string> | cb"
    else
      # Copy input to clipboard
      echo -n "$input" | xclip -selection c
      # Truncate text for status
      if [ ${#input} -gt 80 ]; then input="$(echo $input | cut -c1-80)$_trn_col...\e[0m"; fi
      # Print status.
      echo -e "$_scs_col""Copied to clipboard:\e[0m $input"
    fi
  fi
}

# Rename pictures based on information found in exif headers
function jpegrename(){
    if [[ $# -lt 1 ]] ; then
        echo 'Usage: jpgrename $FILES' >& 2
        return 1
    else
        echo -n 'Checking for jhead with version newer than 1.9: '
        jhead_version=`jhead -h | \
                    grep 'used by most Digital Cameras.  v.*' | \
                    awk '{print $6}' | tr -d v`
        if [[ $jhead_version > '1.9' ]]; then
            echo 'success - now running jhead.'
            jhead -n%Y-%m-%d_%Hh%M_%f $*
        else
            echo 'failed - exiting.'
        fi
    fi
}


function magic-abbrev-expand() {
    local MATCH
    LBUFFER=${LBUFFER%%(#m)[_a-zA-Z0-9]#}
    LBUFFER+=${abbreviations[$MATCH]:-$MATCH}
    zle self-insert
}

function no-magic-abbrev-expand() {
    LBUFFER+=' '
}

function zc(){
  local cache="$ZSH/cache"
  autoload -U compinit zrecompile
  compinit -d "$cache/zcomp-$HOST"

  for z in $HOME/.zsh/**/**.zsh $HOME/.zshrc; do zcompile $z; echo "Compiled $z"; done
  for f in ~/.zshrc "$cache/zcomp-$HOST"; do
    zrecompile -p $f && command rm -f $f.zwc.old
  done

  source ~/.zshrc
}

# completion system
if zrcautoload compinit ; then
    compinit || print 'Notice: no compinit available :('
else
    print 'Notice: no compinit available :('
    function zstyle { }
    function compdef { }
fi

# Load is-at-least() for more precise version checks Note that this test will
# *always* fail, if the is-at-least function could not be marked for
# autoloading.
zrcautoload is-at-least || is-at-least() { return 1 }

function pk () {
    if [ $1 ] ; then
        case $1 in
            tbz)    tar cjvf $2.tar.bz2 $2                ;;
            tgz)    tar czvf $2.tar.gz  $2                ;;
            tar)    tar cpvf $2.tar  $2                   ;;
            bz2)    bzip $2                               ;;
            gz)     gzip -c -9 -n $2 > $2.gz              ;;
            zip)    zip -r $2.zip $2                      ;;
            7z)     7z a $2.7z $2                         ;;
            *)      echo "'$1' cannot be packed via pk()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}


function extract() {
  local remove_archive
  local success
  local file_name
  local extract_dir

  if (( $# == 0 )); then
    echo "Usage: extract [-option] [file ...]"
    echo
    echo Options:
    echo "    -r, --remove    Remove archive."
    echo
    echo "Report bugs to <sorin.ionescu@gmail.com>."
  fi

  remove_archive=1
  if [[ "$1" == "-r" ]] || [[ "$1" == "--remove" ]]; then
    remove_archive=0 
    shift
  fi

  while (( $# > 0 )); do
    if [[ ! -f "$1" ]]; then
      echo "extract: '$1' is not a valid file" 1>&2
      shift
      continue
    fi

    success=0
    file_name="$( basename "$1" )"
    extract_dir="$( echo "$file_name" | sed "s/\.${1##*.}//g" )"
    case "$1" in
      (*.tar.gz|*.tgz) [ -z $commands[pigz] ] && tar zxvf "$1" || pigz -dc "$1" | tar xv ;;
      (*.tar.bz2|*.tbz|*.tbz2) tar xvjf "$1" ;;
      (*.tar.xz|*.txz) tar --xz --help &> /dev/null \
        && tar --xz -xvf "$1" \
        || xzcat "$1" | tar xvf - ;;
      (*.tar.zma|*.tlz) tar --lzma --help &> /dev/null \
        && tar --lzma -xvf "$1" \
        || lzcat "$1" | tar xvf - ;;
      (*.tar) tar xvf "$1" ;;
      (*.gz) [ -z $commands[pigz] ] && gunzip "$1" || pigz -d "$1" ;;
      (*.bz2) bunzip2 "$1" ;;
      (*.xz) unxz "$1" ;;
      (*.lzma) unlzma "$1" ;;
      (*.Z) uncompress "$1" ;;
      (*.zip|*.war|*.jar|*.sublime-package) unzip "$1" -d $extract_dir ;;
      (*.rar) unrar x -ad "$1" ;;
      (*.7z) 7za x "$1" ;;
      (*.deb)
        mkdir -p "$extract_dir/control"
        mkdir -p "$extract_dir/data"
        cd "$extract_dir"; ar vx "../${1}" > /dev/null
        cd control; tar xzvf ../control.tar.gz
        cd ../data; tar xzvf ../data.tar.gz
        cd ..; rm *.tar.gz debian-binary
        cd ..
      ;;
      (*) 
        echo "extract: '$1' cannot be extracted" 1>&2
        success=1 
      ;; 
    esac

    (( success = $success > 0 ? $success : $? ))
    (( $success == 0 )) && (( $remove_archive == 0 )) && rm "$1"
    shift
  done
}

function up-one-dir   { pushd .. > /dev/null; zle redisplay; zle -M `pwd`;  }
function back-one-dir { popd     > /dev/null; zle redisplay; zle -M `pwd`;  }
zle -N up-one-dir
zle -N back-one-dir

function xkcdrandom(){ wget -qO- dynamic.xkcd.com/comic/random|tee >(feh $(grep -Po '(?<=")http://imgs[^/]+/comics/[^"]+\.\w{3}'))|grep -Po '(?<=(\w{3})" title=").*(?=" alt)';}
function xkcd(){ wget -qO- http://xkcd.com/|tee >(feh $(grep -Po '(?<=")http://imgs[^/]+/comics/[^"]+\.\w{3}'))|grep -Po '(?<=(\w{3})" title=").*(?=" alt)';}
# just type '...' to get '../..'
function rationalise-dot() {
    local MATCH
    if [[ $LBUFFER =~ '(^|/| |  |'$'\n''|\||;|&)\.\.$' ]]; then
        LBUFFER+=/
        zle self-insert
        zle self-insert
    else
        zle self-insert
    fi
}
zle -N rationalise-dot

### jump behind the first word on the cmdline.
### useful to add options.
function jump_after_first_word() {
    local words
    words=(${(z)BUFFER})

    if (( ${#words} <= 1 )) ; then
        CURSOR=${#BUFFER}
    else
        CURSOR=${#${words[1]}}
    fi
}
zle -N jump_after_first_word

# grep for running process, like: 'any vime
function any() {
    emulate -L zsh
    unsetopt KSH_ARRAYS
    if [[ -z "$1" ]] ; then
        if [ ! -x `which peco` ]; then
            echo "any - grep for process(es) by keyword" >&2
            echo "Usage: any <keyword>" >&2 ; return 1
        else
            ps xauwww | peco --layout=bottom-up
        fi
    else
        ps xauwww | grep  --color=auto -i "[${1[1]}]${1[2,-1]}"
    fi
}

function inplaceMkDirs() {
    # Press ctrl-xM to create the directory under the cursor or the selected area.
    # To select an area press ctrl-@ or ctrl-space and use the cursor.
    # Use case: you type "mv abc ~/testa/testb/testc/" and remember that the
    # directory does not exist yet -> press ctrl-XM and problem solved
    local PATHTOMKDIR
    if ((REGION_ACTIVE==1)); then
        local F=$MARK T=$CURSOR
        if [[ $F -gt $T ]]; then
            F=${CURSOR}
            T=${MARK}
        fi
        # get marked area from buffer and eliminate whitespace
        PATHTOMKDIR=${BUFFER[F+1,T]%%[[:space:]]##}
        PATHTOMKDIR=${PATHTOMKDIR##[[:space:]]##}
    else
        local bufwords iword
        bufwords=(${(z)LBUFFER})
        iword=${#bufwords}
        bufwords=(${(z)BUFFER})
        PATHTOMKDIR="${(Q)bufwords[iword]}"
    fi
    [[ -z "${PATHTOMKDIR}" ]] && return 1
    PATHTOMKDIR=${~PATHTOMKDIR}
    if [[ -e "${PATHTOMKDIR}" ]]; then
        zle -M " path already exists, doing nothing"
    else
        zle -M "$(mkdir -p -v "${PATHTOMKDIR}")"
        zle end-of-line
    fi
}

# If I am using vi keys, I want to know what mode I'm currently using.
# zle-keymap-select is executed every time KEYMAP changes.
# From http://zshwiki.org/home/examples/zlewidgets
function zle-keymap-select {
    VIMODE="${${KEYMAP/vicmd/ M:command}/(main|viins)/}"
    zle reset-prompt
}

function imv() {
    local src dst
    for src; do
        [[ -e $src ]] || { print -u2 "$src does not exist"; continue }
        dst=$src
        vared dst
        [[ $src != $dst ]] && mkdir -p $dst:h && mv -n $src $dst
    done
}

function pstop() {
    ps -eo pid,user,pri,ni,vsz,rsz,stat,pcpu,pmem,time,comm --sort -pcpu |
    head "${@:--n 20}"
}

function finfo() {
while [ $# -gt 0 ] ; do
    mime_type=$(file -L -b --mime-type "$1")
    case $mime_type in
        image/svg+xml) inkscape -S "$1" ;;
        video/* | application/vnd.rn-realmedia | audio/* | image/*) mediainfo "$1" ;;
        application/pdf) pdfinfo "$1" ;;
        application/zip) unzip -l "$1" ;;
        application/x-lha) lha -l "$1" ;;
        application/x-rar) unrar lb "$1" ;;
        application/x-bittorrent) aria2c -S "$1" | grep '\./' ;;
        application/x-iso9660-image) isoinfo -J -l -i "$1" ;;
        *)
            case "$1" in
                *.torrent) aria2c -S "$1" | grep '\./' ;;
                *.mkv) mediainfo "$1" ;;
                *.ace) unace l "$1" ;;
                *.icns) icns2png -l "$1" ;;
                *) file -b "$1" ;;
            esac
            ;;
    esac
    shift
done
}

function rfc(){
    [ "$PAGER" ] || PAGER=less
    uri_tmpl='http://www.rfc-editor.org/rfc/rfc%d.txt';
    rfcn=$( printf $1 | sed 's/[^0-9]//g' );
    if [ -z "$rfcn" ]; then
    echo  "Usage: rfc <RFC>";
    exit;
    fi
    uri=$( printf $uri_tmpl $rfcn );
    curl --silent $uri | $PAGER;
}

function myip(){
    if [ -n "$1" ]; then
    sleep $1;
    fi

    if [ -x /usr/bin/dig ]; then
        DNSQUERY=`dig +short myip.opendns.com @resolver1.opendns.com`
    fi

    if [ -n "$DNSQUERY" ]; then
        echo "$DNSQUERY"
    else
        ( wget -O- -T2 -q http://noone.org/cgi-bin/whatsmyip.cgi || \
        wget -O- -T2 -q http://v4.showip.spamt.net/ || \
        wget -O- -T2 -q http://showipv6.de/shortv4only || \
        wget -O- -T2 -q http://checkip.dyndns.org/ | sed -e 's|^.*<body>Current IP Address: ||;s|</body>.*$||;s|^50
    0 .*|N/A|;' || \
        wget -O- -T2 -q http://ente.limmat.ch/myip | fgrep 'Your IP' | sed -e 's|^.*(||;s|).*$||;s|^500 .*|N/A|;' | \
        echo N/A ) | \
        sed -e 's:^$:N/A:'
    fi
}

function eat(){
    # eat - copy to the clipboard the contents of a file

    # Program name from it's filename
    prog=${0##*/}

    # Text color variables
    bldblu='\e[1;34m'         # blue
    bldred='\e[1;31m'         # red
    bldwht='\e[1;37m'         # white
    txtbld=$(tput bold)       # bold
    txtund=$(tput sgr 0 1)    # underline
    txtrst='\e[0m'            # text reset
    info=${bldwht}*${txtrst}
    pass=${bldblu}*${txtrst}
    warn=${bldred}!${txtrst}

    filename=$@

    # Display usage if full argument isn't given
    if [[ -z $filename ]]; then
        echo " $prog <filename> - copy a file to the clipboard"
        exit
    fi

    # Check that file exists
    if [[ ! -f $filename ]]; then
    echo -e "$warn File ${txtund}$filename${txtrst} doesn't exist"
    exit
    fi

    # Check user is not root (root doesn't have access to user xorg server)
    if [[ $(whoami) == root ]]; then
    echo -e "$warn Must be regular user to copy a file to the clipboard"
    exit
    fi

    # Copy file to clipboard, give feedback
    xclip -in -selection c < "$filename"
    echo -e "$pass ${txtund}"${filename##*/}"${txtrst} copied to clipboard"
}

function fg-widget() {
    stty icanon echo -inlcr < /dev/tty
    stty lnext '^V' quit '^\' susp '^Z' < /dev/tty
    zle reset-prompt
    if jobs %- >/dev/null 2>&1; then
        fg %-
    else
        fg
    fi
}
zle -N fg-widget


function expand-or-complete-and-highlight() {
    zle expand-or-complete
    _zsh_highlight
}

zle -N expand-or-complete-and-highlight expand-or-complete-and-highlight

function pcp(){
    #pcp - copy files matching pattern $1 to $2
    find . -regextype awk -iregex ".*$1.*" -print0 | xargs -0 cp -vR -t "$2"
}

# usage: *(o+rand) or *(+rand)
function rand() { REPLY=$RANDOM; (( REPLY > 16383 )) }

fasd_cache="$HOME/bin/.fasd-init-cache"
if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
    fasd --init auto >| "$fasd_cache"
fi
source "$fasd_cache"
unset fasd_cache
alias vv='f -e vim'

function copy-to-clipboard() {
    (( $+commands[xclip] )) || return
    echo -E -n - "$BUFFER" | xclip -i
}
zle -N copy-to-clipboard

# expand-or-complete, but sets buffer to "cd" if it's empty
function expand-or-complete-or-cd() {
    if [[ $#BUFFER == 0 ]]; then
        BUFFER="cd "
        CURSOR=3
        # don't want that after all
        # zle menu-expand-or-complete
        zle menu-expand-or-complete
    else
        zle expand-or-complete
    fi
}
zle -N expand-or-complete-or-cd

function ff() {
    find . -iregex ".*$@.*" -printf '%P\0' | xargs -r0 ls --color=auto -1d
}

function magnet_to_torrent() {
    [[ "$1" =~ xt=urn:btih:([^\&/]+) ]] || return 1
    hashh=${match[1]}
    if [[ "$1" =~ dn=([^\&/]+) ]];then
      filename=${match[1]}
    else
      filename=$hashh
    fi
    echo "d10:magnet-uri${#1}:${1}e" > "$filename.torrent"
}

function hi2() {
    if [ ! -x $(which pygmentize) ]; then
        echo package \'pygmentize\' is not installed!
        exit -1
    fi

    if [ $# -eq 0 ]; then
        pygmentize -g $@
    fi

    for FNAME in $@; do
        filename=$(basename "$FNAME")
        lexer=`pygmentize -N \"$filename\"`
        if [ "Z$lexer" != "Ztext" ]; then
            pygmentize -l $lexer "$FNAME"
        else
            pygmentize -g "$FNAME"
        fi
    done
}

# un-smart function for viewing sectioned partitions:
function dfu() {
  local FSTYPES
  FSTYPES=(nilfs2 btrfs ext2 ext3 ext4 jfs xfs zfs reiserfs reiser4 minix ntfs ntfs-3g fat vfat fuse)
  df -hTP -x rootfs -x devtmpfs -x tmpfs -x none ; print
  df -hTP $(for f in $FSTYPES; { print - " -x $f" })
}

function doc2pdf () { curl -# -F inputDocument=@"$1" http://www.doc2pdf.net/convert/document.pdf > "${1%.*}.pdf" }

function discover () {
    keyword=$(echo "$@" |  sed 's/ /.*/g' | sed 's:|:\\|:g' | sed 's:(:\\(:g' | sed 's:):\\):g')
    locate -ir $keyword
}

function sprunge() {
    if [ -t 0 ]; then
      echo Running interactively, checking for arguments... >&2
      if [ "$*" ]; then
        echo Arguments present... >&2
        if [ -f "$*" ]; then
          echo Uploading the contents of "$*"... >&2
          cat "$*"
        else
          echo Uploading the text: \""$*"\"... >&2
          echo "$*"
        fi | curl -F 'sprunge=<-' http://sprunge.us
      else
        echo No arguments found, printing USAGE and exiting. >&2
        usage
      fi
    else
      echo Using input from a pipe or STDIN redirection... >&2
      curl -F 'sprunge=<-' http://sprunge.us
    fi
}

function XC () { xclip -in -selection clipboard <(history | tail -n1 | cut -f2) }
# un-smart function for viewing/editing history file (still use 'fc/history'):
function zhist {
    if [[ $# -ge 1 ]]; then
    case $1 {
        '-a'|'-all') <${ZDOTDIR:-${HOME}/zsh}/.history | ${PAGER:-less} ;;
        '-e'|'--edit') ${EDITOR:-/usr/bin/vim} ${ZDOTDIR:-${HOME}/zsh}/.history ;;
        '-f'|'--find') [[ -n $2 ]] && <${ZDOTDIR:-${HOME}/zsh}/.history|grep -i "${${@:/$1}// /\|}" ;;
    }
    else
        print - "options: -e (edit), -f (find), -a (all)"
    fi
}

function slow_output() { while IFS= read -r -N1; do printf "%c" "$REPLY"; sleep ${1:-.02}; done; }
function dropcache { sync && command su -s /bin/zsh -c 'echo 3 > /proc/sys/vm/drop_caches' root }

# un-smart function for viewing/editing history file (still use 'fc/history'):
function zhist {
  if [[ $# -ge 1 ]]; then
    case $1 {
      '-a'|'-all') <~/.zsh_history | ${PAGER:-less} ;;
      '-e'|'--edit') ${EDITOR:-/usr/bin/vim} ~/.zsh_history ;;
      '-f'|'--find') [[ -n $2 ]] && <~/.zsh_history|grep -i "${${@:/$1}// /\|}" ;;
    }
  else
    print - "options: -e (edit), -f (find), -a (all)"
  fi
}

function capture() {
   ffcast -w ffmpeg -f alsa -ac 2 -i hw:0,2 -f x11grab -s %s -i %D+%c -acodec pcm_s16le -vcodec huffyuv $@
}

function web_search() {
  emulate -L zsh

  # define search engine URLS
  typeset -A urls
  urls=(
    google      "https://www.google.com/search?q="
    bing        "https://www.bing.com/search?q="
    yahoo       "https://search.yahoo.com/search?p="
    duckduckgo  "https://www.duckduckgo.com/?q="
    yandex      "https://yandex.ru/yandsearch?text="
  )

  # define the open command
  case "$OSTYPE" in
    darwin*)  open_cmd="open" ;;
    cygwin*)  open_cmd="cygstart" ;;
    linux*)   open_cmd="xdg-open" ;;
    *)        echo "Platform $OSTYPE not supported"
              return 1
              ;;
  esac

  # check whether the search engine is supported
  if [[ -z "$urls[$1]" ]]; then
    echo "Search engine $1 not supported."
    return 1
  fi

  # search or go to main page depending on number of arguments passed
  if [[ $# -gt 1 ]]; then
    # build search url:
    # join arguments passed with '+', then append to search engine URL
    url="${urls[$1]}${(j:+:)@[2,-1]}"
  else
    # build main page url:
    # split by '/', then rejoin protocol (1) and domain (2) parts with '//'
    url="${(j://:)${(s:/:)urls[$1]}[1,2]}"
  fi

  nohup $open_cmd "$url" &>/dev/null
}

function hugepage_disable(){
    echo 'echo "madvise" >> /sys/kernel/mm/transparent_hugepage/defrag' | sudo -s
    cat /sys/kernel/mm/transparent_hugepage/defrag
}

# Tmux create session
function create_session(){
    if [ "$1" ]; then
        tmux new-session -A -s "$@"
    else
        tmux ls
    fi
}

function teapot_xterm(){
    curl http://www.dim13.org/tek/teapot.tek
}

function bookmarks_export(){
    sqlite3 ~/.mozilla/firefox/*/places.sqlite "
    select moz_places.url, moz_bookmarks.title from moz_places, moz_bookmarks
    where moz_bookmarks.fk = moz_places.id and moz_bookmarks.type = 1
    and length(moz_bookmarks.title) > 0 order by moz_bookmarks.dateAdded"
}

function cache_list(){
    dirlist=(
        ~/.w3m/*
        ~/.local/share/recently-used.xbel
        ~/.cache/mc/*
        ~/.local/share/mc/history
        ~/.viminfo
        ~/.adobe/
        ~/.macromedia/
        ~/.cache/mozilla/
        ~/.thumbnails/
    )

    du -shc $dirlist
}

function switch_mpdscribble(){
    if [[ "`systemctl --user status mpdscribble.service|grep -o 'active (running)'`" == "active (running)" ]]; then
        systemctl --user stop mpdscribble
        mpdscribble --conf /home/neg/.config/mpdscribble/hextrick.conf --no-daemon &
    else
        pkill mpdscribble
        systemctl --user start mpdscribble
    fi
}

function clock(){
    while sleep 1; do 
        tput sc
        tput cup 0 $(($(tput cols)-29))
        date
        tput rc
    done &
}

function soneeded() {
   readelf -d $1 | awk '/NEEDED/ {gsub(/[\[\]]/, "", $5); print $5}'
}
