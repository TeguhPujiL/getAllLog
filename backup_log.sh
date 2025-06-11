#!/bin/bash

echo "************************************************************"
echo "Memulai Proses Backup Log"
echo "************************************************************"

# Baca direktori saat ini
curr=$(pwd)

LOG_DIR="$curr/all_log"
ARCHIVE_FILE="$curr/all_log.tar.gz"

# Hapus folder log lama jika ada
rm -rf "$LOG_DIR"
mkdir -p "$LOG_DIR"

# Daftar file log yang ingin disalin
LOG_FILES=(
    "/var/log/auth.log"
    "/var/log/syslog"
    "/var/log/messages"
    "/var/log/kern.log"
    "/var/log/dmesg"
    "/var/log/secure"
)

# Salin file log jika ada
for file in "${LOG_FILES[@]}"; do
    [ -f "$file" ] && cp -a "$file" "$LOG_DIR/"
done

# Salin semua .log dari /var/log
cp -a /var/log/*.log "$LOG_DIR/" 2>/dev/null

# Salin semua .log dari Apache jika ada
if [ -d /var/log/apache2 ]; then
    cp -a /var/log/apache2/*.log "$LOG_DIR/" 2>/dev/null
fi

# Salin semua .log dari Nginx jika ada
if [ -d /var/log/nginx ]; then
    cp -a /var/log/nginx/*.log "$LOG_DIR/" 2>/dev/null
fi

# Buat arsip tar.gz
tar -czf "$ARCHIVE_FILE" -C "$curr" "all_log"

# Hapus folder sementara
rm -rf "$LOG_DIR"

echo "Backup log selesai: $ARCHIVE_FILE"
