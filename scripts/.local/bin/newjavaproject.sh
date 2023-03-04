#!/usr/bin/env nix-shell
#!nix-shell -I nixpkgs=https://github.com/NixOS/nixpkgs/archive/nixos-22.11.tar.gz -i bash -p niv dialog git maven findutils
# shellcheck shell=bash disable=SC1008
# shellcheck disable=SC2129

NIXPKGS_BRANCH="release-22.05"
MVNVERSION="3.8.6"
DEFAULT_GROUP_ID="net.alexmiranda"
BASEDIR="$PWD"
if [ "$(git rev-parse --is-inside-work-tree)" = "true" ]; then
  BASEDIR="$HOME/Code/github.com/alexmiranda"
fi

set -eou pipefail
TMPFILE="$(mktemp)"
function clean_up {
  rm -f "$TMPFILE"
}

trap clean_up EXIT

dialog \
  --backtitle "New java project" \
  --form "Project settings" 25 60 16 \
  "groupId:" 1 1 "${DEFAULT_GROUP_ID}" 1 16 32 30 \
  "artifactId:" 2 1 "${PWD##/*/}" 2 16 32 30 \
  "version:" 3 1 "0.1.0-dev" 3 16 32 30 \
  2>>"$TMPFILE"

dialog \
  --backtitle "New java project" \
  --radiolist "Java version:" 0 0 0 \
  1 "17" on \
  2 "11" off \
  3 "8" off \
  2>>"$TMPFILE"

echo >> "$TMPFILE"

while IFS= read -r line; do
  if [ -z ${GROUP_ID+x} ]; then
    GROUP_ID="$line"
  elif [ -z ${ARTIFACT_ID+x} ]; then
    ARTIFACT_ID="$line"
  elif [ -z ${VERSION+x} ]; then
    VERSION="$line"
  elif [ -z ${JDKVERSION+x} ]; then
    JDKVERSION=
    case "$line" in
      1)
        JDKVERSION="17"
        ;;
      2)
        JDKVERSION="11"
        ;;
      3)
        JDKVERSION="8"
        ;;
    esac
  else
    break
  fi
done < "$TMPFILE"


if [ "$ARTIFACT_ID" = "${BASEDIR##/*/}" ]; then
  OUTDIR="${BASEDIR}"
else
  OUTDIR="${BASEDIR}/${ARTIFACT_ID}"
fi

OUTDIR="$(dialog --stdout --inputbox "Output directory:" 0 0 "${OUTDIR}")"

mkdir -p "${OUTDIR}" && pushd "${OUTDIR}"
git init

curl -sL https://www.toptal.com/developers/gitignore/api/java,maven,macos,windows,linux,vscode,vim,idea,eclipse,netbeans > .gitignore

mvn archetype:generate \
  -DgroupId="${GROUP_ID}" \
  -DartifactId="${ARTIFACT_ID}" \
  -Dversion="${VERSION}" \
  -DoutputDirectory=. \
  -DarchetypeArtifactId=maven-archetype-quickstart \
  -DarchetypeVersion=1.4 \
  -DinteractiveMode=false

find "${ARTIFACT_ID}/" -mindepth 1 -maxdepth 1 -exec mv -t "${OUTDIR}/" -- {} +
rmdir "${ARTIFACT_ID}"

mvn wrapper:wrapper -Dmaven="${MVNVERSION}"

case "${JDKVERSION}" in
  8)
    JAVA_RELEASE_VERSION="1.8"
    ;;
  *)
    JAVA_RELEASE_VERSION="${JDKVERSION}"
    ;;
esac

mvn versions:set-property -Dproperty=maven.compiler.source -DnewVersion="${JAVA_RELEASE_VERSION}" -DgenerateBackupPoms=false
mvn versions:set-property -Dproperty=maven.compiler.target -DnewVersion="${JAVA_RELEASE_VERSION}" -DgenerateBackupPoms=false

niv init
niv update nixpkgs -b "${NIXPKGS_BRANCH}"

cat > shell.nix <<END
{ sources ? import ./nix/sources.nix { } }:
let pkgs = import sources.nixpkgs { };
in pkgs.mkShell rec {
  buildInputs = with pkgs; [
    jdk${JDKVERSION}_headless
    nixfmt
  ];
}
END

echo "use nix" > .envrc

mkdir .vscode
cat > .vscode/extensions.json <<END
{
  "recommendations": ["vscjava.vscode-java-pack", "bbenoist.Nix"]
}
END

popd

