#!/system/bin/sh

URL="https://github.com/alltechdev/alltech.dev/raw/refs/heads/main/blockednumbers.db"
TMP_DB="/data/local/tmp/blockednumbers.db"
TARGET_DB="/data/user_de/0/com.android.providers.blockednumber/databases/blockednumbers.db"

# Download the new DB
wget -O "$TMP_DB" "$URL"

# If the download is valid (exists and >1KB)
if [ -f "$TMP_DB" ] && [ "$(stat -c%s "$TMP_DB")" -gt 1024 ]; then
  # Get current UID:GID of the target database file
  OWNER=$(stat -c '%u:%g' "$TARGET_DB" 2>/dev/null)

  # If no existing file, fallback to default UID (optional)
  [ -z "$OWNER" ] && OWNER="10113:10113"

  cp "$TMP_DB" "$TARGET_DB"
  chown "$OWNER" "$TARGET_DB"
  chmod 440 "$TARGET_DB"
fi