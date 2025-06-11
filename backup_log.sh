#!/bin/bash
echo "************************************************************"
echo "Memulai Proses Backup Log"
echo "************************************************************"

# Baca Direktory Sekarang
curr=${PWD}
mkdir "$curr/all_log"

LOG_DIR="$curr/all_log"

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
tar -czf all_log.tar.gz all_log

# Hapus folder sementara
rm -rf all_log

echo "Backup log selesai: all_log.tar.gz"
