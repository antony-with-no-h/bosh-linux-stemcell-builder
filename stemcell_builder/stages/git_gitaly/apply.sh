#!/usr/bin/env bash
set -ex

base_dir=$(readlink -nf $(dirname $0)/../..)
source $base_dir/lib/prelude_apply.bash

pkg_mgr install libpcre2-dev

run_in_chroot "$chroot" "pushd ${base_dir}/gitaly; make git; popd"
