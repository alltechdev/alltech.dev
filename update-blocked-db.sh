#!/system/bin/sh

URL="https://github.com/alltechdev/alltech.dev/raw/refs/heads/main/blockednumbers.db"
TMP_DB="/data/local/tmp/blockednumbers.db"
TARGET_DB="/data/user_de/0/com.android.providers.blockednumber/databases/blockednumbers.db"

wget -O "$TMP_DB" "$URL"

if [ -f "$TMP_DB" ] && [ $(stat -c%s "$TMP_DB") -gt 1024 ]; then
  cp "$TMP_DB" "$TARGET_DB"
  chown 10113:10113 "$TARGET_DB"
  chmod 660 "$TARGET_DB"
fi
