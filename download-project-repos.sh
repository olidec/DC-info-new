#!/bin/bash
# Clone every repository in the org whose name starts with a prefix into a
# fresh, timestamped directory (a snapshot of the current state).
# Requires: gh CLI, authenticated with read access to the org's repos.
# bash 3.2 compatible (macOS default) — no arrays, no mapfile.

set -e

ORG="gymmu-DC-CS"
PREFIX="cs-project-2627"
TIMESTAMP=$(date +%Y-%m-%d_%H%M)
DEST_DIR="./project-repos_$TIMESTAMP"

mkdir -p "$DEST_DIR"

echo "Finding repos in '$ORG' starting with '$PREFIX'..."

gh repo list "$ORG" --limit 500 --no-archived --json name --jq \
  ".[].name | select(startswith(\"$PREFIX\"))" \
  | while IFS= read -r name; do
      echo "Cloning $name..."
      gh repo clone "$ORG/$name" "$DEST_DIR/$name"
    done

echo "Done. Repos are in $DEST_DIR"