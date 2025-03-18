echo "[ INFORMATION ] Installing: Breeze Transparent Plasma Style"
# Download the Breeze Transparent Plasma Style (Thanks Gumbachi!)
curl -LJO https://github.com/Gumbachi/Breeze-Transparent/archive/refs/heads/main.zip
# Unzip the dowloaded file
unzip ./Breeze-Transparent-main.zip
# Install the Plasma Style
cp -r ./Breeze-Transparent-main /usr/share/plasma/desktoptheme/
# Delete the directory to save space
rm -rf ./Breeze-Transparent-main

rm -rf ./Breeze-Transparent-main.zip