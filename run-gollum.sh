#!/bin/bash

EXPECTED_ARGS=1
E_BADARGS=65

if [ $# -ne $EXPECTED_ARGS ]
then
  echo "Usage: `basename $0` WIKI_ROOT_DIRECTORY"
  exit $E_BADARGS
fi

WIKI_ROOT_DIR=${1}

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
SCRIPT_DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
export BUNDLE_GEMFILE="${SCRIPT_DIR}/"Gemfile
echo $BUNDLE_GEMFILE

bundle exec gollum "${WIKI_ROOT_DIR}"
