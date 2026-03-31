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
    ISO_URL="https://software.download.prss.microsoft.com/dbazure/Win10_22H2_English_x64v1.iso?t=b872906d-af1a-4727-8cc0-523606a19bb3&P1=1774962609&P2=601&P3=2&P4=qQj5zjt%2bvhOMjsK6fMMmyh2E12HTK8GtshwkPgnWsZ0yW7DwyKloDBDeFHPTMCq5x%2ftxS1%2f%2f73xMl%2fhvyp1S26HbQyAn2WIBOLiMZsGYjAYmHacAbZxO%2frsi42e63cm7IcwAjiiBxGuhXljDPei1tSsBM%2bG%2fONlpFZezgBXd4kpjNMfd%2fFVenv38HQMJ644rFazmHoIWB8FJDFDKye4ViLwobJsAzFUjrL2lXS3z3fMATXn6FfR1igbPd7O6BS4uP7FbmgDiyCjxPVDBRT25wJAdUzelkKZBcft0Vprb9aD%2bXbDYQ9gB5mAor21blwa9qiPcusCx6TOTKMkcpAc%2fTQ%3d%3d"
    ;;
  2)
    IMG_NAME="Windows 11 Pro"
    ISO_URL="https://software.download.prss.microsoft.com/dbazure/Win11_25H2_English_x64_v2.iso?t=2b7442b3-845c-42f6-b2f5-c6fdaeb1b6cc&P1=1774962652&P2=601&P3=2&P4=lC6XE5Jx4f%2fI0h49hHjViR56DfnNggOm7ofiHL6I1PliMghX%2bOmI%2fjaLymvI02tIPMfwGaC0M5tE39NvddVIJD0mcSnvufrlbM650Q6z0pxxykZxVivENOLpdJ0AvO1v5IiVFX9Y2qQ0aBv43lY5iklc6t9NNhTKvD4lgWy7hrpuJKpAPJuLX7xQ3cGSXbJ2vMMwOugQwpZtK50GcIcsUCLTAxY60zuLEIvFhZbIY56lftTDZPRuepFss9W9D9B8D1lYdzkUr5nfdnnz%2fOl%2ficSKsfFK4ZcFoJSGF9ZHDG%2fRQfBkA0ln%2fRUIJCjDm3cD4rt9h59iwLVPudXhPrfeGA%3d%3d"
    ;;
  3)
    IMG_NAME="Windows 10 Pro Ghost Soectre"
    ISO_URL="ISI_LINK_ISO_GHOST_SPECTRE_WIN10_DI_SINI"
    ;;
  4)
    IMG_NAME="Windows 11 Pro Ghost Spectre"
    ISO_URL="ISI_LINK_ISO_GHOST_SPECTRE_WIN11_DI_SINI"
    ;;
  5)
    IMG_NAME="Windows Server 2016 SERVERSTANDARD"
    ISO_URL="https://go.microsoft.com/fwlink/p/?LinkID=2195174&clcid=0x409&culture=en-us&country=US"
    ;;
  6)
    IMG_NAME="Windows Server 2019 SERVERSTANDARD"
    ISO_URL="https://go.microsoft.com/fwlink/p/?LinkID=2195167&clcid=0x409&culture=en-us&country=US"
    ;;
  7)
    IMG_NAME="Windows Server 2022 SERVERSTANDARD"
    ISO_URL="https://pastabillites.to/d/mqkzecgxo6ll?v=x5uwEViWLbfbwx3xBRf7V8hoDqvL9IZt9xOF7xYlpk9Vbe6Kh69MQFrufZ2T0Yuv9aD7MVM1U3ER_ew3cBlk0yV_tGjNUvbFC3QoEkJAAejcbjVr0hMkRv5VaDZpGCa5ua8YMTCjnznK4ElTc0PyYMEyptSaDvqOuLuSA-nuoG35sebOHHh2S2A5QSfTMbLTiyG0KNU45s8Wpwb9lHaTHvyd5NJgOkbpaF-iGFudaZCKiDQM-wJag2fb5AzD7vD8XhLY-Rs0LKWqBRXyAM05cZUr7zNE"
    ;;
  8)
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
  PASSWORD="SKYNEST#123"
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
