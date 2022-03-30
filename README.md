Flutter based, ip tv playlist viewer. Currently works on Android, Ios, Windows.

Windows store: https://www.microsoft.com/en-us/p/better-iptv-player/9n5x0kt56q9g?activetab=pivot:overviewtab

# What is the main problem which is solved with this app

1- On any platform there is no playerlist organizer if playlist comes without folder stracture. But here we are creating a folder stracture by checking the content name. Is the content name contains for example S01 E01 keys? if it has these words we are creating a folder stracture and placing the cotent under there.

2- On windows i have tried to use many apps and i couldn't find any good app which has a good media player and folder stracture.
Vlc is a good solution, but if playlist too big, vlc becomes very slow. Sometimes it takes 5 minute to open a playlist and also vlc does not have a folder stracture.

Solutions: 
# Android and IOS
  We are handling the playlist with Better ipTV and playing the media inside the app.
  
# Windows
  We are handling the playlist with Better ipTV, and when you select what you want to watch we are starting the VLC with that content's url.
  So on windows VLC is required and it must be already installed.
  
  -Why we don't have in app media player on windows?
  Because there is no media player flutter package which you can handle embedded subtitles and audio.

# Missing features
- [ ] Favorite system
- [ ] Search system
- [ ] A good video player control ui for ios and android
- [ ] Localizations
- [ ] Theme management
- [ ] If VLC is not installed on Windows, show error dialog.
- [ ] Custom VLC folder selection, if VLC is folder missing on Windows.(Curently app uses default Program files folder)
