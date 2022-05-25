#!/bin/bash
#
# Copyright (c) 2021 The Flatcar Maintainers.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

# >>> This file is supposed to be SOURCED from the repository ROOT. <<<
#
# push_packages() should be called w/ the positional INPUT parameters below.

# OS image binary packages publisher automation stub.
#   This script will publish the packages from a pre-built packages container to
#   the buildcache server, effectively turning the build cache into a
#   binary packages server for the SDK.
#
# PREREQUISITES:
#
#   1. SDK version and OS image version are recorded in sdk_container/.repo/manifests/version.txt
#   2. Scripts repo version tag of OS image version to be built is available and checked out.
#   3. Flatcar packages container is available via build cache server
#       from "/containers/[VERSION]/flatcar-packages-[ARCH]-[FLATCAR_VERSION].tar.gz"
#       or present locally. Container must contain binary packages and torcx artifacts.
#
# INPUT:
#
#   1. Architecture (ARCH) of the TARGET OS image ("arm64", "amd64").
#
# OUTPUT:
#
#   1. Binary packages published to buildcache at "boards/[ARCH]-usr/[VERSION]/pkgs".
#   2. "./ci-cleanup.sh" with commands to clean up temporary build resources,
#        to be run after this step finishes / when this step is aborted.

set -eu

# This function is run _inside_ the SDK container
function image_build__copy_to_bincache() {
    local arch="$1"
    local version="$2"

    source ci-automation/ci_automation_common.sh

    cd /build/$arch-usr/var/lib/portage/pkgs/
    sign_artifacts "${SIGNER:-}" *
    copy_to_buildcache "boards/$arch-usr/$version/pkgs" *
}
# --

function push_packages() {
    local arch="$1"

    source ci-automation/ci_automation_common.sh
    init_submodules

    source sdk_container/.repo/manifests/version.txt
    local vernum="${FLATCAR_VERSION}"
    local docker_vernum="$(vernum_to_docker_image_version "${vernum}")"

    local packages="flatcar-packages-${arch}"
    local packages_image="${packages}:${docker_vernum}"

    docker_image_from_buildcache "${packages}" "${docker_vernum}"

    local cmd="source ci-automation/push_pkgs.sh"
    cmd="$cmd; image_build__copy_to_bincache '$arch' '$vernum'"

    local my_name="flatcar-packages-publisher-${arch}-${docker_vernum}"
    ./run_sdk_container -x ./ci-cleanup.sh -n "${my_name}" -C "${packages_image}" \
            bash -c "$cmd"
}
# --
