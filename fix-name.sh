#!/bin/bash
set -e

clear

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
NC='\033[0m'

SECRET_KEY="nazwa"

read -rsp "Enter the key: " input_key
echo
if [ "$input_key" != "$SECRET_KEY" ]; then
  echo -e "${RED}Invalid key. Access denied.${NC}"
  exit 1
fi

echo -e "${CYAN}Select Windows Version:${NC}"
echo "1) Windows 10"
echo "2) Windows 11"
echo "3) Windows 10 Pro Ghost Spectre"
echo "4) Windows 11 Pro Ghost Spectre"
echo "5) Windows Server 2012"
echo "6) Windows Server 2016"
echo "7) Windows Server 2019"
echo "8) Windows Server 2022"
echo "9) Windows Server 2025"

read -rp "Pilih (1-9): " pilihan

LANG="en-us"
RDP_PORT="9999"
WEB_PORT="2080"

case $pilihan in
  1)
    IMG_NAME="Windows 10 Pro"
    ISO_URL="ISI_LINK_ISO_WINDOWS_10_DI_SINI"
    ;;
  2)
    IMG_NAME="Windows 11 Pro"
    ISO_URL="ISI_LINK_ISO_WINDOWS_11_DI_SINI"
    ;;
  3)
    IMG_NAME="Windows 10 Pro"
    ISO_URL="ISI_LINK_ISO_GHOST_SPECTRE_WIN10_DI_SINI"
    ;;
  4)
    IMG_NAME="Windows 11 Pro"
    ISO_URL="ISI_LINK_ISO_GHOST_SPECTRE_WIN11_DI_SINI"
    ;;
  5)
    IMG_NAME="Windows Server 2012"
    ISO_URL="ISI_LINK_ISO_SERVER_2012_DI_SINI"
    ;;
  6)
    IMG_NAME="Windows Server 2016"
    ISO_URL="ISI_LINK_ISO_SERVER_2016_DI_SINI"
    ;;
  7)
    IMG_NAME="Windows Server 2019 SERVERSTANDARD"
    ISO_URL="https://go.microsoft.com/fwlink/p/?LinkID=2195167&clcid=0x409&culture=en-us&country=US"
    ;;
  8)
    IMG_NAME="Windows Server 2022"
    ISO_URL="ISI_LINK_ISO_SERVER_2022_DI_fSINI"
    ;;
  9)
    IMG_NAME="Windows Server 2025 SERVERSTANDARD"
    ISO_URL="https://oemsoc.download.prss.microsoft.com/dbazure/X23-81958_26100.1742.240906-0331.ge_release_svc_refresh_SERVER_OEMRET_x64FRE_en-us.iso_909fa35d-ba98-407d-9fef-8df76f75e133?t=34b8db0f-439b-497c-86ce-ec7ceb898bb7&P1=102816956391&P2=601&P3=2&P4=pG1WoVpBKlyWcmfj%2bt1gYgkTsP4At28ch8mG7vIQm%2fT4elz5v2ZQ3eKAN8%2fFjb1yaa4npBaABURtnI8YmrDv8p0VJmYpLCIUQ0FHEFR4IFiPgtvzwAAI8oNdiEl%2b2uM7MN8Gaju8BvIVgHRl%2fRxq0HFgrFoEGmvHZU4jY0RFsYAaHliUinDUzdVfT0IPwyWqNUJXZTSfguyphv8XZx8OQsBy3zwBp7tNHsKl36ZO2JdZK%2fyPY7QTpAr5ccazUPEa40ALhYRBJXxlQb1F0OeO7kHhW7DKK5D4Wpt5WbpjFn8MqcZBX3%2fQI6WAwzDSKIck7jYL7bYdl2ufoMRrFZrxxw%3d%3d"
    ;;
  *)
    echo -e "${RED}Pilihan tidak valid!${NC}"
    exit 1
    ;;
esac

if [ -z "$ISO_URL" ]; then
  echo -e "${RED}ISO URL belum diisi di script!${NC}"
  exit 1
fi

read -rp "Set password sendiri? (y/N): " setpass
if [[ "$setpass" =~ ^[Yy]$ ]]; then
  read -rsp "Masukkan password Administrator: " PASSWORD
  echo
else
  PASSWORD="Admin@123!"
fi

echo -e "${RED}WARNING: Semua data akan terhapus.${NC}"
read -rp "Ketik YES untuk lanjut: " confirm
if [ "$confirm" != "YES" ]; then
  echo "Batal."
  exit 0
fi

# Download reinstall.sh
curl -fsSL -o reinstall.sh https://raw.githubusercontent.com/bin456789/reinstall/main/reinstall.sh || \
wget -O reinstall.sh https://raw.githubusercontent.com/bin456789/reinstall/main/reinstall.sh
chmod +x reinstall.sh

# Run ISO installer mode
bash reinstall.sh windows \
  --image-name "$IMG_NAME" \
  --lang "$LANG" \
  --iso "$ISO_URL" \
  --rdp-port "$RDP_PORT" \
  --web-port "$WEB_PORT" \
  --password "$PASSWORD"
