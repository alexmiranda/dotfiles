#!/usr/bin/env nix-shell
#!nix-shell -i bash -p gnugrep gnused coreutils
# shellcheck shell=bash disable=SC1008

set -eo pipefail

function usage {
  echo "Usage: $(basename "$0") -i path/to/file.m3u -o path/to/result.m3u"
}

if test "$#" -eq 0; then
  usage
  exit 1
fi

if test "$1" = '-h' || test "$1" = '--help'; then
  usage
  exit 1
fi

while test "$#" -ne 0; do
  case "$1" in
    -h|--help)
      usage;
      exit 1;
      ;;
    -i)
      input="$2";
      shift 2;
      ;;
    -o)
      output="$2";
      shift 2;
      ;;
    *)
      echo "Unknown option: $1";
      usage;
      exit 1;
      ;;
  esac
done

if [ -z "${input+x}" ] || [ -z "${output+x}" ]; then
  usage
  exit 1
fi

set -u

function clean_up {
  rm -f "$tmpfile"
}

trap clean_up EXIT
tmpfile=$(mktemp)
exec 3>"$tmpfile"

echo "# Delete or comment out ONLY the groups that you'd like to KEEP!" >&3
grep -oP "(?<=\bgroup-title=\")[^\"]*" "$input" | sort -su >&3
exec 3>&-

sed -i 's/^BRASIL\b/# \0/g' "$tmpfile"
sed -i 's/^PORTUGAL\b/# \0/g' "$tmpfile"
sed -i 's/^UK\b/# \0/g' "$tmpfile"
sed -i 's/^CANADA\b/# \0/g' "$tmpfile"
sed -i 's/^USA\b/# \0/g' "$tmpfile"
sed -i 's/^NETHERLANDS\b/# \0/g' "$tmpfile"
sed -i 's/^BELGIUM\b/# \0/g' "$tmpfile"
sed -i 's/^ESPANA\b/# \0/g' "$tmpfile"

sed -i 's/^|EN|/# \0/g' "$tmpfile"
sed -i 's/^|NL|/# \0/g' "$tmpfile"
sed -i 's/^LAT| ARGENTINA\b/# \0/g' "$tmpfile"

declare -f "${EDITOR%% *}" && command -v sandbox && sandbox "${EDITOR%% *}"
$EDITOR "$tmpfile"

# Don't care about empty groups anyway...
cp "$input" "$output"
sed -i '/group-title=""/,+1 d' "$output"

exec 4<"$tmpfile"
grep -v '^#' <&4 | while read -r group; do
  group="$(printf '%s\n' "$group" | sed 's:[][\\/.^$*]:\\&:g')"
  sed -i "/group-title=\"${group}\"/,+1 d" "$output"
done

sed -e '/^#/,/,\.+$/p' "$output"

