#!/bin/bash

SCRIPT_EXIT_CODES=0
. `realpath -m $0/../bash_shared_scripts.sh`

use_virtual_env

$SCRIPT_DIRECTORY/dependencies.sh
SCRIPT_EXIT_CODES+=$?

$SCRIPT_DIRECTORY/download_python_binary_packages.sh
SCRIPT_EXIT_CODES+=$?

echo Packaging GetUserConfig
( cd $LAMBDA_DIRECTORY/applications/GetUserConfig/src/main/python && $zip -r $LAMBDA_DIRECTORY/../artifacts/GetUserConfig.zip .)
( cd $LAMBDA_DIRECTORY/layers/stumc_core_library_module/src/main/python && $zip -r $LAMBDA_DIRECTORY/../artifacts/GetUserConfig.zip .)

echo Showing GetUserConfig.zip
$unzip -l $LAMBDA_DIRECTORY/../artifacts/GetUserConfig.zip
SCRIPT_EXIT_CODES+=$?

echo Packaging exit code is $SCRIPT_EXIT_CODES
failure_code=`echo $SCRIPT_EXIT_CODES | grep -E "(1|2|3|4|5|6|7|8|9)"`
if [ "$failure_code" != "" ]; then
  echo Detected failure code: $failure_code
  exit 1
fi
exit $SCRIPT_EXIT_CODES