#!/bin/bash

LOG_DIR="all_log"
ARCHIVE_FILE="all_log.tar.gz"

# Hapus folder log lama jika ada
rm -rf "$LOG_DIR"
mkdir "$LOG_DIR"

# Salin log penting dari /var/log
cp -a /var/log/auth.log "$LOG_DIR/" 2>/dev/null
cp -a /var/log/syslog "$LOG_DIR/" 2>/dev/null
cp -a /var/log/messages "$LOG_DIR/" 2>/dev/null
cp -a /var/log/kern.log "$LOG_DIR/" 2>/dev/null
cp -a /var/log/dmesg "$LOG_DIR/" 2>/dev/null
cp -a /var/log/secure "$LOG_DIR/" 2>/dev/null
cp -a /var/log/*.log "$LOG_DIR/" 2>/dev/null

# Salin semua .log dari Apache
cp -a /var/log/apache2/*.log "$LOG_DIR/" 2>/dev/null

# Salin semua .log dari Nginx
cp -a /var/log/nginx/*.log "$LOG_DIR/" 2>/dev/null

# Buat arsip tar.gz
tar -czf "$ARCHIVE_FILE" "$LOG_DIR"

# Hapus folder sementara
rm -rf "$LOG_DIR"

echo "Backup log selesai: $ARCHIVE_FILE"