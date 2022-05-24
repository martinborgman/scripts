#!/bin/bash

# expects arch and formats to be in environment
#
# signing_key and signer may be absent

set -exuo pipefail

source ci-automation/vms.sh
source jenkins/container/gpg_setup.sh

set -o noglob
formats_array=( ${formats} )
set +o noglob

vm_build "${arch}" "${formats_array[@]}"
