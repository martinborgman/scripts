#!/bin/bash

# expects version, arch, coreos_ref, portage_ref to be in environment
#
# signing_key and signer may be absent

set -exuo pipefail

source ci-automation/packages.sh
source jenkins/container/gpg_setup.sh

packages_build "${version}" "${arch}" "${coreos_ref}" "${portage_ref}"
