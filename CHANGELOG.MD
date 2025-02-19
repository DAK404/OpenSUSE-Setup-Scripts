# Changelog

- [Changelog](#changelog)
  - [2.0.1](#201)
    - [Additions](#additions)
    - [Modifications:](#modifications)
    - [Deletions:](#deletions)
  - [2.0.0](#200)
    - [Additions:](#additions-1)
    - [Modifications:](#modifications-1)
    - [Deletions:](#deletions-1)


## 2.0.1

### Additions

+ Added the CHANGELOG file

### Modifications:

* Function Nomenclature: Changed functions to have only underscores
* Added `-y` to automate the installation to a few commands

### Deletions:

- `libdiscord-rpc` is no longer installed in the Discord-Install script

## 2.0.0

### Additions:

+ Message Logger: Log messages while performing setup
+ Check Internet Connection: Checks for internet connection when running the script
+ Functions: Added functions for each step making it easy to read and modify code
+ Multiple Sources For Codecs Installation: Provided multiple sources to install codecs from.
+ Run Scriptlets: Ability to run scriptlets from the main scripts
+ Argument Processing: Ability to customize an installation by using arguments
+ Log File: Script statuses are saved to log file for future reference
+ More Repositories: Added Games repository

### Modifications:

* VLC Installation: Existing VLC versions are removed before installing the ones from the official website
* Software installation happens only if an internet connection can be established.

### Deletions:

- Check For Updates: Script does not check for updates using `zypper dup`