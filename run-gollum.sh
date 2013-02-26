#!/bin/bash

E_BADARGS=65

if [ $# -lt 1 ]
then
  echo "Usage: `basename $0` <wiki-root-directory> [<git-ref>] [<python-virtualenv-root>]"
  exit $E_BADARGS
fi

WIKI_ROOT_DIR=${1}

# Get the git ref
GIT_REF=develop
if [ $# -eq 2 ]
then
    GIT_REF=${2}
fi

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
SCRIPT_DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
export BUNDLE_GEMFILE="${SCRIPT_DIR}/"Gemfile
#echo $BUNDLE_GEMFILE

# Need to source our python virtual environment
GOLLUM_HOME=~/workspace/pythonenv/GOLLUM
if [ $# -eq 3 ]
then
    GOLLUM_HOME="${3}"
fi
PYTHON_ACTIVATE="${GOLLUM_HOME}/bin/activate"
#echo ${PYTHON_ACTIVATE}
source ${PYTHON_ACTIVATE}

# Start gollum
bundle exec gollum "${WIKI_ROOT_DIR}" --ref=${GIT_REF}
