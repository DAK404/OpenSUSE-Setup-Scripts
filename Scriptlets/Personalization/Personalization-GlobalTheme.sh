echo "[ INFORMATION ] Installing: Kvantum Manager"
# Install Kvantum Manager & GTK theme requirements
zypper in -y kvantum-manager gtk2-engine-murrine sassc

# ---------------------------------------------------------- #

echo "[ INFORMATION ] Installing: KDE & Kvantum Theme"
# Download the Colloid Theme (Thanks Vinceliuice!)
curl -LJO https://github.com/vinceliuice/Colloid-kde/archive/refs/heads/main.zip
# Unzip the dowloaded file
unzip ./Colloid-kde-main.zip
# Install the KDE and Kvantum theme for ALL users (remove if you want to install to current user only)
sh ./Colloid-kde-main/install.sh
# Delete the directory to save space
rm -rf ./Colloid-kde-main

# ---------------------------------------------------------- #

echo "[ INFORMATION ] Installing: Colloid GTK Theme"
# Download the Colloid Theme (Thanks Vinceliuice!)
curl -LJO https://github.com/vinceliuice/Colloid-gtk-theme/archive/refs/heads/main.zip
# Unzip the dowloaded file
unzip ./Colloid-gtk-theme-main.zip
# Install the KDE and Kvantum theme
sh ./Colloid-gtk-theme-main/install.sh
# Delete the directory to save space
rm -rf ./Colloid-gtk-theme-main

# ---------------------------------------------------------- #

echo "[ INFORMATION ] Installing: Colloid Icon Theme"
# Download the Colloid Icon Theme (Thanks Vinceliuice!)
curl -LJO https://github.com/vinceliuice/Colloid-icon-theme/archive/refs/heads/main.zip
# Unzip the dowloaded file
unzip ./Colloid-icon-theme-main.zip
# Install the KDE and Kvantum theme
sh ./Colloid-icon-theme-main/install.sh
# Delete the directory to save space
rm -rf ./Colloid-icon-theme-main

echo "[ INFORMATION ] Cleaning Up ZIP Files"
# remove all zip files in the directory
rm -rf ./*.zip