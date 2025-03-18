GITHUB_GPG_KEY_URL='https://mirror.mwt.me/shiftkey-desktop/gpgkey'
GITHUB_REPO_URL='https://mirror.mwt.me/shiftkey-desktop/rpm'
zypper --gpg-auto-import-keys addrepo --refresh "$GITHUB_REPO_URL" 'GitHub Desktop'
zypper install -y github-desktop git
