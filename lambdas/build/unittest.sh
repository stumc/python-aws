#!/usr/bin/env bash
SCRIPT_EXIT_CODES=0

. `realpath -m $0/../bash_shared_scripts.sh`

use_virtual_env

# unittest specific
export COVERAGE_ARGS="-m coverage run"

cd $LAMBDA_DIRECTORY
echo LAMBDA_DIRECTORY $LAMBDA_DIRECTORY

run_tests_with_coverage () {
  export MODULE_ROOT=$1
  echo Running unit tests for $MODULE_ROOT
  platform_format_target_python=`cygpath -w $MODULE_ROOT/src/test/python` || platform_format_target_python=`echo $MODULE_ROOT/src/test/python`
  platform_format_target_coverage_xml=`cygpath -w $MODULE_ROOT/coverage.xml` || platform_format_target_coverage_xml=`echo $MODULE_ROOT/coverage.xml`

  python$PYTHON_VERSION_EXE_SUFFIX $COVERAGE_ARGS -m unittest discover -s $platform_format_target_python
  TEST_EXIT_CODES=$?
  echo Examining unit tests coverage for $platform_format_target_module
  python$PYTHON_VERSION_EXE_SUFFIX -m coverage xml -o $platform_format_target_coverage_xml
  return $TEST_EXIT_CODES
}

run_tests_with_coverage $LAMBDA_DIRECTORY/layers/stumc_core_library_module
SCRIPT_EXIT_CODES+=$?
run_tests_with_coverage $LAMBDA_DIRECTORY/applications/GetUserConfig
SCRIPT_EXIT_CODES+=$?

echo Unittest exit code is $SCRIPT_EXIT_CODES
failure_code=`echo $SCRIPT_EXIT_CODES | grep -E "(1|2|3|4|5|6|7|8|9)"`
if [ "$failure_code" != "" ]; then
  echo Detected failure code: $failure_code
  exit 1
fi
exit $SCRIPT_EXIT_CODES