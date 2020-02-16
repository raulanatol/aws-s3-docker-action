#!/usr/bin/env bash

set -eu

function error() {
  echo "#----------------------------"
  echo "# ERROR: $1"
  echo "#----------------------------\n"
  exit 1
}

if [ $# != 1 ]; then
  error "Please specify the version number: npm run finish-release 10.0.1"
fi

NEW_VERSION=$1
BRANCH=$(git rev-parse --abbrev-ref HEAD)

function check_branch() {
  if [ ${BRANCH} == 'master' ]; then
    echo "Master branch"
  else
    error "Invalid branch name ${BRANCH}"
  fi
}

function git_pull() {
  git pull origin master
}

function is_duplicated_tag() {
  if git rev-parse v${NEW_VERSION} >/dev/null 2>&1; then
    error "Duplicated tag"
  fi
}

function change_version() {
  git tag v${NEW_VERSION}
}

function uncommitted_changes() {
  if [[ $(git status --porcelain) ]]; then
    error "There are uncommitted changes in the working tree."
  fi
}

function gitPush() {
  git push -u origin master && git push --tags
}

function generate_release_notes() {
  npx gren release --username=raulantol --repo=aws-s3-docker-action
}

git_pull
uncommitted_changes
check_branch
is_duplicated_tag
change_version
gitPush
generate_release_notes
