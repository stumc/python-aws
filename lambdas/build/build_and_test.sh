#!/usr/bin/env bash

SCRIPT_EXIT_CODES=0

. `realpath -m $0/../bash_shared_scripts.sh`

cd $LAMBDA_DIRECTORY/../
pwd

./lambdas/build/package.sh
SCRIPT_EXIT_CODES+=$?
./lambdas/build/unittest.sh
SCRIPT_EXIT_CODES+=$?
./lambdas/build/code_coverage_report.sh
SCRIPT_EXIT_CODES+=$?
./lambdas/build/code_profiling_report.sh
SCRIPT_EXIT_CODES+=$?
pylint --exit-zero --recursive yes ./lambdas/applications/* ./lambdas/layers/*
SCRIPT_EXIT_CODES+=$?

echo SCRIPT_EXIT_CODES $SCRIPT_EXIT_CODES
exit $?

