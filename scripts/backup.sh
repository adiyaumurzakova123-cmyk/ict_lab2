#!/bin/bash
set -e

SOURCE_DIR="$HOME/ict_lab2/docs"
BACKUP_DIR="$HOME/ict_lab2/backup"
LOG_FILE="$HOME/ict_lab2/logs/backup.log"

if [ ! -d "$SOURCE_DIR" ]; then
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] Ошибка: каталог $SOURCE_DIR не найден!" >> "$LOG_FILE"
    echo "Ошибка: каталог $SOURCE_DIR не существует." >&2
    exit 1
fi

TIMESTAMP=$(date +%Y%m%d_%H%M%S)
ARCHIVE_NAME="backup_$TIMESTAMP.tar.gz"

tar -czf "$BACKUP_DIR/$ARCHIVE_NAME" -C "$SOURCE_DIR" .
echo "[$(date +'%Y-%m-%d %H:%M:%S')] Резервная копия создана: $ARCHIVE_NAME" >> "$LOG_FILE"

find "$BACKUP_DIR" -type f -name "backup_*.tar.gz" -mtime +7 -exec rm -f {} \;
