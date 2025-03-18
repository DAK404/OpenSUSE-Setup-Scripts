rpm --import https://dl.google.com/linux/linux_signing_key.pub
zypper addrepo --refresh https://dl.google.com/linux/chrome/rpm/stable/x86_64 google-chrome
zypper refresh --gpg-auto-import-keys
zypper install google-chrome-stable