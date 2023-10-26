#!/usr/bin/env bash

SCRIPT_EXIT_CODES=0

. `realpath -m $0/../bash_shared_scripts.sh`

use_virtual_env

cd $LAMBDA_DIRECTORY

python -m coverage report -m
exit $?

