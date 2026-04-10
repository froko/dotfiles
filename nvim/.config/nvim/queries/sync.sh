#!/usr/bin/env bash
#
# Sync treesitter query files from upstream nvim-treesitter.
#
# Usage:
#   ./queries/sync.sh              — sync all local languages from upstream
#   ./queries/sync.sh lua yaml     — sync only specified languages
#   ./queries/sync.sh --diff       — show what would change without writing
#   ./queries/sync.sh --diff lua   — show diff for specific languages
#
# The upstream repository and branch can be overridden:
#   UPSTREAM_REPO=https://github.com/nvim-treesitter/nvim-treesitter.git \
#   UPSTREAM_BRANCH=main \
#   ./queries/sync.sh

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
QUERIES_DIR="$SCRIPT_DIR"

UPSTREAM_REPO="${UPSTREAM_REPO:-https://github.com/nvim-treesitter/nvim-treesitter.git}"
UPSTREAM_BRANCH="${UPSTREAM_BRANCH:-main}"
UPSTREAM_QUERIES_PATH="runtime/queries"

DIFF_ONLY=false

# Parse flags
args=()
for arg in "$@"; do
  if [ "$arg" = "--diff" ]; then
    DIFF_ONLY=true
  else
    args+=("$arg")
  fi
done
set -- "${args[@]+"${args[@]}"}"

# Determine which languages to sync
if [ $# -gt 0 ]; then
  languages=("$@")
else
  languages=()
  for dir in "$QUERIES_DIR"/*/; do
    [ -d "$dir" ] || continue
    lang="$(basename "$dir")"
    [ "$lang" = "." ] || [ "$lang" = ".." ] && continue
    languages+=("$lang")
  done
fi

if [ ${#languages[@]} -eq 0 ]; then
  echo "No languages found in $QUERIES_DIR"
  exit 1
fi

# Create a temporary directory for the sparse checkout
tmp_dir="$(mktemp -d)"
trap 'rm -rf "$tmp_dir"' EXIT

echo "Fetching queries from $UPSTREAM_REPO ($UPSTREAM_BRANCH)..."
echo ""

# Clone with sparse checkout — only the queries we need
git clone --quiet --depth 1 --filter=blob:none --sparse \
  --branch "$UPSTREAM_BRANCH" "$UPSTREAM_REPO" "$tmp_dir/repo" 2>/dev/null

sparse_paths=()
for lang in "${languages[@]}"; do
  sparse_paths+=("$UPSTREAM_QUERIES_PATH/$lang")
done

git -C "$tmp_dir/repo" sparse-checkout set --no-cone "${sparse_paths[@]}" 2>/dev/null

# Record the commit hash for reference
upstream_commit="$(git -C "$tmp_dir/repo" rev-parse --short HEAD)"
echo "Upstream commit: $upstream_commit"
echo ""

# Sync each language
changed=0
skipped=0
up_to_date=0

for lang in "${languages[@]}"; do
  upstream_lang_dir="$tmp_dir/repo/$UPSTREAM_QUERIES_PATH/$lang"

  if [ ! -d "$upstream_lang_dir" ]; then
    echo "  [skip]     $lang (not found upstream)"
    skipped=$((skipped + 1))
    continue
  fi

  local_lang_dir="$QUERIES_DIR/$lang"
  lang_changed=false

  for scm_file in "$upstream_lang_dir"/*.scm; do
    [ -f "$scm_file" ] || continue
    filename="$(basename "$scm_file")"
    local_file="$local_lang_dir/$filename"

    if [ ! -f "$local_file" ]; then
      # New file upstream that we don't have locally — skip it
      continue
    fi

    if ! diff -q "$local_file" "$scm_file" > /dev/null 2>&1; then
      lang_changed=true

      if [ "$DIFF_ONLY" = true ]; then
        echo "--- $lang/$filename (local)"
        echo "+++ $lang/$filename (upstream @ $upstream_commit)"
        diff -u "$local_file" "$scm_file" || true
        echo ""
      else
        cp "$scm_file" "$local_file"
      fi
    fi
  done

  if [ "$lang_changed" = true ]; then
    if [ "$DIFF_ONLY" = true ]; then
      echo "  [changed]  $lang"
    else
      echo "  [updated]  $lang"
    fi
    changed=$((changed + 1))
  else
    echo "  [current]  $lang"
    up_to_date=$((up_to_date + 1))
  fi
done

echo ""
echo "Done. $changed updated, $up_to_date up-to-date, $skipped skipped."

if [ "$DIFF_ONLY" = true ] && [ $changed -gt 0 ]; then
  echo ""
  echo "Run without --diff to apply changes."
fi
