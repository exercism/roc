#!/usr/bin/env bash

# Synchronize Roc dependency URLs with a local roc-test-runner checkout.
#
# Usage:
#   bin/sync-roc-dependencies.sh SOURCE
#
# SOURCE is a local path to the runner project root, its dependencies
# directory, or a Roc dependency file. No network access is needed.

set -euo pipefail

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly PROJECT_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

usage() {
    echo "Usage: $(basename "$0") SOURCE" >&2
    echo "SOURCE: local roc-test-runner checkout, dependencies directory, or Roc dependency file" >&2
    exit 2
}

die() {
    echo "Error: $*" >&2
    exit 1
}

if (( $# != 1 )); then
    usage
fi

source_input="$1"
[[ -e "$source_input" ]] || die "Local dependency source not found: $source_input"
echo "Reading dependency declarations from $source_input"
manifest_file="$(mktemp "${TMPDIR:-/tmp}/roc-download-dependencies.XXXXXX")"
url_map_file="$(mktemp "${TMPDIR:-/tmp}/roc-dependency-url-map.XXXXXX")"
trap 'rm -f "${manifest_file}" "${url_map_file}"' EXIT

if [[ -d "$source_input" ]]; then
    source_dir="${source_input%/}"
    [[ ! -d "$source_dir/dependencies" ]] || source_dir="$source_dir/dependencies"
    shopt -s nullglob
    source_files=("$source_dir"/*.roc)
    ((${#source_files[@]} > 0)) || die "No Roc dependency files found in $source_dir"
    for source_file in "${source_files[@]}"; do
        cat "$source_file"
        printf '\n'
    done > "$manifest_file"
else
    [[ -f "$source_input" ]] || die "Dependency declarations not found: $source_input"
    cp "$source_input" "$manifest_file"
fi

# The manifest may gain packages over time. Match packages by their GitHub
# repository so every existing use in the template and exercise sources is
# synchronized without maintaining a second package list here.
{ grep -Eo 'https://github\.com/[^/"[:space:]]+/[^/"[:space:]]+/[^"[:space:]]+\.tar\.zst' "${manifest_file}" || :; } \
    | sort -u \
    | while IFS= read -r dependency_url; do
        dependency_repository="$(printf '%s\n' "${dependency_url}" | sed -E 's#^https://github\.com/([^/]+/[^/]+)/.*#\1#')"
        printf '%s\t%s\n' "${dependency_repository}" "${dependency_url}"
    done > "${url_map_file}"

[[ -s "${url_map_file}" ]] || die "No dependency archive URLs found in ${source_input}"

target_files=()
while IFS= read -r -d '' target_file; do
    target_files+=("${target_file}")
done < <(find "${PROJECT_ROOT}" -path "${PROJECT_ROOT}/.git" -prune -o -type f \( -name '*.roc' -o -name '*.j2' \) -print0)

SYNC_ROC_URL_MAP="${url_map_file}" perl -i -pe '
    BEGIN {
        open my $map_file, "<", $ENV{SYNC_ROC_URL_MAP}
            or die "Cannot read dependency URL map: $!";
        while (<$map_file>) {
            chomp;
            my ($repository, $url) = split /\t/, $_, 2;
            $urls{$repository} = $url;
        }
    }
    s{https://github\.com/([^/]+/[^/]+)/[^"\s]+\.tar\.zst}{
        exists $urls{$1} ? $urls{$1} : $&
    }ge;
' "${target_files[@]}"

echo "Synchronized dependency URLs in ${#target_files[@]} files."
