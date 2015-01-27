#!/bin/bash
error() {
  local parent_lineno="$1"
  local message="$2"
  local code="${3:-1}"
  if [[ -n "$message" ]] ; then
    echo "Error on or near line ${parent_lineno}: ${message}; exiting with status ${code}"
  else
    echo "Error on or near line ${parent_lineno}; exiting with status ${code}"
  fi
  exit 0
}
trap 'error ${LINENO}' ERR

if [ ! -e  /tmp/setup ]; then
    mkdir /tmp/setup
fi

pushd /tmp/setup

echo "pwd = `pwd`"
# print current user for better debug
echo "current user is `whoami`"

# install conda
HOME=/home/cloudera
CONDA_HOME=$HOME/conda
CONDA_BIN=$CONDA_HOME/bin/conda

echo "downloading mini conda installer"
wget http://repo.continuum.io/miniconda/Miniconda-3.6.0-Linux-x86_64.sh

echo "miniconda got, start installing"
bash Miniconda-3.6.0-Linux-x86_64.sh -b -f -p $CONDA_HOME

echo "miniconda installed, start install scikit-learn"
$CONDA_BIN install scikit-learn matplotlib --yes 
echo "scikit-learn, matplotlib installed"

echo 'PS1="\[\033[0;34m\][\u@\h:\w]$\[\033[0m\]"' >> ~/.bashrc
echo 'export PATH="~/conda/bin:$PATH"' >> ~/.bashrc
echo "export PYTHONHOME=$CONDA_HOME" >> ~/.bashrc

echo "clean up"
# some clean up
if [ -e Miniconda-3.6.0-Linux-x86_64.sh ]; then
    rm -f Miniconda-3.6.0-Linux-x86_64.sh
fi

# message
echo "setup succeed!"
popd
