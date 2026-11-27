#!/usr/bin/env bash
# sync.sh — 本机技能目录 ↔ 这个仓库 双向同步
#
#   ./sync.sh status     看哪边新（默认）
#   ./sync.sh push       本机 → 仓库（改完技能后）
#   ./sync.sh pull       仓库 → 本机（换了设备、或拉了别人的更新）
#   ./sync.sh auto       自动：哪边新就同步哪边
#   ./sync.sh push -c    push 完顺手 commit + 推 GitHub
set -euo pipefail

LIVE="${DSH_HOME:-$HOME/.dsh}/skills"
REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CMD="${1:-status}"
COMMIT="${2:-}"

# 从仓库结构推出映射：<人>/<技能名>/SKILL.md
entries() {
  local p s
  for p in "$REPO"/*/; do
    [ -f "${p}README.md" ] || continue
    for s in "$p"*/; do
      [ -f "${s}SKILL.md" ] || continue
      printf '%s\t%s\n' "$(basename "$s")" "${s%/}"
    done
  done
}

stale() {  # $1=技能名 $2=仓库目录 → 输出 live / repo / same
  local live="$LIVE/$1" dir="$2"
  [ -d "$live" ] || { echo "missing"; return; }
  local a b
  a=$(find "$live" -name SKILL.md -newer "$dir/SKILL.md" | head -1 || true)
  b=$(find "$dir" -name SKILL.md -newer "$live/SKILL.md" | head -1 || true)
  if [ -n "$a" ]; then echo live
  elif [ -n "$b" ]; then echo repo
  else echo same; fi
}

do_status() {
  local name dir state n=0
  printf '%-18s %-10s %s\n' 技能 状态 仓库路径
  while IFS=$'\t' read -r name dir; do
    state=$(stale "$name" "$dir")
    case "$state" in
      live)  printf '%-18s %-10s %s\n' "$name" "本机较新" "${dir#$REPO/}" ;;
      repo)  printf '%-18s %-10s %s\n' "$name" "仓库较新" "${dir#$REPO/}" ;;
      same)  printf '%-18s %-10s %s\n' "$name" "一致" "${dir#$REPO/}" ;;
      missing) printf '%-18s %-10s %s\n' "$name" "本机没有" "${dir#$REPO/}" ;;
    esac
    n=$((n+1))
  done < <(entries)
  [ "$n" -eq 0 ] && echo "仓库里没有技能" && return
  echo
  git -C "$REPO" status --short 2>/dev/null | sed 's/^/  仓库未提交: /' || true
}

sync_one() {  # $1=方向 $2=name $3=dir
  local name="$2" dir="$3"
  if [ "$1" = push ]; then
    mkdir -p "$LIVE/$name"
    cp -a "$LIVE/$name/." "$dir/"
    rm -f "$dir/chat.txt" "$dir"/*-chat.txt   # 语料统一放 corpus/
    echo "→ 仓库  $name"
  else
    mkdir -p "$LIVE/$name"
    rm -rf "$LIVE/$name"; mkdir -p "$LIVE/$name"
    cp -a "$dir/." "$LIVE/$name/"
    echo "← 本机  $name"
  fi
}

run() {  # $1=push|pull|auto
  local name dir state hit=0
  while IFS=$'\t' read -r name dir; do
    state=$(stale "$name" "$dir")
    case "$1:$state" in
      push:live)  sync_one push "$name" "$dir"; hit=1 ;;
      push:missing) echo "跳过 $name（本机没有，先 ./sync.sh pull）" ;;
      pull:repo)  sync_one pull "$name" "$dir"; hit=1 ;;
      pull:missing) sync_one pull "$name" "$dir"; hit=1 ;;
      auto:live)  sync_one push "$name" "$dir"; hit=1 ;;
      auto:repo)  sync_one pull "$name" "$dir"; hit=1 ;;
      auto:missing) echo "跳过 $name（本机没有，./sync.sh pull 装回来）" ;;
    esac
  done < <(entries)
  [ "$hit" -eq 0 ] && echo "没有需要同步的东西"
  if [ "$COMMIT" = "-c" ]; then
    cd "$REPO"
    git add -A
    git diff --cached --quiet && { echo "仓库无变化，不提交"; return; }
    git commit -m "sync: $(date '+%Y-%m-%d %H:%M')"
    git push
  fi
}

case "$CMD" in
  status) do_status ;;
  push|pull|auto) run "$CMD" ;;
  *) sed -n '2,8p' "$0" | sed 's/^# \{0,1\}//'; exit 1 ;;
esac
