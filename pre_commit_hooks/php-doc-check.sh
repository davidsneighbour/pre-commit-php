#!/usr/bin/env bash

# Bash PHP Doc Check Hook
# This script fails if the PHP Doc Check output has the word "Severity" in it.
#
# Exit 0 if no errors found
# Exit 1 if errors were found
#
# Requires
# - php
#
# Arguments
# - None

# Plugin title
title="PHP Doc Check"

# Possible command names of this tool
local_command="php-doc-check.phar"
vendor_command="vendor/bin/php-doc-check"
global_command="php-doc-check"

# Print a welcome and locate the exec for this tool
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $DIR/helpers/colors.sh
source $DIR/helpers/formatters.sh
source $DIR/helpers/welcome.sh
source $DIR/helpers/locate.sh

phpcs_files_to_check="${@:2}"
phpcs_args=$1
phpcs_command="${exec_command} ${phpcs_args} ${phpcs_files_to_check}"

echo -e "${bldwht}Running command ${txtgrn}$phpcs_command${txtrst}"
command_result=`eval $phpcs_command`
if [[ $command_result =~ Severity ]]
then
    hr
    echo -en "${bldmag}Errors detected by PHP Code Check ... ${txtrst} \n"
    hr
    echo "$command_result"
    exit 1
fi

exit 0
