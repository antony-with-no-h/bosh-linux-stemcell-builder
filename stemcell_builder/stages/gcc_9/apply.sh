#!/usr/bin/env bash
set -e

base_dir=$(readlink -nf $(dirname $0)/../..)
source $base_dir/lib/prelude_apply.bash

cat > "$chroot/etc/apt/sources.list.d/ubuntu-toolchain-r-ubuntu-test-bionic.list" <<EOS
deb [trusted=yes] http://ppa.launchpad.net/ubuntu-toolchain-r/test/ubuntu bionic main
# deb-src http://ppa.launchpad.net/ubuntu-toolchain-r/test/ubuntu bionic main
EOS

run_in_chroot "$chroot" "apt update"

pkg_mgr install gcc-9 g++-9

for RELINK in gcc gcc-ar gcc-nm gcc-ranlib; do
    run_in_chroot "$chroot" "pushd /usr/bin; ln -sf ${RELINK}-9 ${RELINK}; popd"
done
