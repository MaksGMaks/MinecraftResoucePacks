#!/usr/bin/env bash
set -e

PACKS=(
  "packs/BF5_logo.zip"
  "packs/BonaFriends 5.zip"
  "packs/Autumn Leaves.zip"
  "packs/Y'all, It's Fall!! - v4.1.0.zip"
)
BASE_META="packs/base/pack.mcmeta"
OUT="build/merged_pack"
ASSET="build/pack.zip"
REPO="MaksGMaks/MinecraftResoucePacks"
TAG="dev"

rm -rf "$OUT" "$ASSET"
mkdir -p "$OUT"

for p in "${PACKS[@]}"; do
  unzip -oq "$p" -d "$OUT"
done
cp "$BASE_META" "$OUT/pack.mcmeta"

cd "$OUT" && zip -rq "../pack.zip" . && cd ../..

SHA1=$(sha1sum "$ASSET" | awk '{print $1}')

gh release upload "$TAG" "$ASSET" --repo "$REPO" --clobber

echo "Published. Set in server.properties:"
echo "resource-pack=https://github.com/$REPO/releases/download/$TAG/pack.zip"
echo "resource-pack-sha1=$SHA1"
