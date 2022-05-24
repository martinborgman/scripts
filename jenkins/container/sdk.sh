#!/bin/bash

# expects seed_version, version, coreos_ref, portage_ref to be in environment

set -exuo pipefail

source ci-automation/sdk_bootstrap.sh

sdk_bootstrap "${seed_version}" "${version}" "${coreos_ref}" "${portage_ref}"
