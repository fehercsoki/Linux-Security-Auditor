#!/bin/bash

# Determining paths.
# Elérési helyek meghatározása.
INSTALL_DIR="/usr/local/bin"
TOOL_DIR="$(cd "$(dirname "$0")/.." && pwd)"
SRC_DIR="$TOOL_DIR/src"

echo "Linux Security Auditor telepítése..."

# Checks if the script is run with root privileges.
# Ellenőrzi, hogy a szkript root jogosultságokkal van-e futtatva.
if [ "$(id -u)" != "0" ]; then
    echo "Ez a szkript csak root jogokkal futtatható." 1>&2
    echo "Ne aggódj, nem fogjuk átvizsgálni a hűtődet, de a rendszered biztonságát igen!" 1>&2
    exit 1
fi

# Grants execute permissions to the auditor.sh, auditor.py, and install.sh files.
# Végrehajtási jogosultságot ad az auditor.sh, auditor.py, és install.sh fájloknak.
chmod +x ../src/auditor.sh
chmod +x ../src/auditor.py
chmod +x install.sh

echo "Szükséges jogosultságok megadva!"

# Installs the required dependencies.
# Telepíti a szükséges függőségeket.
echo "Függőségek telepítése..."
apt update
apt install -y python3 python3-pip sudo
pip3 install argparse

# Creates a symbolic link to the auditor.sh file.
# Szimbólum link létrehozása az auditor.sh fájlhoz.
echo "Szimbólum link létrehozása, hogy az auditor.sh könnyen futtatható legyen."
ln -sf "$SRC_DIR/auditor.sh" "$INSTALL_DIR/auditor"

echo "Telepítés befejezve."
echo "Használat: sudo auditor"
echo "További információk és használati utasítások a README.md fájlban található."

exit 0
