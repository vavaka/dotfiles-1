-------------------------------------[[ KLUDGES ]]----------------------------------
defwinprop{lazy_resize=true}
-------------------------------------[[ TERM ]]-------------------------------------
defwinprop{class="URxvt",instance="MainTerminal",transient_mode="off",target="term",lazy_resize=true
,ignore_max_size=false, ignore_min_size=false, ignore_aspect=false,ignore_resizeinc=true
}
defwinprop{class="URxvt",instance="mutt",transient_mode="off",target="float2",lazy_resize=true}
defwinprop{class="URxvt",instance="code",transient_mode="off",ignore_cfgrq=true, target="notes",lazy_resize=true}
defwinprop{class="yakuake",instance="*",transient_mode="off",ignore_cfgrq=true, lazy_resize=true, float=true}
-------------------------------------[[ WEB ]]---------------------------------------
defwinprop{class="Chromium",transient_mode="off",transient_mode="off",jumpto=true,target="web",lazy_resize=true, tag="www"}
defwinprop{class="Chromium-www",transient_mode="off",transient_mode="off",target="web",lazy_resize=true, tag="www"}
defwinprop{class="Opera",instance="startupdialog",transient_mode="off",target="web",lazy_resize=true}
defwinprop{instance="opera",transient_mode="off",transient_mode="off",target="web",lazy_resize=true, tag="www"}
defwinprop{class="Dwb",transient_mode="off",jumpto="on",target="web",lazy_resize=true, tag="www"}
defwinprop{class="Firefox",transient_mode="off",jumpto="on",target="web",lazy_resize=true,tag="www"}
defwinprop{class="Tor-Browser",transient_mode="off",jumpto="on",target="web",lazy_resize=true,tag="www"}
defwinprop{class="Firefox",role="Manager",instance="Download",transient_mode="off",jumpto="off",target="float2",lazy_resize=true}
defwinprop{class="Firefox",instance="Dialog",float=true}
defwinprop{class="Firefox",role="Organizer",target="float2"}
defwinprop{class="Firefox",instance="firefox",role="GtkFileChooserDialog",
    -- max_size = {w=1024,h=768},
    -- min_size = {w=800,h=600},
    float=true,
}
defwinprop{class="Conkeror",instance="Navigator",transient_mode="off",target="web",lazy_resize=true,tag="www"}
defwinprop{class="Iceweasel",role="www",transient_mode="off",jumpto="on",target="web",lazy_resize=true,tag="www"}
defwinprop{class="Vimprobable2",role="vimprobable2",transient_mode="off",jumpto="on",target="web",lazy_resize=true,tag="www"}
-------------------------------------[[ IM ]]---------------------------------------
defwinprop{instance="kopete",jumpto=false,winlist_ignore=true,transient_mode="off",target="im",lazy_resize=true}
defwinprop{instance="skype",jumpto=false,winlist_ignore=true,transient_mode="off",target="im",lazy_resize=true}
defwinprop{instance="finch",jumpto=false,winlist_ignore=true,transient_mode="off",target="im",lazy_resize=true}
defwinprop{instance="centerim",jumpto=false,winlist_ignore=true,transient_mode="off",target="im",lazy_resize=true}
defwinprop{instance="centerim",jumpto=false,winlist_ignore=true,transient_mode="off",target="im",lazy_resize=true}
defwinprop{instance="weechat-curses",jumpto=false,winlist_ignore=true,transient_mode="off",target="chat",lazy_resize=true}
-------------------------------------[[ DOC ]]---------------------------------------
defwinprop{class="Okular",instance="okular",transient_mode="off",jumpto=true,target="doc",lazy_resize=true, tag="pdf"}
defwinprop{name="Open Document*",class="Okular",instance="okular",transient_mode="off",jumpto=true,target="doc",float=true,lazy_resize=true}
defwinprop{class="Apvlv",instance="apvlv",transient_mode="off",jumpto=true,target="doc",lazy_resize=true, tag="pdf"}
defwinprop{class="Zathura",instance="zathura",transient_mode="off",jumpto=true,target="doc",lazy_resize=true, tag="pdf"}
defwinprop{class="Xpdf", instance = "openDialog_popup", ignore_cfgrq = true, tag="pdf"}
defwinprop{class="Evince",instance="evince",transient_mode="off",jumpto=true,target="doc",lazy_resize=true, tag="pdf"}
defwinprop{class="XDvi", target="doc",lazy_resize=true, tag="pdf"}
defwinprop{class="libreoffice*", instance="*", target="doc",lazy_resize=true, tag="writer"}
defwinprop{class="Cr3", instance="cr3",target="doc",lazy_resize=true, tag="reader"}
-------------------------------------[[ MEDIA ]]---------------------------------------
defwinprop{class="gmpc",    target="media",  lazy_resize=true}
defwinprop{class="MPlayer",  jumpto=true, transient_mode="off", target="media", tag="video"}
defwinprop{class="mplayer2", jumpto=true, transient_mode="off", target="media", tag="video"}
defwinprop{class="mpv",  jumpto=true, transient_mode="off", target="media", tag="video"}
defwinprop{class="mpv",  instance="webcam_mpv", jumpto=true, transient_mode="off", float=true}
defwinprop{class="feh", instance="feh",  jumpto="on", transient_mode="off", float=true,lazy_resize=true}
defwinprop{class="qiv", instance="qiv",  jumpto="on", transient_mode="off", float=true,lazy_resize=true}
-------------------------------------[[ DEV ]]--------------------------------------
defwinprop{class="Gvim",instance="gvim",target="dev",lazy_resize=true,jumpto=true,transient_mode="off",transparent=false,userpos=true,
tag="editor",
ignore_max_size=false, ignore_min_size=false, ignore_aspect=true,ignore_resizeinc=true
}
defwinprop{class="URxvt",instance="wim",target="dev",lazy_resize=true,jumpto=true,transient_mode="off",transparent=false,
tag="editor"
}
defwinprop{class="Qvim",instance="qvim",target="dev",lazy_resize=true,jumpto=true,transient_mode="off",
ignore_max_size=false, ignore_min_size=false, ignore_aspect=false,ignore_resizeinc=true,
tag="editor"
}
defwinprop{class="Emacs",instance="emacs",target="dev",lazyresize=true,jumpto=true}
defwinprop{class="Emacs",instance="emacs",name="Question",float=true}
defwinprop{class="com-sun-javaws-Main", instance="sun-awt-X11-XFramePeer", target="topcoder"}
defwinprop{class="jetbrains-idea", instance="*", target="jetbrains", floating=true,transient_mode = "current"}
defwinprop{class = "jetbrains-android-studio", instance = "sun-awt-X11-XWindowPeer", transient_mode = "current", }
-------------------------------------[[ VM ]]--------------------------------------
defwinprop{class="vmware",instance="Vmware",target="vm",jumpto=true,transient_mode="off", float=true, tag="virt"}
defwinprop{class="VirtualBox", jumpto=true,target="vm",transient_mode="off",lazy_resize=true, tag="virt"}
defwinprop{class="Vmware", jumpto=true,target="vm",transient_mode="on",lazy_resize=true, tag="virt"}
defwinprop{class="QEMU", jumpto=true,target="vm",transient_mode="on",lazy_resize=true, tag="virt"}
defwinprop{class="spicec",instance="spicec", jumpto=true,target="vm",transient_mode="on",lazy_resize=true, tag="virt"}
-------------------------------------[[   GIMP  ]]-----------------------------
defwinprop{class = "Gimp",acrobatic = true, tag="graphic"}
defwinprop{class="Gimp",jumpto=true,role="gimp-file-open",transient_mode="off",float=true}
defwinprop{class="Gimp",jumpto=true,role="gimp-file-save",transient_mode="off",float=true}
defwinprop{class="Gimp",jumpto=true,role="gimp-message-dialog",transient_mode="off",float=true}
defwinprop{class="Gimp",jumpto=true,role="gimp-image-new",transient_mode="off",float=true}
defwinprop{class="Gimp",jumpto=true,role="gimp-toolbox-color-dialog",transient_mode="off",float=true}
-------------------------------------[[ TRAY'n'DOCK ]]------------------------------
defwinprop{class = "stalonetray", instance = "stalonetray", statusbar="*"} 
defwinprop{instance = "stalonetray", statusbar="*"} 
defwinprop{class = "stalonetray", statusbar="*"} 
defwinprop{is_dockapp = true, statusbar="*"}
-------------------------------------[[  ETC  ]]-------------------------------------
defwinprop{class="Xfce*",float=true,lazy_resize=true}
defwinprop{class="Xmessage",float=true,lazy_resize=true}
defwinprop{class="com-sun-javaws-Main",float=true,lazy_resize=true}
defwinprop{class="Wine",target="wine",jumpto=true,tag="virt"}
defwinprop{instance="recoll",jumpto=false,winlist_ignore=true,target="search",lazy_resize=true}
defwinprop{instance="stardict",jumpto=true,winlist_ignore=true,transient_mode="off",winlist_ignore=true,target="float",lazy_resize=true}
defwinprop{instance="lxappearance",jumpto=true,winlist_ignore=true,transient_mode="off",winlist_ignore=true,target="float",lazy_resize=true}
defwinprop{class="rdesktop",instance="rdesktop",transient_mode="off",jumpto=true,target="rdesktop",lazy_resize=true}
defwinprop{class="Conky",winlist_ignore=true,lazy_resize=true,float=true}
defwinprop{class="URxvt", instance="mpd-pad",winlist_ignore=true,transient_mode="off",target="ncmpcpp",lazy_resize=true}
defwinprop{class="URxvt", instance="mpd-pad2",winlist_ignore=true,transient_mode="off",target="ncmpcpp",lazy_resize=true}
defwinprop{role="mpd",target="ncmpcpp"}
defwinprop{class="Tilda",instance="tilda",winlist_ignore=true,transient_mode="off",lazy_resize=true,float=true}
defwinprop{class="Guake",instance="guake",winlist_ignore=true,transient_mode="off",lazy_resize=true,float=true}
defwinprop{class="Pavucontrol", instance="pavucontrol",winlist_ignore=true,transient_mode="off",target="float",lazy_resize=true}
defwinprop{instance="wicd",winlist_ignore=true,transient_mode="off",target="wicd",lazy_resize=true}
defwinprop{instance="ranger",winlist_ignore=true,transient_mode="off",target="ranger",lazy_resize=true}
defwinprop{instance="console",winlist_ignore=true,transient_mode="off",target="console",lazy_resize=true}
defwinprop{instance="gdb",winlist_ignore=true,transient_mode="off",target="gdb",lazy_resize=true}
defwinprop{instance="mixer",winlist_ignore=true,transient_mode="off",target="alsa",lazy_resize=true}
defwinprop{instance="htop",winlist_ignore=true,transient_mode="off",target="top",lazy_resize=true}
defwinprop{instance="gcolor2",winlist_ignore=true,transient_mode="off",lazy_resize=true,float=true}
defwinprop{instance="gpick",winlist_ignore=true,transient_mode="off",lazy_resize=true,target=float}
defwinprop{class="Ktorrent",winlist_ignore=true,transient_mode="off",instance="ktorrent",target="torrent",lazy_resize=true, tag="torrent"}
defwinprop{class="Vuze",winlist_ignore=true,transient_mode="off",target="torrent",lazy_resize=true, tag="torrent"}
defwinprop{class="Anamnesis", winlist_ignore=true,transient_mode="off",target="float2",lazy_resize=true,jumpto=true}
defwinprop{class="Nicotine", instance="nicotine", transient_mode="off", target="float2", tag="soulseek"}
defwinprop{class="Nicotine.py", instance="nicotine.py", transient_mode="off", target="float2", tag="soulseek"}
defwinprop{class="*",instance="*", transparent=false,lazy_resize=true}
-- defwinprop{class="*",instance="*", winlist_ignore=true,transient_mode="off",target="etc",float=true,lazy_resize=true}
defwinprop { class = "Operapluginwrapper-ia32-linux", instance = "operapluginwrapper-ia32-linux",
    match = function(prop, cwin, id) return is_fullscreen(cwin); end,
    switchto = false, flash_fullscreen = true, }
defwinprop { class = "Prism", instance = "prism",
    match = function(prop, cwin, id) return is_fullscreen(cwin); end,
    switchto = false,
    flash_fullscreen = true, }
defwinprop { class = "Exe", instance = "exe", name = "exe",
    match = function(prop, cwin, id) return is_fullscreen(cwin); end,
    switchto = false, flash_fullscreen = true, }
defwinprop{class="uim-toolbar-qt4", statusbar="uim"}