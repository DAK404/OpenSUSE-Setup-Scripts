echo "[ INFORMATION ] Installing: Posy's Cursor Set"
# Download the Posy's Cursor Set (Thanks Michel "Posy" de Boer and Simtrani for porting this to Linux!)
curl -LJO https://github.com/simtrami/posy-improved-cursor-linux/archive/refs/heads/main.zip
# Unzip the dowloaded file
unzip ./posy-improved-cursor-linux-main.zip
# Clean up unwanted directories and files
rm -rf ./posy-improved-cursor-linux-main/readme_files
rm -rf ./posy-improved-cursor-linux-main/README.md
# Install the cursor sets
cp -r ./posy-improved-cursor-linux-main/* /usr/share/icons
# Delete the directory
rm -rf ./posy-improved-cursor-linux-main/

rm -rf ./posy-improved-cursor-linux-main.zip