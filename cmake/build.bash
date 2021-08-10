#!/bin/bash

# A script to build sysinfo package using cmake
#
# Requirements to build package using cmake:
#
# apt-get install cmake

# Exit on error
set -e

# Define script globals
SCRIPT_PARENT="$(dirname $(readlink -f ${0}))"
SCRIPT_NAME="$(basename ${0})"
SCRIPT_PATH="${SCRIPT_PARENT}/${SCRIPT_NAME}"

# Setup cmake build directory
BUILD_DIR="${SCRIPT_PARENT}/build"

# Build package
pushd "${BUILD_DIR}"
    cmake ../
    make package
popd

# Show package info
PACKAGE=$(find "${BUILD_DIR}" -maxdepth 1 -type f -name "*.deb" -print)

# Check package is created
if [ ! -z "${PACKAGE}" ] && [ -f "${PACKAGE}" ]; then
    PACKAGE_NAME=$(basename ${PACKAGE})

    echo "Package successfully created: '${PACKAGE_NAME}'"
    ls -lh "${BUILD_DIR}"/*.deb
else
    echo "Error: Package was not built"
    exit 1
fi

exit 0
