#!/usr/bin/env bash
set -ex

base_dir=$(readlink -nf $(dirname $0)/../..)
source $base_dir/lib/prelude_apply.bash

pkg_mgr install libpcre2-dev

pushd ${base_dir}/gitaly
run_in_chroot "$chroot" "make git"
popd
