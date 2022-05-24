#!/bin/bash

# expects arch and formats to be in environment

set -exuo pipefail

source ci-automation/vms.sh

set -o noglob
formats_array=( ${formats} )
set +o noglob

vm_build "${arch}" "${formats_array[@]}"
