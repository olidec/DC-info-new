#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────────────────────
# archive.sh — bulk-archive old repositories in a GitHub organization.
#
# Compatible with bash 3.2 (the version macOS ships). No mapfile, no arrays.
#
# Skips template repositories and anything already archived.
# DRY RUN BY DEFAULT: prints what it would do and changes nothing.
#
#   ./archive.sh                      # dry run, default cutoff
#   ./archive.sh --cutoff 2025-01-01  # different cutoff date
#   ./archive.sh --apply              # actually archive
#
# Archiving is reversible:  gh repo unarchive ORG/NAME
# ─────────────────────────────────────────────────────────────────────────────

set -eu

ORG="gymmu-DC-CS"
CUTOFF="2025-08-01"
APPLY=false

while [ $# -gt 0 ]; do
    case "$1" in
        --apply)  APPLY=true; shift ;;
        --cutoff) CUTOFF="$2"; shift 2 ;;
        --org)    ORG="$2"; shift 2 ;;
        *) echo "Unknown option: $1" >&2; exit 1 ;;
    esac
done

CUTOFF_TS="${CUTOFF}T00:00:00Z"

command -v gh >/dev/null 2>&1 || { echo "gh CLI not found." >&2; exit 1; }
command -v python3 >/dev/null 2>&1 || { echo "python3 not found." >&2; exit 1; }
gh auth status >/dev/null 2>&1 || { echo "Not authenticated. Run: gh auth login" >&2; exit 1; }

WORK="$(mktemp -d)"
trap 'rm -rf "$WORK"' EXIT INT TERM

echo "Organization : $ORG"
echo "Cutoff       : last push before $CUTOFF_TS"
if [ "$APPLY" = true ]; then
    echo "Mode         : APPLY — repositories will be archived"
else
    echo "Mode         : DRY RUN — no changes will be made"
fi
echo

# ── Fetch the repository list once ───────────────────────────────────────────
gh repo list "$ORG" --limit 500 \
    --json name,isTemplate,isArchived,pushedAt > "$WORK/repos.json"

TOTAL="$(python3 -c 'import json,sys; print(len(json.load(open(sys.argv[1]))))' "$WORK/repos.json")"
echo "Found $TOTAL repositories in $ORG."

if [ "$TOTAL" -ge 500 ]; then
    echo "WARNING: hit the 500-repo fetch limit. Raise --limit in the script." >&2
fi
echo

# ── Classify: to-archive, and never-pushed ───────────────────────────────────
python3 - "$WORK/repos.json" "$CUTOFF_TS" "$WORK/targets.txt" "$WORK/nopush.txt" <<'PY'
import json, sys

repos_path, cutoff, targets_path, nopush_path = sys.argv[1:5]

with open(repos_path) as fh:
    repos = json.load(fh)

targets, nopush = [], []
for r in repos:
    if r["isTemplate"] or r["isArchived"]:
        continue
    if r["pushedAt"] is None:
        nopush.append(r["name"])
    elif r["pushedAt"] < cutoff:
        targets.append(r["name"])

with open(targets_path, "w") as fh:
    fh.write("".join(n + "\n" for n in sorted(targets)))
with open(nopush_path, "w") as fh:
    fh.write("".join(n + "\n" for n in sorted(nopush)))
PY

N_TARGETS="$(wc -l < "$WORK/targets.txt" | tr -d ' ')"
N_NOPUSH="$(wc -l < "$WORK/nopush.txt" | tr -d ' ')"

if [ "$N_NOPUSH" -gt 0 ]; then
    echo "$N_NOPUSH repositories were never pushed to."
    echo "These are NOT archived — review by hand, they are usually safe to delete:"
    sed 's/^/  /' "$WORK/nopush.txt"
    echo
fi

if [ "$N_TARGETS" -eq 0 ]; then
    echo "No repositories match the cutoff. Nothing to do."
    exit 0
fi

echo "$N_TARGETS repositories to archive:"
sed 's/^/  /' "$WORK/targets.txt"
echo

if [ "$APPLY" != true ]; then
    echo "Dry run complete. Re-run with --apply to archive these."
    exit 0
fi

printf 'Archive these %s repositories? Type yes to confirm: ' "$N_TARGETS"
read -r confirm
if [ "$confirm" != "yes" ]; then
    echo "Aborted. Nothing was changed."
    exit 1
fi
echo

FAILED=0
while IFS= read -r repo; do
    [ -n "$repo" ] || continue
    printf 'archiving %-40s ' "$repo"
    if gh repo archive "$ORG/$repo" --yes >/dev/null 2>&1; then
        echo "ok"
    else
        echo "FAILED"
        FAILED=$((FAILED + 1))
    fi
    sleep 1   # stay under the secondary rate limit
done < "$WORK/targets.txt"

echo
if [ "$FAILED" -gt 0 ]; then
    echo "$FAILED repositories failed. Re-run to retry just those."
fi
echo "Done. To reverse any of these:  gh repo unarchive $ORG/<name>"