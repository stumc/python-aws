#!/usr/bin/env bash

SCRIPT_EXIT_CODES=0

. `realpath -m $0/../bash_shared_scripts.sh`

use_virtual_env

( cd $SCRIPT_DIRECTORY/ ; $pip_executable install -r requirements$PYTHON_VERSION.txt )
exit $?

