#!/usr/bin/env bash

TOP_DIR=$(cd $(dirname "$0") && pwd)
if [[ ! -r $TOP_DIR/stackrc ]]; then
    echo "ERROR: missing $TOP_DIR/stackrc - did you grab more than just stack.sh?"
    exit 1
fi

source $TOP_DIR/stackrc

source $TOP_DIR/functions

if [[ -n "$http_proxy" ]]; then
    export http_proxy=$http_proxy
fi
if [[ -n "$https_proxy" ]]; then
    export https_proxy=$https_proxy
fi
if [[ -n "$no_proxy" ]]; then
    export no_proxy=$no_proxy
fi

# Destination path for installation ``DEST``
DEST=${DEST:-/opt/stack}

# Create the destination directory and ensure it is writable by the user
sudo mkdir -p $DEST
if [ ! -w $DEST ]; then
    sudo chown `whoami`:`whoamin` $DEST
fi

KEYSTONECLIENT_DIR=$DEST/python-keystoneclient
SWIFTCLIENT_DIR=$DEST/python-swiftclient
QUANTUM_CLIENT_DIR=$DEST/python-quantumclient
NOVACLIENT_DIR=$DEST/python-novaclient
GLANCECLIENT_DIR=$DEST/python-glanceclient
CINDERCLIENT_DIR=$DEST/python-cinderclient


# Installing the clients
# Keystone
git_clone $KEYSTONECLIENT_REPO $KEYSTONECLIENT_DIR $KEYSTONECLIENT_BRANCH
setup_develop $KEYSTONECLIENT_DIR

# SWIFT
git_clone $SWIFTCLIENT_REPO $SWIFTCLIENT_DIR $SWIFTCLIENT_BRANCH
setup_develop $SWIFTCLIENT_DIR

# Quantum
git_clone $QUANTUM_CLIENT_REPO $QUANTUM_CLIENT_DIR $QUANTUM_CLIENT_BRANCH
setup_develop $QUANTUM_CLIENT_DIR

# Nova
git_clone $NOVACLIENT_REPO $NOVACLIENT_DIR $NOVACLIENT_BRANCH
setup_develop $NOVACLIENT_DIR

# Glance
git_clone $GLANCECLIENT_REPO $GLANCECLIENT_DIR $GLANCECLIENT_BRANCH
setup_develop $GLANCECLIENT_DIR

# Cinder
git_clone $CINDERCLIENT_REPO $CINDERCLIENT_DIR $CINDERCLIENT_BRANCH
setup_develop $CINDERCLIENT_DIR

