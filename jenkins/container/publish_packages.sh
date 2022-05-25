#!/bin/bash

# expects arch to be in environment
#
# signing_key and signer may be absent

set -exuo pipefail

source ci-automation/push_pkgs.sh
source jenkins/container/gpg_setup.sh

push_packages "${arch}"
