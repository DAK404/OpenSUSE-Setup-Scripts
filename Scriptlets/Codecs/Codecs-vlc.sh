VLC_REPO_URL='https://download.videolan.org/pub/vlc/SuSE/Tumbleweed/'
zypper --gpg-auto-import-keys addrepo --refresh "$VLC_REPO_URL" 'VLC'

zypper install -y ffmpeg gstreamer-plugins-{good,bad,ugly,libav}
latest_version=$(zypper search -s libavcodec | grep -Eo 'libavcodec[0-9]+' | sort -V | tail -1)
zypper install -y --from VLC --allow-vendor-change vlc-codecs x264 x265 $latest_version