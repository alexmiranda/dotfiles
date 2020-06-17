#!/usr/bin/env bash

ARGS="$@"

(
  set -e
  trap 'cleanup' EXIT

  PLANG=
  TARGET_DIR=
  NO_LICENCE=
  NO_README=
  NO_CONTRIB=
  NO_COC=
  NO_DIRENV=
  NO_NIX_SHELL=
  NO_ADR=
  NO_PR_TMPL=
  VERBOSE=
  DRY_RUN=

  # setup
  tmp_file=$(mktemp)
  exec {FD_W}>"$tmp_file"
  exec {FD_R}<"$tmp_file"

  usage(){
    echo "USAGE: "
    echo "${0##*/} [options]"
    echo
    echo "options"
    echo "-h | --help"
    echo "    display this message."
    echo "-l | --lang <language>"
    echo "    define the project language"
    echo "-o | --output <target>"
    echo "    define the target output folder"
    echo "    where the project will be initialised"
    echo "-n | --dry-run"
    echo "    perform a dry-run operation"
    echo "-v | --verbose"
    echo "    increases the verbosity level (default: no output)"
    echo "--no-readme"
    echo "    no readme file will be copied over to the target folder"
    echo "--no-licence | --no-license"
    echo "    no licence file will be copied over to the target folder"
    echo "--no-contributing"
    echo "    no contributing file will be copied over to the target folder"
    echo "--no-pr-template"
    echo "    no pull request template will be copied over to the "
    echo "    target folder"
    echo "--no-code-of-conduct"
    echo "    no code of conduct will be copied over to the target folder"
    echo "--no-adr"
    echo "    skip ADRs (architecture decision records)"
    echo "--no-nix-shell"
    echo "    skip shell.nix and other relevant nix configuration files"
    echo "--no-direnv"
    echo "    skip envrc file and other relevant direnv configuration files"
    exit "${1:-1}"
  }

  parse(){
    until [ -z "$*" ]; do
      case "$1" in
        -h|--help)
          usage 0
          ;;
        -o|--output)
          [ -n "${TARGET_DIR}" ] && usage
          shift; [ $# -eq 0 ] && usage
          TARGET_DIR="$1"
          if [ ! -d "${TARGET_DIR}" ]; then
            error_out "Target directory not found: $TARGET_DIR"
            usage
          fi
          ;;
        -l|--lang)
          [ -n "${PLANG}" ] && usage
          shift; [ $# -eq 0 ] && usage
          PLANG="$1"
          [ "${PLANG}" == "common" ] && usage
          ;;
        -n|--dry-run)
          [ "${DRY_RUN}" == '-n' ] && usage
          DRY_RUN="-n"
          ;;
        -v*)
          [ -n "$VERBOSE" ] && usage
          if echo "${1#-*}" | grep -vEq ^v\{1,5\}$; then usage 1; fi
          VERBOSE="$1"
          ;;
        --verbose)
          [ -n "$VERBOSE" ] && usage
          VERBOSE="-v"
          ;;
        --no-readme)
          [ "${NO_README}" == "yes" ] && usage
          NO_README="yes"
          exclude README.md
          exclude README
          ;;
        --no-licen[cs]e)
          [ "${NO_LICENCE}" == "yes" ] && usage
          NO_LICENCE="yes"
          exclude LICENCE
          exclude LICENSE
          ;;
        --no-contributing)
          [ "${NO_CONTRIB}" == "yes" ] && usage
          NO_CONTRIB="yes"
          exclude CONTRIBUTING.md
          exclude CONTRIBUTING
          ;;
        --no-code-of-conduct)
          [ "${NO_COC}" == "yes" ] && usage
          exclude CODE_OF_CONDUCT.md
          exclude CODE_OF_CONDUCT
          ;;
        --no-direnv)
          [ "${NO_DIRENV}" == "yes" ] && usage
          NO_DIRENV="yes"
          exclude .envrc
          ;;
        --no-nix-shell)
          [ "${NO_NIX_SHELL}" == "yes" ] && usage
          NO_NIX_SHELL="yes"
          exclude shell.nix
          ;;
        --no-adr)
          [ "${NO_ADR}" == "yes" ] && usage
          NO_ADR="yes"
          exclude docs/adr
          exclude .adr-dir
          ;;
        --no-pr-template)
          [ "${NO_PR_TMPL}" == "yes" ] && usage
          NO_ADR="yes"
          exclude .github/pull_request_template.md
          exclude pull_request_template.md
          exclude docs/pull_request_template.md
          ;;
        *)
          :;
          ;;
      esac
      shift
    done
  }

  exclude() {
    echo "$@" >&${FD_W}
  }

  run(){
    local script_path
    script_path="$(greadlink -f "${0%/*}")"

    local dotfiles
    dotfiles="$(realpath "${script_path}/../..")"

    local templates
    templates="${dotfiles}/project-templates"

    local common
    common="${templates}/common"
    if [ ! -d "${common}" ]; then
      error_out "Invalid source folder: ${common}"
      exit 1
    fi

    local lang_template
    lang_template="${templates}/${PLANG}"
    if [ ! -d "${lang_template}" ]; then
      error_out "Invalid source folder: ${lang_template}"
      usage
    fi

    local target
    target="$(realpath "${TARGET_DIR:-$PWD}")"

    local -a source
    source=("${common}/")

    if test -n "${PLANG}"; then
      source+=("${lang_template}/")
    fi

    verbose_out "Templates: ${templates}"
    verbose_out "Common:    ${common}"
    verbose_out "Language:  ${lang_template}"
    verbose_out

    copy "${source[@]}" "${target}"
    enable_direnv "${target}"
  }

  enable_direnv(){
    [ "${NO_DIRENV}" == 'yes' ] && return 0
    if command -v direnv > /dev/null 2>&1; then
      (cd "$1"; direnv allow)
    fi
  }

  copy(){
    local excludes
    # shellcheck disable=SC2124
    excludes="${@: -1}/.excludes"
    cat <&${FD_R} > "${excludes}"
    rsync -ahu --progress \
      "${DRY_RUN}" "${VERBOSE}" \
      --exclude-from="${excludes}" \
      "$@"
    rm "${excludes}"
  }

  error_out(){
    echo "$@" >&2
  }

  verbose_out(){
    if [ -n "$VERBOSE" ]; then
      echo "$@"
    fi
  }

  cleanup(){
    verbose_out "Removing temporary file: ${tmp_file}"
    rm "${tmp_file}"
  }

  # shellcheck disable=SC2086
  parse $ARGS
  exclude .gitkeep
  run
)
