#!/bin/bash

# expects arch to be in environment

set -exuo pipefail

source ci-automation/image.sh

image_build "${arch}"
