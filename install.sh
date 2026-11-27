#!/usr/bin/env bash
# 把技能目录装进 DSH 技能目录
set -e
DST="${DSH_HOME:-$HOME/.dsh}/skills"
mkdir -p "$DST"
want="$1"
for dir in */; do
  person="${dir%/}"
  [ -f "$person/README.md" ] || continue
  for sk in "$person"/*/; do
    name="$(basename "$sk")"
    [ -f "$sk/SKILL.md" ] || continue
    if [ -n "$want" ] && [ "$want" != "$name" ] && [ "$want" != "$person" ]; then continue; fi
    rm -rf "$DST/$name"
    cp -r "$sk" "$DST/$name"
    echo "装好 $name  →  $DST/$name"
  done
done
