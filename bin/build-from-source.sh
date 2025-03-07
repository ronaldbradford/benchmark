#!/usr/bin/env bash
set -o pipefail
set -o nounset
set -o errexit

### 
### This script helper builds any necessary software from source
###

[[ -n "${TRACE:-}" ]] && set -x
readonly OS="$(uname)"
readonly SRC="src"

error() {
  echo "ERROR: $@"
  exit  1
}

info() {
  echo "INFO:  $@"
  return 0
}

get-repo() {
  local PROJECT="$1"

  cd "${SRC}" || error "Unable to change to '${SRC}' directory"
  if [[ -d "${PROJECT}" ]]; then
    cd ${PROJECT} || error "Unable to change to '${PROJECT}' directory, yet exists"
    info "Updating repo..."   
    git pull
  else 
    info "Cloning repo..."   
    git clone https://github.com/akopytov/${PROJECT}.git
    cd "${PROJECT}" || error "Unable to change to '{PROJECT}' directory"
  fi
  ls
}

if-mac-deployment() {
  [[ "${OS}" == "Darwin" ]] && export MACOSX_DEPLOYMENT_TARGET=$(sw_vers -productVersion)
}

build-sysbench() {
  local PROJECT="$1"

  info "Starting build process for '${PROJECT}'"
  get-repo "${PROJECT}"
  if-mac-deployment

  ./autogen.sh --with-psql
  ./configure
  make -j
  src/sysbench --version
  info "Run 'cd ${PROJECT}; sudo make install' to deploy"

  return 0
}

usage() {
  echo "USAGE: $0 <project>"
  exit 1
}

[[ $# -eq 0 ]] && usage
PROJECT="$1"

if declare -F "build-${PROJECT}" > /dev/null; then
  eval "build-${PROJECT} \"${PROJECT}\""
else
  error "No build function found for project '${PROJECT}'"
fi

exit $?
