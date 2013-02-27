#!/bin/bash

if [[ $# -eq 1 && ${1} = "-h" ]]
then
    echo "Usage: `basename $0` [<wiki-root-directory>] [<git-ref>] [<python-virtualenv-root>]"
    exit 1
fi

WIKI_ROOT_DIR=~/workspace/repos/cedexis/radarsdk.wiki/
if [ $# -gt 0 ]
then
    WIKI_ROOT_DIR=${1}
fi

# Get the git ref
GIT_REF=develop
if [ $# -gt 1 ]
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
if [ $# -gt 2 ]
then
    GOLLUM_HOME="${3}"
fi
PYTHON_ACTIVATE="${GOLLUM_HOME}/bin/activate"
#echo ${PYTHON_ACTIVATE}
source ${PYTHON_ACTIVATE}

# Start gollum
bundle exec gollum "${WIKI_ROOT_DIR}" --ref=${GIT_REF} --css
