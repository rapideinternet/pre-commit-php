#!/bin/bash

# Bash PHP Codesniffer Hook
# This script fails if the PHP Codesniffer output has the word "ERROR" in it.
# Does not support failing on WARNING AND ERROR at the same time.
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
msg_color_magenta='\033[1;35m'
msg_color_yellow='\033[0;33m'
msg_color_none='\033[0m' # No Color

# Loop through the list of paths to run php codesniffer against
echo -en "${msg_color_yellow}Begin PHP Codesniffer ...${msg_color_none} \n"

# Possible command names of this tool
local_command="phpcs.phar"
vendor_command="vendor/bin/phpcs"
global_command="phpcs"
bin_command="bin/phpcs"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $DIR/helpers/locate.sh

phpcs_files_to_check="${@:2}"
phpcs_args=$1
phpcs_command="$exec_command $phpcs_args $phpcs_files_to_check"

echo "Running command $phpcs_command"
command_result=`eval $phpcs_command`
if [[ $command_result =~ ERROR ]]
then
    echo -en "${msg_color_magenta}Errors detected by PHP CodeSniffer ... ${msg_color_none} \n"
    echo "$command_result"
    exit 1
fi

exit 0
