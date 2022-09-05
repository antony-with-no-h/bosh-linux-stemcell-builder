#!/usr/bin/env bash
set -e

base_dir=$(readlink -nf $(dirname $0)/../..)
source $base_dir/lib/prelude_apply.bash

#pkg_mgr install libpcre2-dev libpcre3-dev libexpat1-dev libz-dev

sudo apt-get install --no-install-recommends -y libcurl4-openssl-dev libpcre2-dev libpcre3-dev libexpat1-dev libz-dev

pushd ${base_dir}/gitaly
sudo make git GIT_PREFIX=/usr
popd
