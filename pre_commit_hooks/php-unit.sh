#!/bin/bash

# Bash PHP Unit Task Runner
#
# Exit 0 if no errors found
# Exit 1 if errors were found
#
# Requires
# - php
#
# Arguments
# - None

# Echo Colors
msg_color_magenta='\e[1;35m'
msg_color_yellow='\e[0;33m'
msg_color_none='\e[0m' # No Color

echo -en "${msg_color_yellow}Begin PHP Unit Task Runner ...${msg_color_none} \n"

local_command="phpunit.phar"
vendor_command="vendor/bin/phpunit"
global_command="phpunit"
bin_command="bin/phpunit"

# Print a welcome and locate the exec for this tool
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $DIR/helpers/colors.sh
source $DIR/helpers/formatters.sh
source $DIR/helpers/welcome.sh
source $DIR/helpers/locate.sh

phpunit_local_exec="phpunit.phar"
phpunit_command="php $phpunit_local_exec"
args=""
for arg_or_file in ${*}
do
    if ! [ -e $arg_or_file ]; then #skip files
        args+=" $arg_or_file"
    fi
done;

echo "Running command $exec_command ${args}"
command_result=`eval "$exec_command ${args}"`
if [[ $command_result =~ FAILURES ]]
then
    echo "Failures detected in unit tests..."
    echo "$command_result"
    exit 1
fi
exit 0
