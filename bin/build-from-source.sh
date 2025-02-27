#!/usr/bin/env bash

OS="$(uname)"

build-sysbench() {
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

  [[ "${OS}" == "Darwin" ]] && export MACOSX_DEPLOYMENT_TARGET=$(sw_vers -productVersion)
  ./autogen.sh --with-psql
  ./configure
  make -j
  src/sysbench --version
}

usage() {
  echo "USAGE: $0 <project>"
  exit 1
}

[[ $# -eq 0 ]] && usage
PROJECT="$1"

eval "build-${PROJECT} ${PROJECT}"
exit $?
