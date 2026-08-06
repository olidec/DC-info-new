#!/usr/bin/env bash
#
# build.sh — compile Typst sources into pdf/
#
#   ./build.sh                    Compile every .typ file in source/
#   ./build.sh FILE               Compile a single file
#   ./build.sh --watch FILE       Watch a single file, recompile on save
#   ./build.sh --help             Show this message
#
# All modes pass --root so that `#import "../cs-style.typ"` resolves
# correctly from inside source/.

# Resolve the project root as the directory containing this script,
# so the script works no matter where it is called from.
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$ROOT" || exit 1

OUT_DIR="pdf"
SRC_DIR="source"

usage() {
    sed -n '3,10p' "${BASH_SOURCE[0]}" | sed 's/^# \{0,1\}//'
}

# Compile one file. Returns non-zero on failure but does not exit.
compile_one() {
    local src="$1"
    local name
    name="$(basename "${src%.typ}")"

    if [ ! -f "$src" ]; then
        echo "  ✗ $src — file not found"
        return 1
    fi

    printf '  %-32s' "$name"
    if typst compile --root "$ROOT" "$src" "$OUT_DIR/$name.pdf" 2>/tmp/typst-err.$$; then
        echo "✓"
        rm -f /tmp/typst-err.$$
        return 0
    else
        echo "✗"
        sed 's/^/      /' /tmp/typst-err.$$
        rm -f /tmp/typst-err.$$
        return 1
    fi
}

watch_one() {
    local src="$1"
    local name
    name="$(basename "${src%.typ}")"

    if [ ! -f "$src" ]; then
        echo "Error: $src not found."
        exit 1
    fi

    echo "Watching $name → $OUT_DIR/$name.pdf"
    echo "Press Ctrl+C to stop."
    echo
    typst watch --root "$ROOT" "$src" "$OUT_DIR/$name.pdf"
}

build_all() {
    shopt -s nullglob
    local files=("$SRC_DIR"/*.typ)
    shopt -u nullglob

    if [ ${#files[@]} -eq 0 ]; then
        echo "No .typ files found in $SRC_DIR/"
        exit 1
    fi

    echo "Building ${#files[@]} file(s) into $OUT_DIR/"
    echo

    local failed=0
    for f in "${files[@]}"; do
        compile_one "$f" || failed=$((failed + 1))
    done

    echo
    if [ "$failed" -eq 0 ]; then
        echo "All files compiled successfully."
    else
        echo "$failed file(s) failed to compile."
        exit 1
    fi
}

# ── Entry point ──────────────────────────────────────────────────────────────

mkdir -p "$OUT_DIR"

case "${1:-}" in
    -h|--help)
        usage
        ;;
    -w|--watch)
        if [ -z "${2:-}" ]; then
            echo "Error: --watch requires a file argument."
            echo
            usage
            exit 1
        fi
        watch_one "$2"
        ;;
    "")
        build_all
        ;;
    *)
        echo "Building single file into $OUT_DIR/"
        echo
        compile_one "$1" || exit 1
        ;;
esac
