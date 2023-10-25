export PYTHON_VERSION=3.11
export PYTHON_VERSION_EXE_SUFFIX=3.11
export zip=zip
export unzip=unzip
export find=/usr/bin/find

export python_executable="python$PYTHON_VERSION_EXE_SUFFIX"
export pip_executable="pip$PYTHON_VERSION_EXE_SUFFIX"

export FULL_PATH_TO_THIS_SCRIPT=`realpath $0`
echo FULL_PATH_TO_THIS_SCRIPT $FULL_PATH_TO_THIS_SCRIPT
export SCRIPT_DIRECTORY=`dirname $FULL_PATH_TO_THIS_SCRIPT`
echo SCRIPT_DIRECTORY $SCRIPT_DIRECTORY
export LAMBDA_DIRECTORY=`dirname $SCRIPT_DIRECTORY`
echo LAMBDA_DIRECTORY $LAMBDA_DIRECTORY
export PYTHONPYCACHEPREFIX="$LAMBDA_DIRECTORY/.py_cache"

echo creating virtual env...
$python_executable -m venv $LAMBDA_DIRECTORY/.venv
SCRIPT_EXIT_CODES+=$?

echo configuring use of virtual env
if [[ "$OSTYPE" == "cygwin" ]]; then
    export venv_file="$LAMBDA_DIRECTORY/.venv/Scripts/activate"
    export vnv_command="source $LAMBDA_DIRECTORY/.venv/Scripts/activate"
  else
    export venv_file="$LAMBDA_DIRECTORY/.venv/bin/activate"
    export venv_command="source $LAMBDA_DIRECTORY/.venv/bin/activate"
fi

use_virtual_env () {
  echo using virtual env
  $venv_command
  ls -l $venv_file
}
