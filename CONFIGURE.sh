#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

export PATH="$SCRIPT_DIR/tools:$PATH"

rm -rf /usr/local/bin/mrchromebox
mkdir -p /usr/local/bin/mrchromebox

cp -r "$SCRIPT_DIR"/* /usr/local/bin/mrchromebox

cd /usr/local/bin/mrchromebox

bash scripts/firmware-util.sh