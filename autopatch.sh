#!/bin/bash

#
# Copyright (C) 2025 rifux ✿ Vladimir Blinkov
#
# SPDX-License-Identifier: MIT
#

set -e
parent="$(pwd)"
temp="${parent}/.autopatch-tempdir"

# Define the PATCHES array
PATCHES=(
    "gerrit:https://review.lineageos.org/c/LineageOS/android_frameworks_av/+/320819"
    "gerrit:https://review.lineageos.org/c/LineageOS/android_frameworks_av/+/320820"
    "github:https://github.com/TTTT555/android_frameworks_av/commit/3f2fd69c97a402f9b22fa95ea80c40dd0a6c4f64"
    "github:https://github.com/TTTT555/android_frameworks_av/commit/d6a8cb27015ac00cf8240d7265ef955ef1101935"
    "github:https://github.com/TTTT555/android_frameworks_av/commit/730ff5d7b2a93fe00233c5ba66300fac22b35f57"
    "gerrit:https://review.lineageos.org/c/LineageOS/android_frameworks_av/+/331490"
)

# Function to apply Gerrit patches
apply_gerrit_patch() {
    local PATCH_URL="$1"
    local GERRIT_URL="https://$(echo "$PATCH_URL" | awk -F '/' '{print $3}')"
    local PROJECT=$(echo "$PATCH_URL" | awk -F '/' '{print $(NF-2)}')
    local CHANGE_ID=$(echo "$PATCH_URL" | awk -F '/' '{print $(NF)}')
    
    # Fetch and cherry-pick the patch
    repopick -g $GERRIT_URL $CHANGE_ID -P "$(repo list | grep $PROJECT | cut -d':' -f1 | cut -d' ' -f1 )" -f || echo -e "it seems that repopick is not found.
is envsetup.sh sourced?

if so, try running '. ./device/redmi/begonia/autopatch.sh'"
}

# Function to apply GitHub patches
apply_github_patch() {
    local PATCH_URL="$1"
    local COMMIT_HASH=$(echo "$PATCH_URL" | awk -F '/' '{print $NF}')
    local REPO_URL=$(echo "$PATCH_URL" | sed 's|/commit/.*||')
    local PROJECT=$(basename "$REPO_URL")

    # Navigate to the project directory, download and apply patch
    cd "$(repo list | grep $PROJECT | cut -d':' -f1 | cut -d' ' -f1 )" && \
        wget ${PATCH_URL}.patch -O current.patch && \
        git am current.patch && \
        rm -v current.patch || echo "[ ! ] patching failed."

    # Go back to the parent dir
    cd "${parent}"
}

# Main loop to process all patches
for patch in "${PATCHES[@]}"; do
    if [[ "$patch" == gerrit:* ]]; then
        apply_gerrit_patch "${patch#gerrit:}"
    elif [[ "$patch" == github:* ]]; then
        apply_github_patch "${patch#github:}"
    else
        echo "Unknown patch source: $patch"
    fi
done