# Tasks

These are a set of tasks that can be set to run on every login or logout.

To make sure it is easier to use the tasks, please place it in `$HOME/.tasks` directory.

## Login.sh

This script can be set to run automatically when the user logs in.

To run this script on every login in KDE Plasma, paste this script to `$HOME/.tasks/login.sh`. Next go to the autostart section in KDE settings and finally select this script. If necessary, make this executable (Plasma settings will ask once should the script be made executable).

### Functions

The following are the functionalities of the script:

+ `systemd-analyze`
  + This will save an svg file to `$HOME/.boot/bootgraph` with the current date and time.
  + This will allow the user to check the boot times and the services during boot.