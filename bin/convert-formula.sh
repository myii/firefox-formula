#!/usr/bin/env sh
set -o nounset # Treat unset variables as an error and immediately exit
set -o errexit # If a command fails exit the whole script

if [ "${DEBUG:-false}" = "true" ]; then
  set -x # Run the entire script in debug mode
fi

usage() {
  echo "usage: $(basename "$0") <new-formula-name>" 1>&2
  echo 1>&2
  echo "Convert template-formula to <new-formula-name>-formula." 1>&2
  echo "<new-formula-name> should be a string of lowercase characters only." 1>&2
  echo "<new-formula-name> should not be any of 'bin' 'docs' 'test'." 1>&2
}

args() {
  if [ $# -ne 1 ]; then
    usage
    exit 1
  fi
  NEW_NAME=$1
  if echo "$NEW_NAME" | grep -E --quiet --invert-match '^[a-z]+$'; then
    usage
    exit 1
  fi
  if echo bin docs test | grep --quiet --word-regexp "$NEW_NAME"; then
    usage
    exit 1
  fi
}

convert_formula() {
  git reset \
    "$(echo "feat: initial commit" \
      | git commit-tree "HEAD^{tree}")"
  git rm bin/convert-formula.sh AUTHORS.md CHANGELOG.md
  git mv template__  "${NEW_NAME}"
  grep -rl template__ . --exclude-dir=.git | xargs perl -pi -e s/template__/"${NEW_NAME}"/g
  git commit --quiet --all -m "feat: convert template-formula to ""${NEW_NAME}""-formula

BREAKING CHANGE: changed all state names and ids"
}

args "$@"
convert_formula
