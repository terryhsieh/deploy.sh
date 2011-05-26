#!/usr/bin/env bash
set -o errexit

curl -O https://github.com/cloudbuilders/deploy.sh/raw/master/nova.sh
chmod 755 nova.sh

export USE_GIT=1
export ENABLE_VOLUMES=0
export ENABLE_DASH=1
export ENABLE_GLANCE=1
export ENABLE_KEYSTONE=1
export NET_MAN=FlatDHCPManager

./nova.sh branch
./nova.sh install

# HACK: cloud servers requires older libvirt
apt-get install -y --force-yes libvirt0=0.8.3-1ubuntu14.1 libvirt-bin=0.8.3-1ubuntu14.1 python-libvirt=0.8.3-1ubuntu14.1

./nova.sh run_detached
