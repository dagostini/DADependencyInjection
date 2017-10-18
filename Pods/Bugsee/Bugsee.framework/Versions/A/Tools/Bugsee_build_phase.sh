#!/bin/sh

# Copyright 2016 Bugsee, Inc. All rights reserved.
#
# Usage:
#   * In the project editor, select your target.
#   * Click "Build Phases" at the top of the project editor.
#   * Click "+" button in the top left corner.
#   * Choose "New Run Script Phase."
#   * Uncomment and paste the following script.
#
# --- INVOCATION SCRIPT BEGIN ---
# SCRIPT_SRC=$(find "$PROJECT_DIR" -name 'BugseeAgent' | head -1)
# if [ ! "${SCRIPT_SRC}" ]; then
#   echo "Error: Bugsee build phase script not found. Make sure that you're including Bugsee.bundle in your project directory"
#   exit 1
# fi
# /usr/bin/python "${SCRIPT_SRC}" <APP_TOKEN>
# --- INVOCATION SCRIPT END ---

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
/usr/bin/python "$DIR/BugseeAgent" "$@"



