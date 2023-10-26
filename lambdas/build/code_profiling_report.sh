#!/usr/bin/env bash

SCRIPT_EXIT_CODES=0

. `realpath -m $0/../bash_shared_scripts.sh`

use_virtual_env

cd $LAMBDA_DIRECTORY

pip install pyinstrument==4.5.3

MODULE_ROOT=$LAMBDA_DIRECTORY/applications/GetUserConfig
platform_format_target_python=`cygpath -w $MODULE_ROOT/src/test/python` || platform_format_target_python=`echo $MODULE_ROOT/src/test/python`
pyinstrument -m unittest discover -s $platform_format_target_python
exit $?

