FULL_PATH_TO_THIS_SCRIPT=`realpath $0`
SCRIPT_DIRECTORY=`dirname $FULL_PATH_TO_THIS_SCRIPT`
LAMBDA_DIRECTORY=`dirname $SCRIPT_DIRECTORY`

SCRIPT_EXIT_CODES=0

echo using virtual env
$venv_command
ls -l $venv_file

build_linux_all_layer_module_zip ( ) {

  BUILD_LAYER_MODULE_ZIP_EXIT_CODES=0

  this_module=$1
  this_version=$2

  this_module_suffix=_all
  platform_format_target=`cygpath -w $LAMBDA_DIRECTORY/layers/_tmp_${this_module}${this_module_suffix}_py${PYTHON_VERSION}_module` || platform_format_target=`echo $LAMBDA_DIRECTORY/layers/_tmp_${this_module}${this_module_suffix}_py${PYTHON_VERSION}_module`

  mkdir -p $LAMBDA_DIRECTORY/layers/_tmp_${this_module}${this_module_suffix}_py${PYTHON_VERSION}_module

  $pip_executable \
  install \
  --platform manylinux2014_x86_64 \
  --implementation cp \
  --only-binary=:all: \
  --upgrade \
  --isolated \
  --target $platform_format_target \
    ${this_module}==${this_version}
  #--python ${PYTHON_VERSION}
  BUILD_LAYER_MODULE_ZIP_EXIT_CODES+=$?

  /usr/bin/find $LAMBDA_DIRECTORY/layers/_tmp_${this_module}${this_module_suffix}_py${PYTHON_VERSION}_module | grep -E "(/__pycache__$|\.pyc$|\.pyo$)" | xargs rm -rf
  BUILD_LAYER_MODULE_ZIP_EXIT_CODES+=$?


  (cd $LAMBDA_DIRECTORY/layers/_tmp_${this_module}${this_module_suffix}_py${PYTHON_VERSION}_module && $zip -r $LAMBDA_DIRECTORY/layers/_tmp_${this_module}${this_module_suffix}_py${PYTHON_VERSION}_layer.zip . )
  BUILD_LAYER_MODULE_ZIP_EXIT_CODES+=$?

  rm -rf $LAMBDA_DIRECTORY/layers/_tmp_${this_module}${this_module_suffix}_py${PYTHON_VERSION}_module

  unzip -l $LAMBDA_DIRECTORY/layers/_tmp_${this_module}${this_module_suffix}_py${PYTHON_VERSION}_layer.zip

  mv $LAMBDA_DIRECTORY/layers/_tmp_${this_module}${this_module_suffix}_py${PYTHON_VERSION}_layer.zip $LAMBDA_DIRECTORY/../artifacts/
  return $BUILD_LAYER_MODULE_ZIP_EXIT_CODES

}

build_linux_all_layer_module_zip "pyinstrument" "4.5.3"
SCRIPT_EXIT_CODES+=$?
exit $SCRIPT_EXIT_CODES