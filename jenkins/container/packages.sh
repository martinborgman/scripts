#!/bin/bash

# expects version, arch, coreos_ref, portage_ref to be in environment

set -exuo pipefail

source ci-automation/packages.sh

packages_build "${version}" "${arch}" "${coreos_ref}" "${portage_ref}"
