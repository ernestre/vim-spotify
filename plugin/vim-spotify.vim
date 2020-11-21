if !has('unix')
  echo "Error: vim-spotify currently only supported on unix versions of vim"
  finish
endif

if !has('python3')
  echo "Error: vim-spotify requires vim compiled with +python3"
  finish
endif

let g:vim_spotify_playback_pattern = "{playbackIcon}{artist} - {title}  "
let g:vim_spotify_icon_play = " "
let g:vim_spotify_icon_pause = " "

function! SpotifyPlayback()
let s:song = ""

python3 << EOF
import dbus
import vim

defaultPattern = "{playbackIcon}{artist} - {title}  "
defaultPlayIcon = " "
defaultPauseIcon = " "

def getPlayback():
    bus = dbus.SessionBus()
    try:
        proxy = bus.get_object('org.mpris.MediaPlayer2.spotify', '/org/mpris/MediaPlayer2')
    except dbus.DBusException:
        return
    props_iface = dbus.Interface(proxy, dbus_interface='org.freedesktop.DBus.Properties')

    playbackStatus = props_iface.Get("org.mpris.MediaPlayer2.Player", "PlaybackStatus")
    title = props_iface.Get("org.mpris.MediaPlayer2.Player", "Metadata")['xesam:title']
    artist = props_iface.Get("org.mpris.MediaPlayer2.Player", "Metadata")['xesam:artist'][0]

    if playbackStatus == "Playing":
        playbackIcon = vim.eval("g:vim_spotify_icon_play") or defaultPlayIcon
    else:
        playbackIcon = vim.eval("g:vim_spotify_icon_pause") or defaultPlayIcon

    pattern = vim.eval("g:vim_spotify_playback_pattern") or defaultPattern

    playbackString = pattern.format(playbackIcon=playbackIcon, artist=artist, title=title)

    vim.command("let s:song = '%s'" % playbackString)

getPlayback()
EOF

return s:song

endfunction
