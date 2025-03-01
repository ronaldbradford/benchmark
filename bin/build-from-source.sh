#!/usr/bin/env bash

OS="$(uname)"


get-repo() {
  local PROJECT="$1"

  cd src
  if [[ -d "${PROJECT}" ]]; then
    cd ${PROJECT}
    git pull
  else 
    git clone https://github.com/akopytov/${PROJECT}.git
    cd ${PROJECT}
  fi
  ls
}

if-mac-deployment() {
  [[ "${OS}" == "Darwin" ]] && export MACOSX_DEPLOYMENT_TARGET=$(sw_vers -productVersion)
}

build-sysbench() {
  local PROJECT="$1"

  get-repo "${PROJECT}"
  if-mac-deployment

  ./autogen.sh --with-psql
  ./configure
  make -j
  src/sysbench --version
  echo "sudo make install"

  return 0
}

usage() {
  echo "USAGE: $0 <project>"
  exit 1
}

[[ $# -eq 0 ]] && usage
PROJECT="$1"

eval "build-${PROJECT} ${PROJECT}"
exit $?
