#!/usr/bin/env bash
set -Eeuo pipefail

# ============================================================
#                 AERION INSTALLER v3.0
#        Pterodactyl Panel Management Script
# ============================================================
#
# Fitur:
# 1. Install Panel Lengkap + Wings + Auto Node + Nest + 5 Eggs
# 2. Install Panel Only
# 3. Install Wings Only
# 4. Install Theme
# 5. Install Blueprint
# 6. Install Auto Suspend
# 7. Install Aerion Protection
# 8. Install PHPMyAdmin
# 9. Create User Database
# 10. Reset Panel
# 11. Uninstall Panel
# 12. Start/Restart Wings
# 13. Admin Account Recovery
# 14. Ubah Password VPS
#
# ============================================================

# -----------------------------
# COLORS - MODERN SKY BLUE THEME
# -----------------------------
NC='\033[0m'
BOLD='\033[1m'
DIM='\033[2m'

# Basic Colors
BLACK='\033[0;30m'
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[0;37m'

# Bright Colors
BRIGHT_BLACK='\033[90m'
BRIGHT_RED='\033[91m'
BRIGHT_GREEN='\033[92m'
BRIGHT_YELLOW='\033[93m'
BRIGHT_BLUE='\033[94m'
BRIGHT_MAGENTA='\033[95m'
BRIGHT_CYAN='\033[96m'
BRIGHT_WHITE='\033[97m'

# Background Colors
BG_BLACK='\033[40m'
BG_RED='\033[41m'
BG_GREEN='\033[42m'
BG_YELLOW='\033[43m'
BG_BLUE='\033[44m'
BG_MAGENTA='\033[45m'
BG_CYAN='\033[46m'
BG_WHITE='\033[47m'

# Sky Blue Theme Colors
SKY_BLUE='\033[38;5;117m'
LIGHT_SKY='\033[38;5;153m'
PALE_SKY='\033[38;5;195m'
DEEP_SKY='\033[38;5;39m'
STEEL_BLUE='\033[38;5;75m'
ICE_BLUE='\033[38;5;159m'
BABY_BLUE='\033[38;5;152m'

BG_SKY_BLUE='\033[48;5;117m'
BG_LIGHT_SKY='\033[48;5;153m'
BG_DEEP_SKY='\033[48;5;39m'
BG_STEEL_BLUE='\033[48;5;75m'

# -----------------------------
# GLOBAL CONFIG
# -----------------------------
PANEL_DIR="/var/www/pterodactyl"
TMP_EGG_DIR="/tmp/aerion-eggs"
CREDENTIAL_FILE="/root/aerion-pterodactyl-credentials.txt"

PHP_VERSION="8.3"
WINGS_PORT="8080"
SFTP_PORT="2022"
DAEMON_BASE="/var/lib/pterodactyl/volumes"

DB_NAME="panel"
DB_USER="pterodactyl"
DB_PASSWORD=""

PANEL_DOMAIN=""
WINGS_DOMAIN=""
EMAIL=""

ADMIN_USERNAME=""
ADMIN_FIRSTNAME=""
ADMIN_LASTNAME=""
ADMIN_PASSWORD=""

# SSL selalu true
PANEL_SSL="true"
WINGS_SSL="true"

LOCATION_SHORT=""
LOCATION_LONG=""
NODE_NAME=""
NODE_DESCRIPTION=""

RAM_TOTAL_MB=0
RAM_NODE_MB=0
DISK_TOTAL_MB=0
DISK_NODE_MB=0

PUBLIC_IP=""
LOCATION_ID=""
NODE_ID=""

NEST_NAME="Bot"
NEST_DESCRIPTION="Bot Eggs"

# Aerion Protection Config
WATERMARK="⛔ Akses Diblokir - © Protection by Aerion"

EGG_URLS=(
"https://raw.githubusercontent.com/aerionoffc/egg/refs/heads/main/egg-node-js-v1.json"
"https://raw.githubusercontent.com/aerionoffc/egg/refs/heads/main/egg-node-js-v2--auto.json"
"https://raw.githubusercontent.com/aerionoffc/egg/refs/heads/main/egg-python--universal.json"
"https://raw.githubusercontent.com/aerionoffc/egg/refs/heads/main/egg-nginx-v3.json"
"https://raw.githubusercontent.com/aerionoffc/egg/refs/heads/main/samp.json"
)

# -----------------------------
# UI FUNCTIONS
# -----------------------------
print_info() {
    echo -e "\n  ${BG_SKY_BLUE}${BRIGHT_WHITE}${BOLD} ℹ INFO ${NC} ${SKY_BLUE}${BOLD}$1${NC}\n"
}

print_success() {
    echo -e "\n  ${BG_GREEN}${BRIGHT_WHITE}${BOLD} ✓ SUCCESS ${NC} ${GREEN}${BOLD}$1${NC}\n"
}

print_warning() {
    echo -e "\n  ${BG_YELLOW}${BRIGHT_WHITE}${BOLD} ⚠ WARNING ${NC} ${YELLOW}${BOLD}$1${NC}\n"
}

print_error() {
    echo -e "\n  ${BG_RED}${BRIGHT_WHITE}${BOLD} ✗ ERROR ${NC} ${RED}${BOLD}$1${NC}\n"
}

log_info() {
    echo -e "${SKY_BLUE}${BOLD}$1${NC}"
}

log_success() {
    echo -e "${GREEN}${BOLD}$1${NC}"
}

log_error() {
    echo -e "${RED}${BOLD}$1${NC}"
}

log_warning() {
    echo -e "${YELLOW}${BOLD}$1${NC}"
}

log_step() {
    echo -e "${LIGHT_SKY}${BOLD}  ➤ $1${NC}"
}

log_detail() {
    echo -e "${PALE_SKY}${DIM}     $1${NC}"
}

line() {
    echo -e "${SKY_BLUE}${DIM}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
}

line_light() {
    echo -e "${LIGHT_SKY}${DIM}╭──────────────────────────────────────────────────────────────╮${NC}"
}

line_light_end() {
    echo -e "${LIGHT_SKY}${DIM}╰──────────────────────────────────────────────────────────────╯${NC}"
}

banner() {
    clear 2>/dev/null || true
    echo
    echo -e "${SKY_BLUE}${BOLD}"
    echo "     ███████╗ █████╗ ██████╗ ██╗ ██████╗ ███╗   ██╗"
    echo "     ██╔════╝██╔══██╗██╔══██╗██║██╔═══██╗████╗  ██║"
    echo "     █████╗  ███████║██████╔╝██║██║   ██║██╔██╗ ██║"
    echo "     ██╔══╝  ██╔══██║██╔══██╗██║██║   ██║██║╚██╗██║"
    echo "     ███████╗██║  ██║██║  ██║██║╚██████╔╝██║ ╚████║"
    echo "     ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝ ╚═════╝ ╚═╝  ╚═══╝"
    echo -e "${NC}"
    echo -e "${ICE_BLUE}${BOLD}                 PTERODACTYL INSTALLER${NC}"
    echo -e "${PALE_SKY}${DIM}              Panel • Wings • Node • Eggs${NC}"
    echo
    line
    echo -e "${SKY_BLUE}${DIM}                          v3.0${NC}"
    line
}

require_root() {
    if [[ "$EUID" -ne 0 ]]; then
        print_error "Jalankan script sebagai root."
        exit 1
    fi
}

setup_noninteractive() {
    export DEBIAN_FRONTEND=noninteractive
    export NEEDRESTART_MODE=a
    export NEEDRESTART_SUSPEND=1
    export DEBCONF_NONINTERACTIVE_SEEN=true

    if [[ -f /etc/needrestart/needrestart.conf ]]; then
        sed -i "s/#\$nrconf{restart} = 'i';/\$nrconf{restart} = 'a';/" /etc/needrestart/needrestart.conf || true
        sed -i "s/\$nrconf{restart} = 'i';/\$nrconf{restart} = 'a';/" /etc/needrestart/needrestart.conf || true
    fi
}

check_os() {
    source /etc/os-release

    case "${ID}:${VERSION_ID}" in
        debian:12|debian:13|ubuntu:22.04|ubuntu:24.04)
            log_success "[OK] OS: ${PRETTY_NAME}"
            ;;
        *)
            print_error "OS tidak didukung. Gunakan Debian 12/13 atau Ubuntu 22.04/24.04."
            exit 1
            ;;
    esac
}

apt_base() {
    setup_noninteractive
    log_step "Updating package lists..."
    apt-get update --allow-releaseinfo-change -y
    log_step "Installing base packages..."
    apt-get install -y \
        curl wget ca-certificates gnupg lsb-release \
        apt-transport-https software-properties-common \
        unzip zip tar git cron openssl dnsutils socat acl jq
}

ask_required() {
    local prompt="$1"
    local var="$2"
    local value

    while true; do
        echo -ne "${SKY_BLUE}${BOLD}  ➤ ${prompt}${NC}: "
        read -r value
        [[ -n "$value" ]] && break
        print_warning "Input tidak boleh kosong."
    done

    printf -v "$var" '%s' "$value"
}

ask_password() {
    local prompt="$1"
    local var="$2"
    local value

    while true; do
        echo -ne "${SKY_BLUE}${BOLD}  ➤ ${prompt}${NC}: "
        read -r -s value
        echo
        [[ -n "$value" ]] && break
        print_warning "Password tidak boleh kosong."
    done

    printf -v "$var" '%s' "$value"
}

detect_resources() {
    RAM_TOTAL_MB="$(awk '/MemTotal/ {printf "%d\n",$2/1024}' /proc/meminfo)"
    DISK_TOTAL_MB="$(df -Pm "$DAEMON_BASE" 2>/dev/null | awk 'NR==2 {print $4}')"

    [[ "$RAM_TOTAL_MB" =~ ^[0-9]+$ ]] || { print_error "RAM gagal dideteksi."; return 1; }
    [[ "$DISK_TOTAL_MB" =~ ^[0-9]+$ ]] || { print_error "Disk gagal dideteksi."; return 1; }

    RAM_NODE_MB=$((RAM_TOTAL_MB * 1000))
    DISK_NODE_MB=$((DISK_TOTAL_MB * 1000))

    log_success "[OK] RAM Node : ${RAM_NODE_MB} MB (${RAM_TOTAL_MB} MB actual)"
    log_success "[OK] Disk Node: ${DISK_NODE_MB} MB (${DISK_TOTAL_MB} MB actual)"
}

format_mb() {
    local mb="$1"
    if (( mb >= 1024 )); then
        awk -v x="$mb" 'BEGIN {printf "%.2f GB", x/1024}'
    else
        echo "${mb} MB"
    fi
}

get_public_ip() {
    log_step "Detecting public IP..."
    PUBLIC_IP="$(curl -4fsS --max-time 10 https://api.ipify.org 2>/dev/null || true)"
    [[ -n "$PUBLIC_IP" ]] || PUBLIC_IP="$(curl -4fsS --max-time 10 https://ifconfig.me/ip 2>/dev/null || true)"
    [[ -n "$PUBLIC_IP" ]] || { print_error "Public IP gagal dideteksi."; return 1; }
    log_success "[OK] Public IP: $PUBLIC_IP"
}

check_domain() {
    local domain="$1"
    local resolved
    resolved="$(getent ahostsv4 "$domain" 2>/dev/null | awk '{print $1}' | sort -u | head -n1 || true)"

    if [[ -z "$resolved" ]]; then
        print_error "$domain belum resolve ke IP manapun."
        return 1
    fi

    if [[ "$resolved" != "$PUBLIC_IP" ]]; then
        print_error "$domain -> $resolved, tetapi IP VPS ini: $PUBLIC_IP"
        return 1
    fi

    log_success "[OK] $domain -> $PUBLIC_IP"
    return 0
}

# ============================================================
# INSTALL PANEL LENGKAP
# ============================================================

