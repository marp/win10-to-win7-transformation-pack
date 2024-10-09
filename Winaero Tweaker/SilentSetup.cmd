cd /d %~dp0
Set SetupApp=WinaeroTweaker-1.63.0.0-setup.exe

: Install the app silently.
%SetupApp% /SP- /VERYSILENT

: Install the app to a custom directory.
: %SetupApp% /SP- /VERYSILENT /DIR="c:\wt_normal"

: Portable mode: Silently extract the app files to the folder c:\WinaeroTweaker.
:%SetupApp% /SP- /VERYSILENT /PORTABLE

: Portable mode: Silently extract the app files to a custom folder.
:%SetupApp% /SP- /VERYSILENT /PORTABLE /DIR="c:\wt_portable"