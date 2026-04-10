#!/usr/bin/env bash
#
# Manage Neovim plugin templates via symlinks.
#
# Usage:
#   ./templates/manage.sh enable  <name...>  — symlink templates into plugin/
#   ./templates/manage.sh disable <name...>  — remove symlinks from plugin/
#   ./templates/manage.sh list               — show all templates and their status
#
# Run from the nvim config root directory:
#   cd ~/.config/nvim && ./templates/manage.sh list

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
CONFIG_DIR="$(dirname "$SCRIPT_DIR")"
TEMPLATES_DIR="$CONFIG_DIR/templates"
PLUGIN_DIR="$CONFIG_DIR/plugin"

usage() {
  echo "Usage: $0 {enable|disable|list} [template-name...]"
  exit 1
}

ensure_plugin_dir() {
  mkdir -p "$PLUGIN_DIR"
}

list_templates() {
  echo "Available templates:"
  echo ""
  for tmpl in "$TEMPLATES_DIR"/*.lua; do
    name="$(basename "$tmpl" .lua)"
    link="$PLUGIN_DIR/$name.lua"
    if [ -L "$link" ]; then
      echo "  [enabled]  $name"
    elif [ -f "$link" ]; then
      echo "  [custom]   $name  (regular file, not a symlink)"
    else
      echo "  [disabled] $name"
    fi
  done
}

enable_template() {
  local name="$1"
  local tmpl="$TEMPLATES_DIR/$name.lua"
  local link="$PLUGIN_DIR/$name.lua"

  if [ ! -f "$tmpl" ]; then
    echo "Error: template '$name' not found at $tmpl"
    return 1
  fi

  ensure_plugin_dir

  if [ -L "$link" ]; then
    echo "'$name' is already enabled."
    return 0
  fi

  if [ -f "$link" ]; then
    echo "Warning: '$link' exists as a regular file (not a symlink). Skipping."
    return 1
  fi

  ln -s "$tmpl" "$link"
  echo "Enabled '$name'"
}

disable_template() {
  local name="$1"
  local link="$PLUGIN_DIR/$name.lua"

  if [ ! -L "$link" ]; then
    if [ -f "$link" ]; then
      echo "Warning: '$link' is a regular file, not a managed symlink. Skipping."
    else
      echo "'$name' is not enabled."
    fi
    return 1
  fi

  rm "$link"
  echo "Disabled '$name'"
}

[ $# -lt 1 ] && usage

case "$1" in
  list)
    list_templates
    ;;
  enable)
    [ $# -lt 2 ] && usage
    shift
    for name in "$@"; do
      enable_template "$name"
    done
    ;;
  disable)
    [ $# -lt 2 ] && usage
    shift
    for name in "$@"; do
      disable_template "$name"
    done
    ;;
  *)
    usage
    ;;
esac
