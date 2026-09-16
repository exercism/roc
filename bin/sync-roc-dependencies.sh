#!/usr/bin/env bash

# Synchronize Roc dependency URLs with exercism/roc-test-runner.
#
# Usage:
#   bin/sync-roc-dependencies.sh [SOURCE]
#
# SOURCE may be a URL or a local path. In either case it may name the
# download-dependencies.roc file itself or the project root that contains it.

set -euo pipefail

readonly DEFAULT_SOURCE="https://github.com/exercism/roc-test-runner/blob/main/bin/download-dependencies.roc"
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly PROJECT_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

usage() {
    echo "Usage: $(basename "$0") [SOURCE]" >&2
    exit 2
}

die() {
    echo "Error: $*" >&2
    exit 1
}

download() {
    local url="$1"

    if command -v curl >/dev/null 2>&1; then
        curl --fail --location --silent --show-error "$url"
    elif command -v wget >/dev/null 2>&1; then
        wget -qO- "$url"
    else
        die "curl or wget is required to download ${url}"
    fi
}

github_url_to_download_url() {
    local url="$1"
    local github_path owner repository rest ref file_path

    github_path="${url#https://github.com/}"
    github_path="${github_path%%\?*}"
    github_path="${github_path%%\#*}"
    IFS=/ read -r owner repository rest ref file_path <<< "${github_path}"

    [[ -n "${owner}" && -n "${repository}" ]] || die "Invalid GitHub URL: ${url}"

    case "${rest}" in
        "")
            # HEAD follows the repository's default branch.
            printf 'https://github.com/%s/%s/raw/HEAD/bin/download-dependencies.roc\n' "${owner}" "${repository}"
            ;;
        blob)
            [[ -n "${ref}" && -n "${file_path}" ]] || die "Expected a file URL: ${url}"
            printf 'https://raw.githubusercontent.com/%s/%s/%s/%s\n' "${owner}" "${repository}" "${ref}" "${file_path}"
            ;;
        tree)
            [[ -n "${ref}" ]] || die "Expected a branch in URL: ${url}"
            printf 'https://raw.githubusercontent.com/%s/%s/%s/bin/download-dependencies.roc\n' "${owner}" "${repository}" "${ref}"
            ;;
        *)
            die "Expected a GitHub project root or download-dependencies.roc file: ${url}"
            ;;
    esac
}

if (( $# > 1 )); then
    usage
fi

source_input="${1:-${DEFAULT_SOURCE}}"
manifest_file="$(mktemp "${TMPDIR:-/tmp}/roc-download-dependencies.XXXXXX")"
url_map_file="$(mktemp "${TMPDIR:-/tmp}/roc-dependency-url-map.XXXXXX")"
trap 'rm -f "${manifest_file}" "${url_map_file}"' EXIT

if [[ "${source_input}" == http://* || "${source_input}" == https://* ]]; then
    if [[ "${source_input}" == https://github.com/* ]]; then
        source_url="$(github_url_to_download_url "${source_input}")"
    elif [[ "${source_input}" == */download-dependencies.roc ]]; then
        source_url="${source_input}"
    else
        source_url="${source_input%/}/bin/download-dependencies.roc"
    fi

    echo "Downloading dependency URLs from ${source_url}"
    download "${source_url}" > "${manifest_file}"
else
    if [[ -d "${source_input}" ]]; then
        source_file="${source_input%/}/bin/download-dependencies.roc"
    else
        source_file="${source_input}"
    fi

    [[ -f "${source_file}" ]] || die "Dependency manifest not found: ${source_file}"
    echo "Reading dependency URLs from ${source_file}"
    cp "${source_file}" "${manifest_file}"
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

target_files=("${PROJECT_ROOT}/config/generator_macros.j2")
while IFS= read -r -d '' target_file; do
    target_files+=("${target_file}")
done < <(find "${PROJECT_ROOT}" -path "${PROJECT_ROOT}/.git" -prune -o -type f -name '*.roc' -print0)

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
