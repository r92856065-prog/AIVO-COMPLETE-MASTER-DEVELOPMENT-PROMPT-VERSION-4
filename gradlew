#!/usr/bin/env sh
# Lightweight bootstrap for this source package (the original V2 archive omitted gradle-wrapper.jar).
set -eu
VERSION="8.13"
BASE="${GRADLE_USER_HOME:-$HOME/.gradle}/jarvis-bootstrap"
HOME_DIR="$BASE/gradle-$VERSION"
GRADLE="$HOME_DIR/bin/gradle"
if [ ! -x "$GRADLE" ]; then
  mkdir -p "$BASE"
  ZIP="$BASE/gradle-$VERSION-bin.zip"
  if [ ! -f "$ZIP" ]; then
    if command -v curl >/dev/null 2>&1; then
      curl -fL "https://services.gradle.org/distributions/gradle-$VERSION-bin.zip" -o "$ZIP"
    else
      echo "curl is required to download Gradle $VERSION." >&2
      exit 1
    fi
  fi
  if ! command -v unzip >/dev/null 2>&1; then
    echo "unzip is required to install Gradle $VERSION." >&2
    exit 1
  fi
  unzip -q -o "$ZIP" -d "$BASE"
fi
exec "$GRADLE" "$@"
