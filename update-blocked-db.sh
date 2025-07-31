#!/system/bin/sh

while true; do
  URL="https://github.com/alltechdev/alltech.dev/raw/refs/heads/main/blockednumbers.db"
  TMP_DB="/data/local/tmp/blockednumbers.db"
  TARGET_DB="/data/user_de/0/com.android.providers.blockednumber/databases/blockednumbers.db"

  # Download the updated DB
  wget -O "$TMP_DB" "$URL"

  # Validate the file exists and is not empty
  if [ -f "$TMP_DB" ] && [ "$(stat -c%s "$TMP_DB")" -gt 1024 ]; then
    # Determine correct UID:GID from existing file or its directory
    if [ -f "$TARGET_DB" ]; then
      OWNER=$(stat -c '%u:%g' "$TARGET_DB")
    else
      OWNER=$(stat -c '%u:%g' "$(dirname "$TARGET_DB")")
    fi

    # Replace the target DB
    cp "$TMP_DB" "$TARGET_DB"
    chown "$OWNER" "$TARGET_DB"
    chmod 644 "$TARGET_DB"
  fi

  sleep 21600  # sleep for 6 hours
done