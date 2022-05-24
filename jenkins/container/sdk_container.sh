#!/bin/bash

# signing_key and signer may be absent

set -exuo pipefail

source ci-automation/sdk_container.sh
source jenkins/container/gpg_setup.sh

sdk_container_build