collect_full_config() {
    banner
    print_info "INSTALL PANEL LENGKAP: Panel + Wings + Node + Nest + 5 Eggs"
    print_info "SSL: Otomatis AKTIF untuk Panel & Wings"

    get_public_ip || return 1

    echo
    line_light
    echo -e "${SKY_BLUE}${BOLD}  PANEL DOMAIN${NC}"
    line_light_end
    echo -e "${PALE_SKY}${DIM}  Domain harus diarahkan ke IP: ${BOLD}$PUBLIC_IP${NC}"
    while true; do
        ask_required "Panel Domain" PANEL_DOMAIN
        if check_domain "$PANEL_DOMAIN"; then
            break
        else
            print_warning "Domain Panel belum mengarah ke IP VPS ini."
            echo -e "${PALE_SKY}${DIM}  Silakan arahkan DNS domain terlebih dahulu.${NC}"
            local retry
            echo -ne "${SKY_BLUE}${BOLD}  ➤ Coba lagi? [Y/N]: ${NC}"
            read -r retry
            [[ "${retry,,}" =~ ^y(es)?$ ]] || return 1
        fi
    done

    echo
    line_light
    echo -e "${SKY_BLUE}${BOLD}  EMAIL ADMIN${NC}"
    line_light_end
    ask_required "Email Admin / SSL" EMAIL

    echo
    line_light
    echo -e "${SKY_BLUE}${BOLD}  AKUN ADMIN${NC}"
    line_light_end
    ask_required "Username Admin" ADMIN_USERNAME
    ask_required "First Name" ADMIN_FIRSTNAME
    ask_required "Last Name" ADMIN_LASTNAME
    ask_password "Password Admin" ADMIN_PASSWORD

    if (( ${#ADMIN_PASSWORD} < 8 )); then
        print_error "Password admin minimal 8 karakter."
        return 1
    fi

    echo
    line_light
    echo -e "${SKY_BLUE}${BOLD}  WINGS DOMAIN${NC}"
    line_light_end
    echo -e "${PALE_SKY}${DIM}  Domain harus diarahkan ke IP: ${BOLD}$PUBLIC_IP${NC}"
    while true; do
        ask_required "Wings Domain" WINGS_DOMAIN
        if check_domain "$WINGS_DOMAIN"; then
            break
        else
            print_warning "Domain Wings belum mengarah ke IP VPS ini."
            echo -e "${PALE_SKY}${DIM}  Silakan arahkan DNS domain terlebih dahulu.${NC}"
            local retry
            echo -ne "${SKY_BLUE}${BOLD}  ➤ Coba lagi? [Y/N]: ${NC}"
            read -r retry
            [[ "${retry,,}" =~ ^y(es)?$ ]] || return 1
        fi
    done

    echo
    line_light
    echo -e "${SKY_BLUE}${BOLD}  NODE CONFIGURATION${NC}"
    line_light_end
    ask_required "Location Short Name" LOCATION_SHORT
    ask_required "Location Description" LOCATION_LONG
    ask_required "Node Name" NODE_NAME
    ask_required "Node Description" NODE_DESCRIPTION

    mkdir -p "$DAEMON_BASE"
    detect_resources

    echo
    line
    echo -e "${SKY_BLUE}${BOLD}  📋 RINGKASAN INSTALASI${NC}"
    line
    echo -e "${LIGHT_SKY}${BOLD}  Panel   ${NC}${WHITE}: https://$PANEL_DOMAIN${NC}"
    echo -e "${LIGHT_SKY}${BOLD}  Wings   ${NC}${WHITE}: https://$WINGS_DOMAIN${NC}"
    echo -e "${LIGHT_SKY}${BOLD}  Email   ${NC}${WHITE}: $EMAIL${NC}"
    echo -e "${LIGHT_SKY}${BOLD}  RAM     ${NC}${WHITE}: ${RAM_NODE_MB} MB${NC}"
    echo -e "${LIGHT_SKY}${BOLD}  Disk    ${NC}${WHITE}: ${DISK_NODE_MB} MB${NC}"
    echo -e "${LIGHT_SKY}${BOLD}  Node    ${NC}${WHITE}: $NODE_NAME${NC}"
    echo -e "${LIGHT_SKY}${BOLD}  Nest    ${NC}${WHITE}: $NEST_NAME${NC}"
    echo -e "${LIGHT_SKY}${BOLD}  Eggs    ${NC}${WHITE}: 5${NC}"
    echo -e "${LIGHT_SKY}${BOLD}  SSL     ${NC}${GREEN}: Panel ✓ | Wings ✓${NC}"
    line
    echo

    local confirm
    echo -ne "${SKY_BLUE}${BOLD}  ➤ Lanjutkan instalasi? [Y/N]: ${NC}"
    read -r confirm
    [[ "${confirm,,}" =~ ^y(es)?$ ]] || { print_warning "Dibatalkan."; return 1; }
}

# ============================================================
# INSTALL PANEL ONLY
# ============================================================

install_panel_only() {
    banner
    print_info "INSTALL PANEL ONLY"
    print_info "SSL: Otomatis AKTIF"

    get_public_ip || return 1

    echo
    ask_required "Panel Domain" PANEL_DOMAIN
    
    if ! check_domain "$PANEL_DOMAIN"; then
        print_error "Domain harus resolve ke IP VPS ini."
        return 1
    fi

    ask_required "Email Admin / SSL" EMAIL
    ask_required "Username Admin" ADMIN_USERNAME
    ask_required "First Name" ADMIN_FIRSTNAME
    ask_required "Last Name" ADMIN_LASTNAME
    ask_password "Password Admin" ADMIN_PASSWORD

    if (( ${#ADMIN_PASSWORD} < 8 )); then
        print_error "Password admin minimal 8 karakter."
        return 1
    fi

    echo
    line
    echo -e "${SKY_BLUE}${BOLD}  📋 RINGKASAN${NC}"
    line
    echo -e "${LIGHT_SKY}${BOLD}  Panel   ${NC}${WHITE}: https://$PANEL_DOMAIN${NC}"
    echo -e "${LIGHT_SKY}${BOLD}  Email   ${NC}${WHITE}: $EMAIL${NC}"
    echo -e "${LIGHT_SKY}${BOLD}  SSL     ${NC}${GREEN}: AKTIF${NC}"
    line
    echo

    local confirm
    echo -ne "${SKY_BLUE}${BOLD}  ➤ Lanjutkan instalasi? [Y/N]: ${NC}"
    read -r confirm
    [[ "${confirm,,}" =~ ^y(es)?$ ]] || { print_warning "Dibatalkan."; return 1; }

    check_os
    apt_base
    install_php
    install_database
    install_nginx
    install_composer
    configure_database
    download_panel
    configure_panel
    configure_nginx
    install_panel_ssl
    configure_queue
    configure_firewall

    echo
    line
    print_success "INSTALL PANEL ONLY SELESAI."
    echo
    echo -e "${SKY_BLUE}${BOLD}  Panel       ${NC}${WHITE}: https://$PANEL_DOMAIN${NC}"
    echo -e "${SKY_BLUE}${BOLD}  Credentials ${NC}${WHITE}: $CREDENTIAL_FILE${NC}"
    line
    echo

    save_credentials
}

# ============================================================
# INSTALL WINGS ONLY
# ============================================================

install_wings_only() {
    banner
    print_info "INSTALL WINGS ONLY"

    if [[ -d "$PANEL_DIR" ]]; then
        # Panel sudah ada, bisa ambil config dari panel
        print_info "Panel terdeteksi, akan menggunakan konfigurasi dari Panel."
        
        if [[ ! -f /etc/pterodactyl/config.yml ]]; then
            print_error "config.yml belum ada. Generate dari Panel terlebih dahulu."
            return 1
        fi
    else
        # Panel belum ada
        print_warning "Panel belum terinstall di server ini."
        print_info "Wings akan diinstall tanpa konfigurasi otomatis."
        print_info "Anda perlu generate config dari Panel setelah instalasi."
    fi

    local confirm
    echo -ne "${SKY_BLUE}${BOLD}  ➤ Lanjutkan instalasi Wings? [Y/N]: ${NC}"
    read -r confirm
    [[ "${confirm,,}" =~ ^y(es)?$ ]] || return 1

    check_os
    apt_base
    install_docker
    install_wings_binary
    configure_firewall
    start_wings_service

    print_success "INSTALL WINGS ONLY SELESAI."
    echo
    print_warning "Jika config.yml belum ada, generate dari Panel:"
    echo -e "${WHITE}  Admin Panel → Nodes → Configuration → Generate Token${NC}"
    echo -e "${WHITE}  Simpan sebagai /etc/pterodactyl/config.yml${NC}"
    echo -e "${WHITE}  Lalu restart: systemctl restart wings${NC}"
}

# ============================================================
# INSTALL PHPMyAdmin
# ============================================================

install_phpmyadmin() {
    banner
    print_info "INSTALL PHPMYADMIN"

    local PMA_DOMAIN PMA_EMAIL PMA_USER PMA_PASSWORD

    get_public_ip || return 1

    echo
    ask_required "PHPMyAdmin Domain" PMA_DOMAIN
    
    if ! check_domain "$PMA_DOMAIN"; then
        print_error "Domain harus resolve ke IP VPS ini."
        return 1
    fi

    ask_required "Email (untuk SSL)" PMA_EMAIL
    ask_required "Username PHPMyAdmin" PMA_USER
    ask_password "Password PHPMyAdmin" PMA_PASSWORD

    local confirm
    echo -ne "${SKY_BLUE}${BOLD}  ➤ Lanjutkan instalasi PHPMyAdmin? [Y/N]: ${NC}"
    read -r confirm
    [[ "${confirm,,}" =~ ^y(es)?$ ]] || return 1

    check_os
    apt_base

    log_step "Installing PHPMyAdmin..."
    apt-get install -y php8.3-fpm php8.3-mysql php8.3-mbstring php8.3-xml php8.3-curl php8.3-zip php8.3-gd

    if ! dpkg -s mariadb-server >/dev/null 2>&1; then
        apt-get install -y mariadb-server
        systemctl enable --now mariadb
    fi

    mkdir -p /var/www/phpmyadmin
    cd /var/www/phpmyadmin

    log_step "Downloading PHPMyAdmin..."
    wget -q https://files.phpmyadmin.net/phpMyAdmin/5.2.2/phpMyAdmin-5.2.2-all-languages.tar.gz
    tar xzf phpMyAdmin-5.2.2-all-languages.tar.gz
    mv phpMyAdmin-5.2.2-all-languages/* .
    rm -rf phpMyAdmin-5.2.2-all-languages phpMyAdmin-5.2.2-all-languages.tar.gz

    cp config.sample.inc.php config.inc.php
    mkdir -p tmp
    chown -R www-data:www-data .
    rm -rf config

    local secret
    secret="$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 32)"
    echo "\$cfg['blowfish_secret'] = '$secret';" >> config.inc.php

    # Create PHPMyAdmin user
    mariadb -u root <<SQL
CREATE USER IF NOT EXISTS '${PMA_USER}'@'localhost' IDENTIFIED BY '${PMA_PASSWORD}';
GRANT ALL PRIVILEGES ON *.* TO '${PMA_USER}'@'localhost' WITH GRANT OPTION;
FLUSH PRIVILEGES;
SQL

    # Nginx config
    rm -f /etc/nginx/sites-enabled/default

    cat > /etc/nginx/sites-available/phpmyadmin.conf <<EOF
server {
    listen 80;
    server_name ${PMA_DOMAIN};
    root /var/www/phpmyadmin;
    index index.php index.html;

    location / {
        try_files \$uri \$uri/ /index.php?\$query_string;
    }

    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/run/php/php8.3-fpm.sock;
        fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
    }

    location ~ /\.ht {
        deny all;
    }
}
EOF

    ln -sf /etc/nginx/sites-available/phpmyadmin.conf /etc/nginx/sites-enabled/phpmyadmin.conf
    nginx -t
    systemctl reload nginx

    # SSL
    log_step "Installing SSL..."
    apt-get install -y certbot python3-certbot-nginx

    certbot --nginx \
        --non-interactive \
        --agree-tos \
        --redirect \
        --email "$PMA_EMAIL" \
        -d "$PMA_DOMAIN"

    # Save credentials
    cat > /root/phpmyadmin_credentials.txt <<EOF
============================================================
                    AERION PHPMyAdmin
============================================================

URL       : https://${PMA_DOMAIN}
Username  : ${PMA_USER}
Password  : ${PMA_PASSWORD}

============================================================
KEEP THIS FILE PRIVATE.
============================================================
EOF

    chmod 600 /root/phpmyadmin_credentials.txt

    print_success "PHPMyAdmin berhasil diinstall!"
    echo
    echo -e "${SKY_BLUE}${BOLD}  URL       ${NC}${WHITE}: https://$PMA_DOMAIN${NC}"
    echo -e "${SKY_BLUE}${BOLD}  Username  ${NC}${WHITE}: $PMA_USER${NC}"
    echo -e "${SKY_BLUE}${BOLD}  Credentials ${NC}${WHITE}: /root/phpmyadmin_credentials.txt${NC}"
}

# ============================================================
# CREATE USER DATABASE
# ============================================================

create_user_database() {
    banner
    print_info "CREATE USER DATABASE"

    local db_user db_password

    ask_required "Username Database" db_user
    ask_password "Password Database" db_password

    local confirm
    echo -ne "${SKY_BLUE}${BOLD}  ➤ Buat user database? [Y/N]: ${NC}"
    read -r confirm
    [[ "${confirm,,}" =~ ^y(es)?$ ]] || return 1

    mariadb -u root <<SQL
CREATE USER IF NOT EXISTS '${db_user}'@'%' IDENTIFIED BY '${db_password}';
GRANT ALL PRIVILEGES ON *.* TO '${db_user}'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;
SQL

    print_success "User database berhasil dibuat!"
    echo
    echo -e "${SKY_BLUE}${BOLD}  Username  ${NC}${WHITE}: $db_user${NC}"
    echo -e "${SKY_BLUE}${BOLD}  Password  ${NC}${WHITE}: $db_password${NC}"
    echo -e "${SKY_BLUE}${BOLD}  Host      ${NC}${WHITE}: % (remote access)${NC}"
}

install_php() {
    print_info "Menginstall PHP ${PHP_VERSION}..."

    if [[ "$ID" == "ubuntu" ]]; then
        if ! grep -Rqs "ondrej/php" /etc/apt/sources.list /etc/apt/sources.list.d 2>/dev/null; then
            apt-get install -y software-properties-common
            add-apt-repository -y ppa:ondrej/php
        fi
    else
        cat > /etc/apt/sources.list.d/sury-php.list <<EOF
deb https://packages.sury.org/php/ $(lsb_release -sc) main
EOF
        curl -fsSL https://packages.sury.org/php/apt.gpg |
            gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/sury-keyring.gpg
    fi

    apt-get update --allow-releaseinfo-change -y

    apt-get install -y \
        "php${PHP_VERSION}" \
        "php${PHP_VERSION}-cli" \
        "php${PHP_VERSION}-common" \
        "php${PHP_VERSION}-gd" \
        "php${PHP_VERSION}-mysql" \
        "php${PHP_VERSION}-mbstring" \
        "php${PHP_VERSION}-tokenizer" \
        "php${PHP_VERSION}-bcmath" \
        "php${PHP_VERSION}-xml" \
        "php${PHP_VERSION}-fpm" \
        "php${PHP_VERSION}-curl" \
        "php${PHP_VERSION}-zip" \
        "php${PHP_VERSION}-opcache"

    systemctl enable --now "php${PHP_VERSION}-fpm"
}

install_database() {
    print_info "Menginstall MariaDB + Redis..."
    apt-get install -y mariadb-server mariadb-client redis-server
    systemctl enable --now mariadb
    systemctl enable --now redis-server
}

install_composer() {
    if command -v composer >/dev/null 2>&1; then
        log_success "[OK] Composer sudah tersedia."
        return
    fi

    curl -fsSL https://getcomposer.org/installer |
        php -- --install-dir=/usr/local/bin --filename=composer

    command -v composer >/dev/null 2>&1 ||
        { print_error "Composer gagal diinstall."; return 1; }
}

install_nginx() {
    apt-get install -y nginx
    systemctl enable --now nginx
}

configure_database() {
    DB_PASSWORD="$(openssl rand -hex 32)"

    mariadb <<SQL
CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\`
CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

DROP USER IF EXISTS '${DB_USER}'@'127.0.0.1';

CREATE USER '${DB_USER}'@'127.0.0.1'
IDENTIFIED BY '${DB_PASSWORD}';

GRANT ALL PRIVILEGES
ON \`${DB_NAME}\`.*
TO '${DB_USER}'@'127.0.0.1';

FLUSH PRIVILEGES;
SQL
}

download_panel() {
    print_info "Downloading Pterodactyl Panel..."
    mkdir -p "$PANEL_DIR"

    cd "$PANEL_DIR"
    rm -f panel.tar.gz

    curl -fL --retry 3 \
        -o panel.tar.gz \
        https://github.com/pterodactyl/panel/releases/latest/download/panel.tar.gz

    tar -xzf panel.tar.gz
    rm -f panel.tar.gz

    cp -n .env.example .env 2>/dev/null || true

    chmod -R 755 storage bootstrap/cache

    COMPOSER_ALLOW_SUPERUSER=1 composer install \
        --no-dev --optimize-autoloader --no-interaction

    php artisan key:generate --force
}

configure_panel() {
    cd "$PANEL_DIR"

    php artisan p:environment:setup \
        --author="$EMAIL" \
        --url="https://${PANEL_DOMAIN}" \
        --timezone="Asia/Jakarta" \
        --telemetry=false \
        --cache="redis" \
        --session="redis" \
        --queue="redis" \
        --redis-host="127.0.0.1" \
        --redis-pass="null" \
        --redis-port="6379" \
        --settings-ui=true

    php artisan p:environment:database \
        --host="127.0.0.1" \
        --port="3306" \
        --database="$DB_NAME" \
        --username="$DB_USER" \
        --password="$DB_PASSWORD"

    php artisan migrate --seed --force

    php artisan p:user:make \
        --email="$EMAIL" \
        --username="$ADMIN_USERNAME" \
        --name-first="$ADMIN_FIRSTNAME" \
        --name-last="$ADMIN_LASTNAME" \
        --password="$ADMIN_PASSWORD" \
        --admin=1

    chown -R www-data:www-data "$PANEL_DIR"
}

configure_nginx() {
    rm -f /etc/nginx/sites-enabled/default

    cat > /etc/nginx/sites-available/pterodactyl.conf <<EOF
server {
    listen 80;
    server_name ${PANEL_DOMAIN};

    root ${PANEL_DIR}/public;
    index index.php;

    client_max_body_size 100m;

    access_log /var/log/nginx/pterodactyl_access.log;
    error_log /var/log/nginx/pterodactyl_error.log;

    location / {
        try_files \$uri \$uri/ /index.php?\$query_string;
    }

    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/run/php/php${PHP_VERSION}-fpm.sock;
        fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
    }

    location ~ /\.ht {
        deny all;
    }
}
EOF

    ln -sf /etc/nginx/sites-available/pterodactyl.conf \
        /etc/nginx/sites-enabled/pterodactyl.conf

    nginx -t
    systemctl reload nginx
}

install_panel_ssl() {
    apt-get install -y certbot python3-certbot-nginx

    certbot --nginx \
        --non-interactive \
        --agree-tos \
        --redirect \
        --email "$EMAIL" \
        -d "$PANEL_DOMAIN"
}

configure_queue() {
    cat > /etc/systemd/system/pteroq.service <<EOF
[Unit]
Description=Pterodactyl Queue Worker
After=redis-server.service
Wants=redis-server.service

[Service]
User=www-data
Group=www-data
Restart=always
ExecStart=/usr/bin/php ${PANEL_DIR}/artisan queue:work --queue=high,standard,low --sleep=3 --tries=3
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF

    systemctl daemon-reload
    systemctl enable --now pteroq.service

    local cron_job="* * * * * php ${PANEL_DIR}/artisan schedule:run >> /dev/null 2>&1"
    local current_cron
    current_cron="$(crontab -u www-data -l 2>/dev/null || true)"

    if ! grep -Fqx "$cron_job" <<< "$current_cron"; then
        {
            echo "$current_cron"
            echo "$cron_job"
        } | crontab -u www-data -
    fi
}

install_docker() {
    if ! command -v docker >/dev/null 2>&1; then
        curl -fsSL https://get.docker.com/ | CHANNEL=stable bash
    fi

    systemctl enable --now docker
}

install_wings_binary() {
    mkdir -p /etc/pterodactyl "$DAEMON_BASE"

    local arch
    arch="$(uname -m)"

    case "$arch" in
        x86_64) arch="amd64" ;;
        aarch64|arm64) arch="arm64" ;;
        *) print_error "Architecture tidak didukung: $arch"; return 1 ;;
    esac

    curl -fL --retry 3 \
        -o /usr/local/bin/wings \
        "https://github.com/pterodactyl/wings/releases/latest/download/wings_linux_${arch}"

    chmod +x /usr/local/bin/wings

    cat > /etc/systemd/system/wings.service <<EOF
[Unit]
Description=Pterodactyl Wings Daemon
After=docker.service
Requires=docker.service

[Service]
User=root
WorkingDirectory=/etc/pterodactyl
LimitNOFILE=4096
ExecStart=/usr/local/bin/wings
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF

    systemctl daemon-reload
}

install_wings_ssl() {
    apt-get install -y certbot

    systemctl stop nginx || true

    certbot certonly \
        --standalone \
        --non-interactive \
        --agree-tos \
        --email "$EMAIL" \
        -d "$WINGS_DOMAIN"

    systemctl start nginx || true

    [[ -f "/etc/letsencrypt/live/$WINGS_DOMAIN/fullchain.pem" ]] ||
        { print_error "SSL Wings gagal."; return 1; }
}

create_location() {
    cd "$PANEL_DIR"

    LOCATION_ID="$(
        php artisan tinker --execute="
\$location = \Pterodactyl\Models\Location::where('short', '${LOCATION_SHORT}')->first();
echo \$location ? \$location->id : '';
" 2>/dev/null |
        grep -E '^[0-9]+$' | tail -n1 || true
    )"

    if [[ -n "$LOCATION_ID" ]]; then
        log_info "[INFO] Location sudah ada: $LOCATION_ID"
        return
    fi

    php artisan p:location:make \
        --short="$LOCATION_SHORT" \
        --long="$LOCATION_LONG"

    LOCATION_ID="$(
        php artisan tinker --execute="
\$location = \Pterodactyl\Models\Location::where('short', '${LOCATION_SHORT}')->first();
echo \$location ? \$location->id : '';
" 2>/dev/null |
        grep -E '^[0-9]+$' | tail -n1 || true
    )"

    [[ -n "$LOCATION_ID" ]] ||
        { print_error "Location ID gagal didapat."; return 1; }
}

create_node() {
    cd "$PANEL_DIR"

    NODE_ID="$(
        php artisan tinker --execute="
\$node = \Pterodactyl\Models\Node::where('name', '${NODE_NAME}')->first();
echo \$node ? \$node->id : '';
" 2>/dev/null |
        grep -E '^[0-9]+$' | tail -n1 || true
    )"

    if [[ -n "$NODE_ID" ]]; then
        log_info "[INFO] Node sudah ada: $NODE_ID"
        return
    fi

    php artisan p:node:make \
        --name="$NODE_NAME" \
        --description="$NODE_DESCRIPTION" \
        --locationId="$LOCATION_ID" \
        --fqdn="$WINGS_DOMAIN" \
        --public=1 \
        --scheme="https" \
        --proxy=0 \
        --maintenance=0 \
        --maxMemory="$RAM_NODE_MB" \
        --overallocateMemory=0 \
        --maxDisk="$DISK_NODE_MB" \
        --overallocateDisk=0 \
        --uploadSize=100 \
        --daemonListeningPort="$WINGS_PORT" \
        --daemonSFTPPort="$SFTP_PORT" \
        --daemonBase="$DAEMON_BASE"

    NODE_ID="$(
        php artisan tinker --execute="
\$node = \Pterodactyl\Models\Node::where('name', '${NODE_NAME}')->first();
echo \$node ? \$node->id : '';
" 2>/dev/null |
        grep -E '^[0-9]+$' | tail -n1 || true
    )"

    [[ -n "$NODE_ID" ]] ||
        { print_error "Node ID gagal didapat."; return 1; }
}

generate_wings_config() {
    cd "$PANEL_DIR"
    mkdir -p /etc/pterodactyl

    php artisan p:node:configuration "$NODE_ID" \
        > /etc/pterodactyl/config.yml

    [[ -s /etc/pterodactyl/config.yml ]] ||
        { print_error "config.yml gagal dibuat."; return 1; }

    chmod 600 /etc/pterodactyl/config.yml
}

download_eggs() {
    rm -rf "$TMP_EGG_DIR"
    mkdir -p "$TMP_EGG_DIR"

    local i=1

    for url in "${EGG_URLS[@]}"; do
        local file="$TMP_EGG_DIR/egg-${i}.json"

        echo
        log_info "[EGG $i/5] $url"

        curl -fL --silent --show-error --retry 3 \
            "$url" -o "$file"

        [[ -s "$file" ]] ||
            { print_error "Egg $i gagal didownload."; return 1; }

        php -r '
        $j=json_decode(file_get_contents($argv[1]),true);
        if(json_last_error()!==JSON_ERROR_NONE){
            fwrite(STDERR,"JSON ERROR: ".json_last_error_msg().PHP_EOL);
            exit(1);
        }
        if(!is_array($j)){ exit(1); }
        ' "$file"

        log_success "[OK] Egg $i valid."
        ((i++))
    done
}

import_nest_eggs() {
    download_eggs

    local importer="/tmp/aerion-import-eggs.php"

    cat > "$importer" <<'PHP'
<?php
declare(strict_types=1);

require '/var/www/pterodactyl/vendor/autoload.php';

$app = require_once '/var/www/pterodactyl/bootstrap/app.php';

$kernel = $app->make(Illuminate\Contracts\Console\Kernel::class);
$kernel->bootstrap();

use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;

$nestName = 'Bot';
$nestDescription = 'Bot Eggs';
$author = env('APP_SERVICE_AUTHOR', 'admin@pterodactyl.local');

echo "==================================================\n";
echo "          AERION NEST + EGG IMPORT\n";
echo "==================================================\n";

$nest = DB::table('nests')->where('name', $nestName)->first();

if (!$nest) {
    $nestId = DB::table('nests')->insertGetId([
        'uuid' => (string) Str::uuid(),
        'author' => $author,
        'name' => $nestName,
        'description' => $nestDescription,
        'created_at' => now(),
        'updated_at' => now(),
    ]);

    $nest = DB::table('nests')->where('id', $nestId)->first();
    echo "[OK] Nest dibuat.\n";
} else {
    echo "[OK] Nest sudah ada.\n";
}

echo "[INFO] Nest ID: {$nest->id}\n\n";

$files = glob('/tmp/aerion-eggs/*.json');
sort($files);

$success = 0;
$skipped = 0;
$failed = 0;

foreach ($files as $file) {
    echo "--------------------------------------------------\n";
    echo "IMPORT: " . basename($file) . "\n";
    echo "--------------------------------------------------\n";

    try {
        $data = json_decode(file_get_contents($file), true);

        if (json_last_error() !== JSON_ERROR_NONE) {
            throw new RuntimeException(json_last_error_msg());
        }

        $egg = $data['export'] ?? $data;

        if (!is_array($egg)) {
            throw new RuntimeException('Format Egg tidak valid.');
        }

        $name = $egg['name'] ?? pathinfo($file, PATHINFO_FILENAME);
        $description = $egg['description'] ?? '';
        $eggAuthor = $egg['author'] ?? $author;
        $uuid = $egg['uuid'] ?? (string) Str::uuid();

        $existing = DB::table('eggs')->where('uuid', $uuid)->first();

        if ($existing) {
            echo "[SKIP] Egg sudah ada. ID: {$existing->id}\n";
            $skipped++;
            continue;
        }

        $dockerImages = $egg['docker_images'] ?? [];
        if (is_array($dockerImages)) {
            $dockerImages = json_encode($dockerImages, JSON_UNESCAPED_SLASHES);
        }

        $config = $egg['config'] ?? [];

        $configFiles = $config['files'] ?? '{}';
        $configStartup = $config['startup'] ?? '{}';
        $configStop = $config['stop'] ?? '^C';

        if (is_array($configFiles)) {
            $configFiles = json_encode($configFiles, JSON_UNESCAPED_SLASHES);
        }

        if (is_array($configStartup)) {
            $configStartup = json_encode($configStartup, JSON_UNESCAPED_SLASHES);
        }

        $installation = ($egg['scripts'] ?? [])['installation'] ?? [];

        $installScript = $installation['script'] ?? '';
        $installContainer =
            $installation['container']
            ?? 'ghcr.io/pterodactyl/installers:debian';
        $installEntrypoint =
            $installation['entrypoint']
            ?? 'bash';

        $eggId = DB::table('eggs')->insertGetId([
            'uuid' => $uuid,
            'nest_id' => $nest->id,
            'author' => $eggAuthor,
            'name' => $name,
            'description' => $description,
            'docker_images' => $dockerImages,
            'config_files' => $configFiles,
            'config_startup' => $configStartup,
            'config_stop' => $configStop,
            'startup' => $egg['startup'] ?? '',
            'script_install' => $installScript,
            'script_entry' => $installEntrypoint,
            'script_container' => $installContainer,
            'copy_script_from' => null,
            'features' => isset($egg['features'])
                ? json_encode($egg['features'])
                : null,
            'force_outgoing_ip' => $egg['force_outgoing_ip'] ?? false,
            'created_at' => now(),
            'updated_at' => now(),
        ]);

        echo "[OK] Egg: {$name} | ID: {$eggId}\n";

        foreach (($egg['variables'] ?? []) as $variable) {
            $env = $variable['env_variable'] ?? null;
            if (!$env) continue;

            $exists = DB::table('egg_variables')
                ->where('egg_id', $eggId)
                ->where('env_variable', $env)
                ->exists();

            if ($exists) continue;

            DB::table('egg_variables')->insert([
                'egg_id' => $eggId,
                'name' => $variable['name'] ?? $env,
                'description' => $variable['description'] ?? '',
                'env_variable' => $env,
                'default_value' => $variable['default_value'] ?? '',
                'user_viewable' => $variable['user_viewable'] ?? true,
                'user_editable' => $variable['user_editable'] ?? true,
                'rules' => $variable['rules'] ?? null,
                'created_at' => now(),
                'updated_at' => now(),
            ]);
        }

        $success++;
    } catch (Throwable $e) {
        echo "[ERROR] {$e->getMessage()}\n";
        $failed++;
    }

    echo "\n";
}

echo "==================================================\n";
echo "IMPORT SELESAI\n";
echo "Imported : {$success}\n";
echo "Skipped  : {$skipped}\n";
echo "Failed   : {$failed}\n";
echo "==================================================\n";

exit($failed > 0 ? 1 : 0);
PHP

    php "$importer"

    cd "$PANEL_DIR"
    php artisan optimize:clear

    rm -rf "$TMP_EGG_DIR"
    rm -f "$importer"
}

start_wings_service() {
    if [[ ! -f /etc/pterodactyl/config.yml ]]; then
        print_error "/etc/pterodactyl/config.yml belum ada."
        return 1
    fi

    systemctl daemon-reload
    systemctl enable wings
    systemctl restart wings
    sleep 4

    if systemctl is-active --quiet wings; then
        print_success "Wings ONLINE / ACTIVE."
    else
        print_error "Wings gagal start."
        systemctl status wings --no-pager -l || true
        journalctl -u wings -n 50 --no-pager || true
        return 1
    fi
}

configure_firewall() {
    if command -v ufw >/dev/null 2>&1; then
        ufw allow 22/tcp >/dev/null 2>&1 || true
        ufw allow 80/tcp >/dev/null 2>&1 || true
        ufw allow 443/tcp >/dev/null 2>&1 || true
        ufw allow "${WINGS_PORT}/tcp" >/dev/null 2>&1 || true
        ufw allow "${SFTP_PORT}/tcp" >/dev/null 2>&1 || true
        ufw reload >/dev/null 2>&1 || true
    fi
}

save_credentials() {
    cat > "$CREDENTIAL_FILE" <<EOF
============================================================
                    AERION INSTALLER
============================================================

PANEL
URL       : https://${PANEL_DOMAIN}
Email     : $EMAIL
Username  : $ADMIN_USERNAME
Password  : $ADMIN_PASSWORD

DATABASE
Database  : $DB_NAME
Username  : $DB_USER
Password  : $DB_PASSWORD

WINGS
URL       : https://${WINGS_DOMAIN}
Port      : $WINGS_PORT
SFTP      : $SFTP_PORT

LOCATION
Name      : $LOCATION_SHORT
ID        : $LOCATION_ID

NODE
Name      : $NODE_NAME
ID        : $NODE_ID
RAM       : $RAM_NODE_MB MB
Disk      : $DISK_NODE_MB MB

NEST
Name      : $NEST_NAME

EGGS
1. Node.js v1
2. Node.js v2 Auto
3. Python Universal
4. Nginx v3
5. SAMP

============================================================
KEEP THIS FILE PRIVATE.
============================================================
EOF

    chmod 600 "$CREDENTIAL_FILE"
}

verify_services() {
    local services=(
        "mariadb"
        "redis-server"
        "nginx"
        "docker"
        "pteroq"
        "wings"
        "php${PHP_VERSION}-fpm"
    )

    echo
    line
    echo -e "${SKY_BLUE}${BOLD}  🔍 SERVICE STATUS${NC}"
    line
    for service in "${services[@]}"; do
        if systemctl is-active --quiet "$service"; then
            echo -e "  ${GREEN}●${NC} ${WHITE}$service${NC} : ${GREEN}ACTIVE${NC}"
        else
            echo -e "  ${RED}●${NC} ${WHITE}$service${NC} : ${RED}FAILED${NC}"
        fi
    done
    line
}

full_install() {
    if ! collect_full_config; then return; fi

    banner
    print_info "Memulai INSTALL PANEL LENGKAP..."
    print_info "SSL Panel: AKTIF | SSL Wings: AKTIF"

    check_os
    apt_base
    install_php
    install_database
    install_nginx
    install_composer
    configure_database
    download_panel
    configure_panel
    configure_nginx
    install_panel_ssl
    configure_queue
    install_docker
    install_wings_binary
    install_wings_ssl
    create_location
    create_node
    generate_wings_config
    import_nest_eggs
    configure_firewall
    start_wings_service
    verify_services
    save_credentials

    echo
    line
    print_success "INSTALL PANEL LENGKAP SELESAI."
    echo
    echo -e "${SKY_BLUE}${BOLD}  Panel       ${NC}${WHITE}: https://$PANEL_DOMAIN${NC}"
    echo -e "${SKY_BLUE}${BOLD}  Wings       ${NC}${WHITE}: https://$WINGS_DOMAIN${NC}"
    echo -e "${SKY_BLUE}${BOLD}  Node        ${NC}${WHITE}: $NODE_NAME${NC}"
    echo -e "${SKY_BLUE}${BOLD}  Location ID ${NC}${WHITE}: $LOCATION_ID${NC}"
    echo -e "${SKY_BLUE}${BOLD}  Node ID     ${NC}${WHITE}: $NODE_ID${NC}"
    echo -e "${SKY_BLUE}${BOLD}  RAM         ${NC}${WHITE}: $RAM_NODE_MB MB${NC}"
    echo -e "${SKY_BLUE}${BOLD}  Disk        ${NC}${WHITE}: $DISK_NODE_MB MB${NC}"
    echo -e "${SKY_BLUE}${BOLD}  Nest        ${NC}${WHITE}: Bot${NC}"
    echo -e "${SKY_BLUE}${BOLD}  Egg         ${NC}${WHITE}: 5${NC}"
    echo -e "${SKY_BLUE}${BOLD}  Credentials ${NC}${WHITE}: $CREDENTIAL_FILE${NC}"
    line
    echo
}

# ============================================================
# AERION PROTECTION
# ============================================================

install_protection() {
    if [[ ! -d "$PANEL_DIR" ]]; then
        print_error "Pterodactyl belum terinstall."
        return 1
    fi

    banner
    print_info "🔒 AERION PROTECTION INSTALLER"
    print_warning "Fitur ini akan membackup file yang dimodifikasi."
    
    echo -ne "${SKY_BLUE}${BOLD}  ➤ Lanjutkan instalasi protection? [y/n]: ${NC}"
    read -r confirmation
    [[ "$confirmation" =~ ^[yY]$ ]] || return

    backup_file() {
        local file_path=$1
        if [ -f "$file_path" ]; then
            cp "$file_path" "$file_path.backup.$(date +%Y%m%d_%H%M%S)"
            echo -e "${GREEN}✓ Backup created for $file_path${NC}"
        fi
    }

    create_dir() {
        local dir_path=$1
        if [ ! -d "$dir_path" ]; then
            mkdir -p "$dir_path"
            echo -e "${YELLOW}📁 Created directory: $dir_path${NC}"
        fi
    }

    write_file() {
        local file_path=$1
        local content=$2
        
        create_dir "$(dirname "$file_path")"
        backup_file "$file_path"
        
        echo "$content" > "$file_path"
        echo -e "${GREEN}✅ File updated: $file_path${NC}"
    }

    # 1. ANTI DELETE SERVER
    log_step "Installing Anti Delete Server..."
    SERVER_DELETION_SERVICE="<?php

namespace Pterodactyl\Services\Servers;

use Illuminate\Support\Facades\Auth;
use Pterodactyl\Exceptions\DisplayException;
use Illuminate\Http\Response;
use Pterodactyl\Models\Server;
use Illuminate\Support\Facades\Log;
use Illuminate\Database\ConnectionInterface;
use Pterodactyl\Repositories\Wings\DaemonServerRepository;
use Pterodactyl\Services\Databases\DatabaseManagementService;
use Pterodactyl\Exceptions\Http\Connection\DaemonConnectionException;

class ServerDeletionService
{
    protected bool \$force = false;

    public function __construct(
        private ConnectionInterface \$connection,
        private DaemonServerRepository \$daemonServerRepository,
        private DatabaseManagementService \$databaseManagementService
    ) {
    }

    public function withForce(bool \$bool = true): self
    {
        \$this->force = \$bool;
        return \$this;
    }

    public function handle(Server \$server): void
    {
        \$user = Auth::user();

        if (\$user) {
            if (\$user->id !== 1) {
                \$ownerId = \$server->owner_id
                    ?? \$server->user_id
                    ?? (\$server->owner?->id ?? null)
                    ?? (\$server->user?->id ?? null);

                if (\$ownerId === null) {
                    throw new DisplayException('Akses ditolak: informasi pemilik server tidak tersedia.');
                }

                if (\$ownerId !== \$user->id) {
                    throw new DisplayException('$WATERMARK');
                }
            }
        }

        try {
            \$this->daemonServerRepository->setServer(\$server)->delete();
        } catch (DaemonConnectionException \$exception) {
            if (!\$this->force && \$exception->getStatusCode() !== Response::HTTP_NOT_FOUND) {
                throw \$exception;
            }

            Log::warning(\$exception);
        }

        \$this->connection->transaction(function () use (\$server) {
            foreach (\$server->databases as \$database) {
                try {
                    \$this->databaseManagementService->delete(\$database);
                } catch (\Exception \$exception) {
                    if (!\$this->force) {
                        throw \$exception;
                    }

                    \$database->delete();
                    Log::warning(\$exception);
                }
            }

            \$server->delete();
        });
    }
}"
    write_file "$PANEL_DIR/app/Services/Servers/ServerDeletionService.php" "$SERVER_DELETION_SERVICE"

    # 2. ANTI DELETE USER
    log_step "Installing Anti Delete User..."
    USER_CONTROLLER="<?php

namespace Pterodactyl\Http\Controllers\Admin;

use Illuminate\View\View;
use Illuminate\Http\Request;
use Pterodactyl\Models\User;
use Pterodactyl\Models\Model;
use Illuminate\Support\Collection;
use Illuminate\Http\RedirectResponse;
use Prologue\Alerts\AlertsMessageBag;
use Spatie\QueryBuilder\QueryBuilder;
use Illuminate\View\Factory as ViewFactory;
use Pterodactyl\Exceptions\DisplayException;
use Pterodactyl\Http\Controllers\Controller;
use Illuminate\Contracts\Translation\Translator;
use Pterodactyl\Services\Users\UserUpdateService;
use Pterodactyl\Traits\Helpers\AvailableLanguages;
use Pterodactyl\Services\Users\UserCreationService;
use Pterodactyl\Services\Users\UserDeletionService;
use Pterodactyl\Http\Requests\Admin\UserFormRequest;
use Pterodactyl\Http\Requests\Admin\NewUserFormRequest;
use Pterodactyl\Contracts\Repository\UserRepositoryInterface;

class UserController extends Controller
{
    use AvailableLanguages;

    public function __construct(
        protected AlertsMessageBag \$alert,
        protected UserCreationService \$creationService,
        protected UserDeletionService \$deletionService,
        protected Translator \$translator,
        protected UserUpdateService \$updateService,
        protected UserRepositoryInterface \$repository,
        protected ViewFactory \$view
    ) {
    }

    public function index(Request \$request): View
    {
        \$users = QueryBuilder::for(
            User::query()->select('users.*')
                ->selectRaw('COUNT(DISTINCT(subusers.id)) as subuser_of_count')
                ->selectRaw('COUNT(DISTINCT(servers.id)) as servers_count')
                ->leftJoin('subusers', 'subusers.user_id', '=', 'users.id')
                ->leftJoin('servers', 'servers.owner_id', '=', 'users.id')
                ->groupBy('users.id')
        )
            ->allowedFilters(['username', 'email', 'uuid'])
            ->allowedSorts(['id', 'uuid'])
            ->paginate(50);

        return \$this->view->make('admin.users.index', ['users' => \$users]);
    }

    public function create(): View
    {
        return \$this->view->make('admin.users.new', [
            'languages' => \$this->getAvailableLanguages(true),
        ]);
    }

    public function view(User \$user): View
    {
        return \$this->view->make('admin.users.view', [
            'user' => \$user,
            'languages' => \$this->getAvailableLanguages(true),
        ]);
    }

    public function delete(Request \$request, User \$user): RedirectResponse
    {
        if (\$request->user()->id !== 1) {
            throw new DisplayException(\"$WATERMARK\");
        }

        if (\$request->user()->id === \$user->id) {
            throw new DisplayException(\$this->translator->get('admin/user.exceptions.user_has_servers'));
        }

        \$this->deletionService->handle(\$user);

        return redirect()->route('admin.users');
    }

    public function store(NewUserFormRequest \$request): RedirectResponse
    {
        \$user = \$this->creationService->handle(\$request->normalize());
        \$this->alert->success(\$this->translator->get('admin/user.notices.account_created'))->flash();

        return redirect()->route('admin.users.view', \$user->id);
    }

    public function update(UserFormRequest \$request, User \$user): RedirectResponse
    {
        \$restrictedFields = ['email', 'first_name', 'last_name', 'password'];

        foreach (\$restrictedFields as \$field) {
            if (\$request->filled(\$field) && \$request->user()->id !== 1) {
                throw new DisplayException(\"$WATERMARK\");
            }
        }

        if (\$user->root_admin && \$request->user()->id !== 1) {
            throw new DisplayException(\"$WATERMARK\");
        }

        \$this->updateService
            ->setUserLevel(User::USER_LEVEL_ADMIN)
            ->handle(\$user, \$request->normalize());

        \$this->alert->success(trans('admin/user.notices.account_updated'))->flash();

        return redirect()->route('admin.users.view', \$user->id);
    }

    public function json(Request \$request): Model|Collection
    {
        \$users = QueryBuilder::for(User::query())->allowedFilters(['email'])->paginate(25);

        if (\$request->query('user_id')) {
            \$user = User::query()->findOrFail(\$request->input('user_id'));
            \$user->md5 = md5(strtolower(\$user->email));

            return \$user;
        }

        return \$users->map(function (\$item) {
            \$item->md5 = md5(strtolower(\$item->email));

            return \$item;
        });
    }
}"
    write_file "$PANEL_DIR/app/Http/Controllers/Admin/UserController.php" "$USER_CONTROLLER"

    # 3. ANTI INTIP LOCATION
    log_step "Installing Anti Intip Location..."
    LOCATION_CONTROLLER="<?php

namespace Pterodactyl\Http\Controllers\Admin;

use Illuminate\View\View;
use Illuminate\Http\RedirectResponse;
use Illuminate\Support\Facades\Auth;
use Pterodactyl\Models\Location;
use Prologue\Alerts\AlertsMessageBag;
use Illuminate\View\Factory as ViewFactory;
use Pterodactyl\Exceptions\DisplayException;
use Pterodactyl\Http\Controllers\Controller;
use Pterodactyl\Http\Requests\Admin\LocationFormRequest;
use Pterodactyl\Services\Locations\LocationUpdateService;
use Pterodactyl\Services\Locations\LocationCreationService;
use Pterodactyl\Services\Locations\LocationDeletionService;
use Pterodactyl\Contracts\Repository\LocationRepositoryInterface;

class LocationController extends Controller
{
    public function __construct(
        protected AlertsMessageBag \$alert,
        protected LocationCreationService \$creationService,
        protected LocationDeletionService \$deletionService,
        protected LocationRepositoryInterface \$repository,
        protected LocationUpdateService \$updateService,
        protected ViewFactory \$view
    ) {
    }

    public function index(): View
    {
        \$user = Auth::user();
        if (!\$user || \$user->id !== 1) {
            abort(403, '$WATERMARK');
        }

        return \$this->view->make('admin.locations.index', [
            'locations' => \$this->repository->getAllWithDetails(),
        ]);
    }

    public function view(int \$id): View
    {
        \$user = Auth::user();
        if (!\$user || \$user->id !== 1) {
            abort(403, '$WATERMARK');
        }

        return \$this->view->make('admin.locations.view', [
            'location' => \$this->repository->getWithNodes(\$id),
        ]);
    }

    public function create(LocationFormRequest \$request): RedirectResponse
    {
        \$user = Auth::user();
        if (!\$user || \$user->id !== 1) {
            abort(403, '$WATERMARK');
        }

        \$location = \$this->creationService->handle(\$request->normalize());
        \$this->alert->success('Location was created successfully.')->flash();

        return redirect()->route('admin.locations.view', \$location->id);
    }

    public function update(LocationFormRequest \$request, Location \$location): RedirectResponse
    {
        \$user = Auth::user();
        if (!\$user || \$user->id !== 1) {
            abort(403, '$WATERMARK');
        }

        if (\$request->input('action') === 'delete') {
            return \$this->delete(\$location);
        }

        \$this->updateService->handle(\$location->id, \$request->normalize());
        \$this->alert->success('Location was updated successfully.')->flash();

        return redirect()->route('admin.locations.view', \$location->id);
    }

    public function delete(Location \$location): RedirectResponse
    {
        \$user = Auth::user();
        if (!\$user || \$user->id !== 1) {
            abort(403, '$WATERMARK');
        }

        try {
            \$this->deletionService->handle(\$location->id);
            return redirect()->route('admin.locations');
        } catch (DisplayException \$ex) {
            \$this->alert->danger(\$ex->getMessage())->flash();
        }

        return redirect()->route('admin.locations.view', \$location->id);
    }
}"
    write_file "$PANEL_DIR/app/Http/Controllers/Admin/LocationController.php" "$LOCATION_CONTROLLER"

    # 4. ANTI INTIP NODES
    log_step "Installing Anti Intip Nodes..."
    NODE_CONTROLLER="<?php

namespace Pterodactyl\Http\Controllers\Admin\Nodes;

use Illuminate\View\View;
use Illuminate\Http\Request;
use Pterodactyl\Models\Node;
use Spatie\QueryBuilder\QueryBuilder;
use Pterodactyl\Http\Controllers\Controller;
use Illuminate\Contracts\View\Factory as ViewFactory;
use Illuminate\Support\Facades\Auth;

class NodeController extends Controller
{
    public function __construct(private ViewFactory \$view)
    {
    }

    public function index(Request \$request): View
    {
        \$user = Auth::user();
        if (!\$user || \$user->id !== 1) {
            abort(403, '$WATERMARK');
        }

        \$nodes = QueryBuilder::for(
            Node::query()->with('location')->withCount('servers')
        )
            ->allowedFilters(['uuid', 'name'])
            ->allowedSorts(['id'])
            ->paginate(25);

        return \$this->view->make('admin.nodes.index', ['nodes' => \$nodes]);
    }
}"
    write_file "$PANEL_DIR/app/Http/Controllers/Admin/Nodes/NodeController.php" "$NODE_CONTROLLER"

    # 5. ANTI INTIP NEST
    log_step "Installing Anti Intip Nest..."
    NEST_CONTROLLER="<?php

namespace Pterodactyl\Http\Controllers\Admin\Nests;

use Illuminate\View\View;
use Illuminate\Http\RedirectResponse;
use Prologue\Alerts\AlertsMessageBag;
use Illuminate\View\Factory as ViewFactory;
use Pterodactyl\Http\Controllers\Controller;
use Pterodactyl\Services\Nests\NestUpdateService;
use Pterodactyl\Services\Nests\NestCreationService;
use Pterodactyl\Services\Nests\NestDeletionService;
use Pterodactyl\Contracts\Repository\NestRepositoryInterface;
use Pterodactyl\Http\Requests\Admin\Nest\StoreNestFormRequest;
use Illuminate\Support\Facades\Auth;

class NestController extends Controller
{
    public function __construct(
        protected AlertsMessageBag \$alert,
        protected NestCreationService \$nestCreationService,
        protected NestDeletionService \$nestDeletionService,
        protected NestRepositoryInterface \$repository,
        protected NestUpdateService \$nestUpdateService,
        protected ViewFactory \$view
    ) {
    }

    public function index(): View
    {
        \$user = Auth::user();
        if (!\$user || \$user->id !== 1) {
            abort(403, '$WATERMARK');
        }

        return \$this->view->make('admin.nests.index', [
            'nests' => \$this->repository->getWithCounts(),
        ]);
    }

    public function create(): View
    {
        return \$this->view->make('admin.nests.new');
    }

    public function store(StoreNestFormRequest \$request): RedirectResponse
    {
        \$nest = \$this->nestCreationService->handle(\$request->normalize());
        \$this->alert->success(trans('admin/nests.notices.created', ['name' => htmlspecialchars(\$nest->name)]))->flash();

        return redirect()->route('admin.nests.view', \$nest->id);
    }

    public function view(int \$nest): View
    {
        return \$this->view->make('admin.nests.view', [
            'nest' => \$this->repository->getWithEggServers(\$nest),
        ]);
    }

    public function update(StoreNestFormRequest \$request, int \$nest): RedirectResponse
    {
        \$this->nestUpdateService->handle(\$nest, \$request->normalize());
        \$this->alert->success(trans('admin/nests.notices.updated'))->flash();

        return redirect()->route('admin.nests.view', \$nest);
    }

    public function destroy(int \$nest): RedirectResponse
    {
        \$this->nestDeletionService->handle(\$nest);
        \$this->alert->success(trans('admin/nests.notices.deleted'))->flash();

        return redirect()->route('admin.nests');
    }
}"
    write_file "$PANEL_DIR/app/Http/Controllers/Admin/Nests/NestController.php" "$NEST_CONTROLLER"

    # 6. ANTI INTIP SETTINGS
    log_step "Installing Anti Intip Settings..."
    SETTINGS_CONTROLLER="<?php

namespace Pterodactyl\Http\Controllers\Admin\Settings;

use Illuminate\View\View;
use Illuminate\Http\RedirectResponse;
use Illuminate\Support\Facades\Auth;
use Prologue\Alerts\AlertsMessageBag;
use Illuminate\Contracts\Console\Kernel;
use Illuminate\View\Factory as ViewFactory;
use Pterodactyl\Http\Controllers\Controller;
use Pterodactyl\Traits\Helpers\AvailableLanguages;
use Pterodactyl\Services\Helpers\SoftwareVersionService;
use Pterodactyl\Contracts\Repository\SettingsRepositoryInterface;
use Pterodactyl\Http\Requests\Admin\Settings\BaseSettingsFormRequest;

class IndexController extends Controller
{
    use AvailableLanguages;

    public function __construct(
        private AlertsMessageBag \$alert,
        private Kernel \$kernel,
        private SettingsRepositoryInterface \$settings,
        private SoftwareVersionService \$versionService,
        private ViewFactory \$view
    ) {
    }

    public function index(): View
    {
        \$user = Auth::user();
        if (!\$user || \$user->id !== 1) {
            abort(403, '$WATERMARK');
        }

        return \$this->view->make('admin.settings.index', [
            'version' => \$this->versionService,
            'languages' => \$this->getAvailableLanguages(true),
        ]);
    }

    public function update(BaseSettingsFormRequest \$request): RedirectResponse
    {
        \$user = Auth::user();
        if (!\$user || \$user->id !== 1) {
            abort(403, '$WATERMARK');
        }

        foreach (\$request->normalize() as \$key => \$value) {
            \$this->settings->set('settings::' . \$key, \$value);
        }

        \$this->kernel->call('queue:restart');
        \$this->alert->success(
            'Panel settings have been updated successfully and the queue worker was restarted to apply these changes.'
        )->flash();

        return redirect()->route('admin.settings');
    }
}"
    write_file "$PANEL_DIR/app/Http/Controllers/Admin/Settings/IndexController.php" "$SETTINGS_CONTROLLER"

    # 7. ANTI AKSES/INTIP SERVER - FileController
    log_step "Installing Anti Akses Server (FileController)..."
    FILE_CONTROLLER="<?php

namespace Pterodactyl\Http\Controllers\Api\Client\Servers;

use Carbon\CarbonImmutable;
use Illuminate\Http\Response;
use Illuminate\Http\JsonResponse;
use Pterodactyl\Models\Server;
use Pterodactyl\Facades\Activity;
use Pterodactyl\Services\Nodes\NodeJWTService;
use Pterodactyl\Repositories\Wings\DaemonFileRepository;
use Pterodactyl\Transformers\Api\Client\FileObjectTransformer;
use Pterodactyl\Http\Controllers\Api\Client\ClientApiController;
use Pterodactyl\Http\Requests\Api\Client\Servers\Files\CopyFileRequest;
use Pterodactyl\Http\Requests\Api\Client\Servers\Files\PullFileRequest;
use Pterodactyl\Http\Requests\Api\Client\Servers\Files\ListFilesRequest;
use Pterodactyl\Http\Requests\Api\Client\Servers\Files\ChmodFilesRequest;
use Pterodactyl\Http\Requests\Api\Client\Servers\Files\DeleteFileRequest;
use Pterodactyl\Http\Requests\Api\Client\Servers\Files\RenameFileRequest;
use Pterodactyl\Http\Requests\Api\Client\Servers\Files\CreateFolderRequest;
use Pterodactyl\Http\Requests\Api\Client\Servers\Files\CompressFilesRequest;
use Pterodactyl\Http\Requests\Api\Client\Servers\Files\DecompressFilesRequest;
use Pterodactyl\Http\Requests\Api\Client\Servers\Files\GetFileContentsRequest;
use Pterodactyl\Http\Requests\Api\Client\Servers\Files\WriteFileContentRequest;

class FileController extends ClientApiController
{
    public function __construct(
        private NodeJWTService \$jwtService,
        private DaemonFileRepository \$fileRepository
    ) {
        parent::__construct();
    }

    private function checkServerAccess(\$request, Server \$server)
    {
        \$user = \$request->user();

        if (\$user->id === 1) {
            return;
        }

        if (\$server->owner_id !== \$user->id) {
            abort(403, '$WATERMARK');
        }
    }

    public function directory(ListFilesRequest \$request, Server \$server): array
    {
        \$this->checkServerAccess(\$request, \$server);

        \$contents = \$this->fileRepository
            ->setServer(\$server)
            ->getDirectory(\$request->get('directory') ?? '/');

        return \$this->fractal->collection(\$contents)
            ->transformWith(\$this->getTransformer(FileObjectTransformer::class))
            ->toArray();
    }

    public function contents(GetFileContentsRequest \$request, Server \$server): Response
    {
        \$this->checkServerAccess(\$request, \$server);

        \$response = \$this->fileRepository->setServer(\$server)->getContent(
            \$request->get('file'),
            config('pterodactyl.files.max_edit_size')
        );

        Activity::event('server:file.read')->property('file', \$request->get('file'))->log();

        return new Response(\$response, Response::HTTP_OK, ['Content-Type' => 'text/plain']);
    }

    public function download(GetFileContentsRequest \$request, Server \$server): array
    {
        \$this->checkServerAccess(\$request, \$server);

        \$token = \$this->jwtService
            ->setExpiresAt(CarbonImmutable::now()->addMinutes(15))
            ->setUser(\$request->user())
            ->setClaims([
                'file_path' => rawurldecode(\$request->get('file')),
                'server_uuid' => \$server->uuid,
            ])
            ->handle(\$server->node, \$request->user()->id . \$server->uuid);

        Activity::event('server:file.download')->property('file', \$request->get('file'))->log();

        return [
            'object' => 'signed_url',
            'attributes' => [
                'url' => sprintf(
                    '%s/download/file?token=%s',
                    \$server->node->getConnectionAddress(),
                    \$token->toString()
                ),
            ],
        ];
    }

    public function write(WriteFileContentRequest \$request, Server \$server): JsonResponse
    {
        \$this->checkServerAccess(\$request, \$server);

        \$this->fileRepository->setServer(\$server)->putContent(\$request->get('file'), \$request->getContent());

        Activity::event('server:file.write')->property('file', \$request->get('file'))->log();

        return new JsonResponse([], Response::HTTP_NO_CONTENT);
    }

    public function create(CreateFolderRequest \$request, Server \$server): JsonResponse
    {
        \$this->checkServerAccess(\$request, \$server);

        \$this->fileRepository
            ->setServer(\$server)
            ->createDirectory(\$request->input('name'), \$request->input('root', '/'));

        Activity::event('server:file.create-directory')
            ->property('name', \$request->input('name'))
            ->property('directory', \$request->input('root'))
            ->log();

        return new JsonResponse([], Response::HTTP_NO_CONTENT);
    }

    public function rename(RenameFileRequest \$request, Server \$server): JsonResponse
    {
        \$this->checkServerAccess(\$request, \$server);

        \$this->fileRepository
            ->setServer(\$server)
            ->renameFiles(\$request->input('root'), \$request->input('files'));

        Activity::event('server:file.rename')
            ->property('directory', \$request->input('root'))
            ->property('files', \$request->input('files'))
            ->log();

        return new JsonResponse([], Response::HTTP_NO_CONTENT);
    }

    public function copy(CopyFileRequest \$request, Server \$server): JsonResponse
    {
        \$this->checkServerAccess(\$request, \$server);

        \$this->fileRepository
            ->setServer(\$server)
            ->copyFile(\$request->input('location'));

        Activity::event('server:file.copy')->property('file', \$request->input('location'))->log();

        return new JsonResponse([], Response::HTTP_NO_CONTENT);
    }

    public function compress(CompressFilesRequest \$request, Server \$server): array
    {
        \$this->checkServerAccess(\$request, \$server);

        \$file = \$this->fileRepository->setServer(\$server)->compressFiles(
            \$request->input('root'),
            \$request->input('files')
        );

        Activity::event('server:file.compress')
            ->property('directory', \$request->input('root'))
            ->property('files', \$request->input('files'))
            ->log();

        return \$this->fractal->item(\$file)
            ->transformWith(\$this->getTransformer(FileObjectTransformer::class))
            ->toArray();
    }

    public function decompress(DecompressFilesRequest \$request, Server \$server): JsonResponse
    {
        \$this->checkServerAccess(\$request, \$server);

        set_time_limit(300);

        \$this->fileRepository->setServer(\$server)->decompressFile(
            \$request->input('root'),
            \$request->input('file')
        );

        Activity::event('server:file.decompress')
            ->property('directory', \$request->input('root'))
            ->property('files', \$request->input('file'))
            ->log();

        return new JsonResponse([], JsonResponse::HTTP_NO_CONTENT);
    }

    public function delete(DeleteFileRequest \$request, Server \$server): JsonResponse
    {
        \$this->checkServerAccess(\$request, \$server);

        \$this->fileRepository->setServer(\$server)->deleteFiles(
            \$request->input('root'),
            \$request->input('files')
        );

        Activity::event('server:file.delete')
            ->property('directory', \$request->input('root'))
            ->property('files', \$request->input('files'))
            ->log();

        return new JsonResponse([], Response::HTTP_NO_CONTENT);
    }

    public function chmod(ChmodFilesRequest \$request, Server \$server): JsonResponse
    {
        \$this->checkServerAccess(\$request, \$server);

        \$this->fileRepository->setServer(\$server)->chmodFiles(
            \$request->input('root'),
            \$request->input('files')
        );

        return new JsonResponse([], Response::HTTP_NO_CONTENT);
    }

    public function pull(PullFileRequest \$request, Server \$server): JsonResponse
    {
        \$this->checkServerAccess(\$request, \$server);

        \$this->fileRepository->setServer(\$server)->pull(
            \$request->input('url'),
            \$request->input('directory'),
            \$request->safe(['filename', 'use_header', 'foreground'])
        );

        Activity::event('server:file.pull')
            ->property('directory', \$request->input('directory'))
            ->property('url', \$request->input('url'))
            ->log();

        return new JsonResponse([], Response::HTTP_NO_CONTENT);
    }
}"
    write_file "$PANEL_DIR/app/Http/Controllers/Api/Client/Servers/FileController.php" "$FILE_CONTROLLER"

    # 8. ANTI AKSES/INTIP SERVER - ServerController
    log_step "Installing Anti Akses Server (ServerController)..."
    SERVER_CONTROLLER="<?php

namespace Pterodactyl\Http\Controllers\Api\Client\Servers;

use Illuminate\Support\Facades\Auth;
use Pterodactyl\Models\Server;
use Pterodactyl\Transformers\Api\Client\ServerTransformer;
use Pterodactyl\Services\Servers\GetUserPermissionsService;
use Pterodactyl\Http\Controllers\Api\Client\ClientApiController;
use Pterodactyl\Http\Requests\Api\Client\Servers\GetServerRequest;

class ServerController extends ClientApiController
{
    public function __construct(private GetUserPermissionsService \$permissionsService)
    {
        parent::__construct();
    }

    public function index(GetServerRequest \$request, Server \$server): array
    {
        \$authUser = Auth::user();

        if (\$authUser->id !== 1 && (int) \$server->owner_id !== (int) \$authUser->id) {
            abort(403, '$WATERMARK');
        }

        return \$this->fractal->item(\$server)
            ->transformWith(\$this->getTransformer(ServerTransformer::class))
            ->addMeta([
                'is_server_owner' => \$request->user()->id === \$server->owner_id,
                'user_permissions' => \$this->permissionsService->handle(\$server, \$request->user()),
            ])
            ->toArray();
    }
}"
    write_file "$PANEL_DIR/app/Http/Controllers/Api/Client/Servers/ServerController.php" "$SERVER_CONTROLLER"

    # Run artisan commands
    log_step "Running artisan commands..."
    cd "$PANEL_DIR"
    
    php artisan cache:clear
    php artisan view:clear
    php artisan config:clear
    
    # Set permissions
    log_step "Setting permissions..."
    chown -R www-data:www-data "$PANEL_DIR"
    chmod -R 755 "$PANEL_DIR/storage"
    chmod -R 755 "$PANEL_DIR/bootstrap/cache"
    
    # Restart services
    log_step "Restarting services..."
    systemctl restart nginx
    systemctl restart "php${PHP_VERSION}-fpm"

    print_success "🔒 AERION PROTECTION SELESAI DIINSTALL!"
    echo
    line_light
    echo -e "${SKY_BLUE}${BOLD}  PROTECTION AKTIF${NC}"
    line_light_end
    echo -e "  ${GREEN}✅${NC} Anti Delete Server"
    echo -e "  ${GREEN}✅${NC} Anti Delete User"
    echo -e "  ${GREEN}✅${NC} Anti Intip Location"
    echo -e "  ${GREEN}✅${NC} Anti Intip Nodes"
    echo -e "  ${GREEN}✅${NC} Anti Intip Nest"
    echo -e "  ${GREEN}✅${NC} Anti Intip Settings"
    echo -e "  ${GREEN}✅${NC} Anti Akses Server Orang"
    echo
    echo -e "${SKY_BLUE}${BOLD}  Watermark:${NC} ${WHITE}$WATERMARK${NC}"
    line_light_end
    echo
}

# ============================================================
# THEME INSTALLER
# ============================================================

install_theme() {
    local SELECT_THEME THEME_NAME THEME_URL
    local LINK_ADMIN LINK_CHANNEL LINK_GROUP
    local TEMP_DIR

    while true; do
        banner
        line_light
        echo -e "${SKY_BLUE}${BOLD}  STANDARD THEME${NC}"
        line_light_end
        echo -e "  ${WHITE}[1]${NC} ${LIGHT_SKY}Stellar${NC}"
        echo -e "  ${WHITE}[2]${NC} ${LIGHT_SKY}Billing${NC}"
        echo -e "  ${WHITE}[3]${NC} ${LIGHT_SKY}Enigma${NC}"
        echo -e "  ${WHITE}[4]${NC} ${LIGHT_SKY}Elysium${NC}"
        echo -e "  ${WHITE}[5]${NC} ${LIGHT_SKY}Frostcore${NC}"
        echo -e "  ${WHITE}[6]${NC} ${LIGHT_SKY}Nightcore${NC}"
        echo -e "  ${WHITE}[7]${NC} ${LIGHT_SKY}IceMinecraft${NC}"
        echo -e "  ${WHITE}[8]${NC} ${LIGHT_SKY}Noobe${NC}"
        echo -e "  ${WHITE}[9]${NC} ${LIGHT_SKY}Reviactyl${NC}"
        echo
        line_light
        echo -e "${SKY_BLUE}${BOLD}  BLUEPRINT THEME${NC}"
        line_light_end
        echo -e "  ${WHITE}[b1]${NC} ${LIGHT_SKY}Nebula V1.8-3${NC}"
        echo -e "  ${WHITE}[b2]${NC} ${LIGHT_SKY}Nebula V2.0-1${NC}"
        echo -e "  ${WHITE}[b3]${NC} ${LIGHT_SKY}Recolor${NC}"
        echo -e "  ${WHITE}[b4]${NC} ${LIGHT_SKY}NavySeals${NC}"
        echo -e "  ${WHITE}[b5]${NC} ${LIGHT_SKY}LememTheme${NC}"
        echo -e "  ${WHITE}[b6]${NC} ${LIGHT_SKY}Darkenate${NC}"
        echo -e "  ${WHITE}[b7]${NC} ${LIGHT_SKY}AbyssPurple${NC}"
        echo
        echo -e "  ${WHITE}[x]${NC} ${DIM}Kembali${NC}"
        echo

        echo -ne "${SKY_BLUE}${BOLD}  ➤ Pilihan: ${NC}"
        read -r SELECT_THEME

        case "$SELECT_THEME" in
            1) THEME_NAME="Stellar"; THEME_URL="https://cdn.jsdelivr.net/gh/Bangsano/themeinstaller@main/theme/stellar.zip"; break ;;
            2) THEME_NAME="Billing"; THEME_URL="https://cdn.jsdelivr.net/gh/Bangsano/themeinstaller@main/theme/billing.zip"; break ;;
            3) THEME_NAME="Enigma"; THEME_URL="https://cdn.jsdelivr.net/gh/Bangsano/themeinstaller@main/theme/enigma.zip"; break ;;
            4) THEME_NAME="Elysium"; THEME_URL="https://cdn.jsdelivr.net/gh/Bangsano/themeinstaller@main/theme/elysium.zip"; break ;;
            5) THEME_NAME="Frostcore"; THEME_URL="https://cdn.jsdelivr.net/gh/Bangsano/themeinstaller@main/theme/frostcore.zip"; break ;;
            6) THEME_NAME="Nightcore"; THEME_URL="https://cdn.jsdelivr.net/gh/Bangsano/themeinstaller@main/theme/nightcore.zip"; break ;;
            7) THEME_NAME="IceMinecraft"; THEME_URL="https://cdn.jsdelivr.net/gh/Bangsano/themeinstaller@main/theme/iceMinecraft.zip"; break ;;
            8) THEME_NAME="Noobe"; THEME_URL="https://cdn.jsdelivr.net/gh/Bangsano/themeinstaller@main/theme/noobe.zip"; break ;;
            9) install_timpa "https://github.com/reviactyl/panel/releases/latest/download/panel.tar.gz" "Reviactyl"; return ;;
            b1|B1) THEME_NAME="Nebula V1.8-3"; THEME_URL="https://cdn.jsdelivr.net/gh/Bangsano/themeinstaller@main/theme/nebula_v1.8-3.zip"; break ;;
            b2|B2) THEME_NAME="Nebula V2.0-1"; THEME_URL="https://cdn.jsdelivr.net/gh/Bangsano/themeinstaller@main/theme/nebula_v2.0-1.zip"; break ;;
            b3|B3) THEME_NAME="Recolor"; THEME_URL="https://cdn.jsdelivr.net/gh/Bangsano/themeinstaller@main/theme/recolor.zip"; break ;;
            b4|B4) THEME_NAME="NavySeals"; THEME_URL="https://cdn.jsdelivr.net/gh/Bangsano/themeinstaller@main/theme/navyseals.zip"; break ;;
            b5|B5) THEME_NAME="LememTheme"; THEME_URL="https://cdn.jsdelivr.net/gh/Bangsano/themeinstaller@main/theme/lemem.zip"; break ;;
            b6|B6) THEME_NAME="Darkenate"; THEME_URL="https://cdn.jsdelivr.net/gh/Bangsano/themeinstaller@main/theme/darkenate.zip"; break ;;
            b7|B7) THEME_NAME="AbyssPurple"; THEME_URL="https://cdn.jsdelivr.net/gh/Bangsano/themeinstaller@main/theme/abysspurple.zip"; break ;;
            x|X) return ;;
            *) print_error "Pilihan tidak valid."; sleep 1 ;;
        esac
    done

    if [[ "$SELECT_THEME" == "3" ]]; then
        ask_required "Link Admin (https://...)" LINK_ADMIN
        ask_required "Link Channel (https://...)" LINK_CHANNEL
        ask_required "Link Group (https://...)" LINK_GROUP
    fi

    echo -ne "${SKY_BLUE}${BOLD}  ➤ Install $THEME_NAME? [y/n]: ${NC}"
    read -r confirmation
    [[ "$confirmation" =~ ^[yY]$ ]] || return

    apt_base
    TEMP_DIR="$(mktemp -d)"

    trap 'rm -rf "$TEMP_DIR"' RETURN

    cd "$TEMP_DIR"
    curl -fL --retry 3 "$THEME_URL" -o theme.zip

    if [[ "$SELECT_THEME" =~ ^[bB] ]]; then
        if [[ ! -f "$PANEL_DIR/blueprint.sh" ]]; then
            print_error "Blueprint belum terinstall. Install Blueprint terlebih dahulu."
            return 1
        fi

        unzip -oq theme.zip

        local bp_file
        bp_file="$(find . -maxdepth 1 -name "*.blueprint" -print -quit || true)"

        [[ -n "$bp_file" ]] ||
            { print_error "File .blueprint tidak ditemukan."; return 1; }

        local filename identifier
        filename="$(basename "$bp_file")"
        identifier="${filename%.blueprint}"

        cp "$bp_file" "$PANEL_DIR/$filename"
        cd "$PANEL_DIR"

        if command -v blueprint >/dev/null 2>&1; then
            blueprint -install "$identifier"
        elif [[ -x "$PANEL_DIR/blueprint.sh" ]]; then
            bash "$PANEL_DIR/blueprint.sh" -install "$identifier"
        else
            print_error "Blueprint command tidak ditemukan."
            return 1
        fi

        rm -f "$PANEL_DIR/$filename"
    else
        unzip -oq theme.zip

        [[ -d "$PANEL_DIR" ]] ||
            { print_error "Pterodactyl tidak ditemukan."; return 1; }

        if [[ "$SELECT_THEME" == "3" ]]; then
            local dashboard_file="$TEMP_DIR/pterodactyl/resources/scripts/components/dashboard/DashboardContainer.tsx"

            if [[ -f "$dashboard_file" ]]; then
                sed -i "s|LINK_ADMIN|$LINK_ADMIN|g" "$dashboard_file"
                sed -i "s|LINK_CHANNEL|$LINK_CHANNEL|g" "$dashboard_file"
                sed -i "s|LINK_GROUP|$LINK_GROUP|g" "$dashboard_file"
            fi
        fi

        if [[ -d "$TEMP_DIR/pterodactyl" ]]; then
            cp -rfT "$TEMP_DIR/pterodactyl" "$PANEL_DIR"
        fi

        cd "$PANEL_DIR"

        apt-get install -y nodejs npm
        npm install -g yarn

        yarn add cross-env react-feather
        yarn install

        if [[ "$SELECT_THEME" == "2" ]]; then
            php artisan billing:install stable || true
        fi

        export NODE_OPTIONS=--openssl-legacy-provider
        php artisan migrate --force || true
        yarn build:production
        php artisan optimize:clear
        chown -R www-data:www-data "$PANEL_DIR"
    fi

    print_success "Tema '$THEME_NAME' berhasil diproses."
}

install_timpa() {
    local TARGET_URL="$1"
    local TARGET_NAME="$2"
    local TEMP_DIR

    echo -ne "${SKY_BLUE}${BOLD}  ➤ Install $TARGET_NAME? [y/n]: ${NC}"
    read -r confirmation
    [[ "$confirmation" =~ ^[yY]$ ]] || return

    [[ -d "$PANEL_DIR" ]] ||
        { print_error "Pterodactyl tidak ditemukan."; return 1; }

    TEMP_DIR="$(mktemp -d)"

    print_info "Backup .env..."
    [[ -f "$PANEL_DIR/.env" ]] && cp "$PANEL_DIR/.env" "$TEMP_DIR/.env"

    cd "$TEMP_DIR"

    if [[ "$TARGET_URL" == *.zip ]]; then
        curl -fL "$TARGET_URL" -o panel.zip
        unzip -oq panel.zip
    else
        curl -fL "$TARGET_URL" -o panel.tar.gz
        tar -xzf panel.tar.gz
    fi

    cd "$PANEL_DIR"
    php artisan down || true

    find . -mindepth 1 -delete

    if [[ -f "$TEMP_DIR/.env" ]]; then
        cp "$TEMP_DIR/.env" "$PANEL_DIR/.env"
    fi

    if [[ -d "$TEMP_DIR/pterodactyl" ]]; then
        cp -rfT "$TEMP_DIR/pterodactyl" "$PANEL_DIR"
    else
        find "$TEMP_DIR" -mindepth 1 -maxdepth 1 \
            ! -name ".env" \
            -exec cp -rf {} "$PANEL_DIR/" \;
    fi

    cd "$PANEL_DIR"

    composer install --no-dev --optimize-autoloader --no-interaction
    php artisan migrate --seed --force
    php artisan optimize:clear
    php artisan up

    chown -R www-data:www-data "$PANEL_DIR"

    rm -rf "$TEMP_DIR"

    print_success "$TARGET_NAME selesai."
}

install_blueprint() {
    if [[ ! -d "$PANEL_DIR" ]]; then
        print_error "Pterodactyl belum terinstall."
        return 1
    fi

    echo -ne "${SKY_BLUE}${BOLD}  ➤ Install Blueprint? [y/n]: ${NC}"
    read -r confirmation
    [[ "$confirmation" =~ ^[yY]$ ]] || return

    apt_base

    local download_url
    download_url="$(
        curl -fsSL https://api.github.com/repos/BlueprintFramework/framework/releases/latest |
        jq -r '.assets[] | select(.name=="release.zip") | .browser_download_url' |
        head -n1
    )"

    [[ -n "$download_url" ]] ||
        { print_error "Release Blueprint tidak ditemukan."; return 1; }

    curl -fL "$download_url" -o /tmp/blueprint.zip
    unzip -oq /tmp/blueprint.zip -d "$PANEL_DIR"
    rm -f /tmp/blueprint.zip

    apt-get install -y nodejs npm
    npm install -g yarn

    cd "$PANEL_DIR"
    yarn add cross-env
    yarn install

    [[ -f "$PANEL_DIR/blueprint.sh" ]] &&
        chmod +x "$PANEL_DIR/blueprint.sh"

    chown -R www-data:www-data "$PANEL_DIR"

    print_success "Blueprint selesai diinstall."
}

install_auto_suspend() {
    print_warning "Fitur Auto Suspend memodifikasi source code Pterodactyl."
    print_warning "Pastikan backup panel/database tersedia."

    echo -ne "${SKY_BLUE}${BOLD}  ➤ Lanjutkan? [y/n]: ${NC}"
    read -r confirmation
    [[ "$confirmation" =~ ^[yY]$ ]] || return

    [[ -d "$PANEL_DIR" ]] ||
        { print_error "Pterodactyl belum terinstall."; return 1; }

    local temp_dir
    temp_dir="$(mktemp -d)"

    cd "$temp_dir"
    apt_base

    apt-get install -y nodejs npm
    npm install -g yarn

    curl -fL \
        https://cdn.jsdelivr.net/gh/Bangsano/themeinstaller@main/autosuspend.zip \
        -o autosuspend.zip

    unzip -oq autosuspend.zip

    if [[ -d pterodactyl ]]; then
        cp -rf pterodactyl/* "$PANEL_DIR/"
    fi

    cd "$PANEL_DIR"

    if [[ -f app/Console/Kernel.php ]] &&
       ! grep -q "use Pterodactyl\\\\Models\\\\Server;" app/Console/Kernel.php; then
        sed -i "/use Ramsey\\\\Uuid\\\\Uuid;/a use Pterodactyl\\\\Models\\\\Server;" \
            app/Console/Kernel.php || true
    fi

    php artisan migrate --force
    yarn add cross-env
    yarn install

    export NODE_OPTIONS=--openssl-legacy-provider
    yarn run build:production

    php artisan optimize:clear
    chown -R www-data:www-data "$PANEL_DIR"

    rm -rf "$temp_dir"

    print_success "Auto Suspend selesai diproses."
}

reset_panel() {
    [[ -d "$PANEL_DIR" ]] ||
        { print_error "Pterodactyl tidak ditemukan."; return 1; }

    print_warning "Reset akan mengganti source code panel dan mempertahankan .env."
    echo -ne "${SKY_BLUE}${BOLD}  ➤ Yakin? [y/n]: ${NC}"
    read -r confirmation
    [[ "$confirmation" =~ ^[yY]$ ]] || return

    local backup
    backup="$(mktemp -d)"

    [[ -f "$PANEL_DIR/.env" ]] &&
        cp "$PANEL_DIR/.env" "$backup/.env"

    cd "$PANEL_DIR"
    php artisan down || true

    find . -mindepth 1 -delete

    curl -fL \
        https://github.com/pterodactyl/panel/releases/latest/download/panel.tar.gz |
        tar -xzf - -C "$PANEL_DIR"

    [[ -f "$backup/.env" ]] &&
        cp "$backup/.env" "$PANEL_DIR/.env"

    cd "$PANEL_DIR"

    chmod -R 755 storage bootstrap/cache

    COMPOSER_ALLOW_SUPERUSER=1 composer install \
        --no-dev --optimize-autoloader --no-interaction

    php artisan migrate --seed --force
    php artisan optimize:clear
    php artisan up

    chown -R www-data:www-data "$PANEL_DIR"

    rm -rf "$backup"

    systemctl restart nginx || true
    systemctl restart pteroq || true
    systemctl restart "php${PHP_VERSION}-fpm" || true

    print_success "Panel berhasil di-reset."
}

uninstall_panel() {
    print_warning "PERINGATAN: ini operasi DESTRUKTIF."
    echo -e "${RED}${BOLD}  Panel, konfigurasi Wings, service Pterodactyl, dan database panel dapat terhapus.${NC}"
    echo
    echo -ne "${SKY_BLUE}${BOLD}  ➤ Ketik UNINSTALL untuk melanjutkan: ${NC}"
    read -r confirmation
    [[ "$confirmation" == "UNINSTALL" ]] || { print_warning "Dibatalkan."; return; }

    if [[ -f "$PANEL_DIR/.env" ]]; then
        local db_name db_user
        db_name="$(grep '^DB_DATABASE=' "$PANEL_DIR/.env" | cut -d= -f2-)"
        db_user="$(grep '^DB_USERNAME=' "$PANEL_DIR/.env" | cut -d= -f2-)"

        mariadb -u root <<SQL || true
DROP DATABASE IF EXISTS \`${db_name}\`;
DROP USER IF EXISTS '${db_user}'@'127.0.0.1';
FLUSH PRIVILEGES;
SQL
    fi

    systemctl disable --now wings pteroq 2>/dev/null || true

    rm -rf "$PANEL_DIR"
    rm -rf /etc/pterodactyl
    rm -rf /var/lib/pterodactyl
    rm -f /usr/local/bin/wings
    rm -f /etc/systemd/system/wings.service
    rm -f /etc/systemd/system/pteroq.service

    rm -f /etc/nginx/sites-enabled/pterodactyl.conf
    rm -f /etc/nginx/sites-available/pterodactyl.conf

    systemctl daemon-reload
    systemctl restart nginx 2>/dev/null || true

    print_success "Pterodactyl berhasil dihapus."
    print_warning "Docker sengaja TIDAK menghapus semua container secara otomatis."
}

start_wings_menu() {
    if [[ ! -f /etc/pterodactyl/config.yml ]]; then
        print_error "config.yml Wings tidak ditemukan."
        return 1
    fi

    systemctl daemon-reload
    systemctl enable wings
    systemctl restart wings

    sleep 3

    if systemctl is-active --quiet wings; then
        print_success "Wings ACTIVE / ONLINE."
    else
        print_error "Wings gagal aktif."
        systemctl status wings --no-pager -l || true
        journalctl -u wings -n 50 --no-pager || true
    fi
}

admin_recovery() {
    [[ -d "$PANEL_DIR" ]] ||
        { print_error "Pterodactyl belum terinstall."; return 1; }

    local user password
    echo -ne "${SKY_BLUE}${BOLD}  ➤ Username admin baru: ${NC}"
    read -r user
    echo -ne "${SKY_BLUE}${BOLD}  ➤ Password admin baru: ${NC}"
    read -r -s password
    echo

    [[ -n "$user" && -n "$password" ]] ||
        { print_error "Username/password tidak boleh kosong."; return 1; }

    cd "$PANEL_DIR"

    if printf 'yes\n%s@admin.local\n%s\n%s\n%s\n%s\n' \
        "$user" "$user" "$user" "$user" "$password" |
        php artisan p:user:make; then

        print_success "Akun admin berhasil dibuat."
        echo -e "${SKY_BLUE}${BOLD}  Username:${NC} ${WHITE}$user${NC}"
        echo -e "${SKY_BLUE}${BOLD}  Password:${NC} ${WHITE}[yang baru dimasukkan]${NC}"
    else
        print_error "Gagal membuat akun admin."
        return 1
    fi
}

change_vps_password() {
    local p1 p2

    while true; do
        echo -ne "${SKY_BLUE}${BOLD}  ➤ Password VPS baru: ${NC}"
        read -r -s p1
        echo
        echo -ne "${SKY_BLUE}${BOLD}  ➤ Ulangi password: ${NC}"
        read -r -s p2
        echo

        [[ "$p1" == "$p2" ]] && break
        print_error "Password tidak cocok."
    done

    if printf '%s\n%s\n' "$p1" "$p2" | passwd; then
        print_success "Password VPS berhasil diubah."
    else
        print_error "Gagal mengubah password VPS."
    fi
}

main_menu() {
    require_root
    setup_noninteractive

    while true; do
        banner

        line_light
        echo -e "${SKY_BLUE}${BOLD}  MENU UTAMA${NC}"
        line_light_end
        echo
        echo -e "  ${WHITE}[1]${NC} ${GREEN}${BOLD}Install Panel Lengkap${NC} ${DIM}+ Wings + Node + Nest + Eggs${NC}"
        echo -e "  ${WHITE}[2]${NC} ${LIGHT_SKY}Install Panel Only${NC}"
        echo -e "  ${WHITE}[3]${NC} ${LIGHT_SKY}Install Wings Only${NC}"
        echo -e "  ${WHITE}[4]${NC} ${LIGHT_SKY}Install Theme${NC}"
        echo -e "  ${WHITE}[5]${NC} ${LIGHT_SKY}Install Blueprint${NC}"
        echo -e "  ${WHITE}[6]${NC} ${LIGHT_SKY}Install Auto Suspend${NC}"
        echo -e "  ${WHITE}[7]${NC} ${LIGHT_SKY}Install Aerion Protection${NC}"
        echo -e "  ${WHITE}[8]${NC} ${LIGHT_SKY}Install PHPMyAdmin${NC}"
        echo -e "  ${WHITE}[9]${NC} ${LIGHT_SKY}Create User Database${NC}"
        echo -e "  ${WHITE}[10]${NC} ${YELLOW}Reset Panel${NC}"
        echo -e "  ${WHITE}[11]${NC} ${RED}Uninstall Panel${NC}"
        echo -e "  ${WHITE}[12]${NC} ${LIGHT_SKY}Start / Restart Wings${NC}"
        echo -e "  ${WHITE}[13]${NC} ${LIGHT_SKY}Admin Account Recovery${NC}"
        echo -e "  ${WHITE}[14]${NC} ${LIGHT_SKY}Ubah Password VPS${NC}"
        echo -e "  ${WHITE}[x]${NC} ${DIM}Exit${NC}"
        echo
        line

        echo -ne "${SKY_BLUE}${BOLD}  Aerion Installer ${NC}${WHITE}>${NC} "
        read -r choice

        case "$choice" in
            1) full_install ;;
            2) install_panel_only ;;
            3) install_wings_only ;;
            4) install_theme ;;
            5) install_blueprint ;;
            6) install_auto_suspend ;;
            7) install_protection ;;
            8) install_phpmyadmin ;;
            9) create_user_database ;;
            10) reset_panel ;;
            11) uninstall_panel ;;
            12) start_wings_menu ;;
            13) admin_recovery ;;
            14) change_vps_password ;;
            x|X)
                echo
                print_success "Terima kasih telah menggunakan Aerion Installer."
                exit 0
                ;;
            *)
                print_error "Pilihan tidak valid."
                ;;
        esac

        echo
        echo -ne "${DIM}  Tekan ENTER untuk kembali ke menu...${NC}"
        read -r _
    done
}

main_menu
