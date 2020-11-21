# vim-spotify

Get information about currently playing song on spotify.

# Install
Install the plugin using your favorite plugin manager:

[Vundle](https://github.com/VundleVim/Vundle.vim):
```
Plugin'ernestre/vim-spotify'
```
[Plug](https://github.com/junegunn/vim-plug):
```
Plug'ernestre/vim-spotify'
```
[dein](https://github.com/Shougo/dein.vim):
```
call dein#add('ernestre/vim-spotify')
```


# Requirements
* vim compiled with python3
* Currently only works on linux

# Configuration
There are some variables which you can modify in order to change the playback text:

```vim
let g:vim_spotify_playback_pattern = "{playbackIcon}{artist} - {title}"
let g:vim_spotify_icon_play = "⏯️"
let g:vim_spotify_icon_pause = "⏸️"
```
`g:vim_spotify_playback_pattern` variable has three placeholders which can change however you like:
* `let g:vim_spotify_playback_pattern = "{playbackIcon} > {artist} - {title}"`
* `let g:vim_spotify_playback_pattern = "{artist} {title} "`
* `let g:vim_spotify_playback_pattern = "{artist}:{title} | {playbackIcon} 🎶"`

*Note: Default values are using [fontawesome](https://fontawesome.com/) icons, so you might want to install [vim-devicons](https://github.com/ryanoasis/vim-devicons)*

# Integration with [lightline.vim](https://github.com/itchyny/lightline.vim)

This plugin has a `SpotifyPlayback` function, which returns information about currently playing song on spotify.
In order to show this information in the statusline, add a [component function](https://github.com/itchyny/lightline.vim#advanced-configuration) to your lightline configuration:
```vim
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste', 'spotify'],
      \             [ 'readonly', 'filename', 'modified'] ]
      \ },
      \ 'component_function': {
      \   'spotify': 'SpotifyPlayback',
      \ },
      \ }
```
