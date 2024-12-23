#!/bin/bash

# Colors for terminal output
YELLOW=$'\033[0;33m'  # Yellow color for warnings
GREEN=$'\033[0;32m'   # Green color for success messages
RED=$'\033[0;31m'     # Red color for error messages
PURPLE=$'\033[0;35m'  # Purple color for prompts/questions
RESET=$'\033[0m'      # Reset color to default
BLUE=$'\033[0;34m'    # Blue color for info
BLACK=$'\033[0;30m'   # Black color for additional styling
CYAN=$'\033[0;36m'    # Cyan color for highlights
BI_BLUE=$'\033[1;94m' # Bright blue for emphasis

# Error message and user prompt
errorMsg='An error happened.'
question='Do you want to continue with errors?'

# Project directory setup
project_dir="$(git rev-parse --show-toplevel)"
export PATH="$PATH:$project_dir/.fvm/flutter_sdk/bin"

# Team-specific prefix (e.g., JIRA project key)
team_prefix='TEAM'  # Replace TEAM with your team's specific prefix, such as ABC, XYZ, AMT

# Function: Ask user if they want to continue despite errors
# Provides a prompt to continue or abort depending on the environment
askBeforeContinue() {
   errorMsg="$1"
   if [[ "$SHLVL" -eq 1 ]]; then
       clean_message=$(remove_ansi_codes "$errorMsg")
       # Running in VSCode terminal (macOS specific example with AppleScript)
       result=$(osascript -e "tell application \"System Events\" to display dialog \"$clean_message\n$question\" buttons {\"No\", \"Yes\"} default button \"Yes\" with icon caution with title \"Git Hooks\"" button returned of result)

       if [[ $result != 'button returned:Yes' ]]; then
           print_error_message "${RED}Push aborted!! Because of errors${RESET}"
           exit 1
       fi
   else
       # Running in a system terminal
       echo "$errorMsg"
       read -e -p "${PURPLE}pre-commit: ${YELLOW}$question [y/N] ${RESET}" answer < /dev/tty
       case ${answer:0:1} in
           y|Y )
               echo "${PURPLE}pre-commit:${RESET} ${GREEN}Continuing...${RESET}";;
           * )
               echo "${PURPLE}pre-commit:${RESET} ${RED}Aborting push!${RESET}"
               exit 1;;
       esac
   fi
}

# Function: Remove ANSI codes from a string
remove_ansi_codes() {
    local input="$1"
    # ANSI escape codes for colors and formatting
    echo "$input" | sed -E 's/\x1B\[[0-9;]*[mK]//g'
}

# Function to print error message based on SHLVL
print_error_message() {
    errorMsg="$1"
    if [[ "$SHLVL" -eq 1 ]]; then
        clean_message=$(remove_ansi_codes "$errorMsg")
        echo "$clean_message"
    else
        echo "$errorMsg"
    fi
}

# Function: Remove old coverage files
# Deletes the existing `coverage` directory to prepare for a new report
removeCoverage() {
    echo "${RED}##### Removing old coverage files... #####${BLACK}"
    rm -rf coverage
    echo "${GREEN}Old coverage files removed!${RESET}\n"
}

# Function: Edit lcov coverage summary
# Processes the lcov.info file to exclude generated files and updates test coverage badge
editlcovSummary() {
    echo "${BLUE}##### Coverage Info ${BI_BLUE}(with Generated Files)${BLUE} #####${RESET}"
    lcov -summary coverage/lcov.info
    echo "\n"

    echo "${PURPLE}##### Excluding generated files from coverage... #####${BLACK}"
    lcov --remove coverage/lcov.info 'lib/src/network_manager/*' 'lib/*/base_*.dart' 'lib/*/entities/*' -o coverage/lcov.info >/dev/null 2>&1
    echo "${GREEN}Generated files excluded from coverage!${RESET}\n"

    echo "${BLUE}##### Coverage Info ${BI_BLUE}(without Generated Files)${BLUE} #####${RESET}"
    lcov -summary coverage/lcov.info
    echo "\n"

    echo "${YELLOW}##### Generating test coverage badge... #####${BLACK}"
    if [[ -n $1 && $1 -eq "fvm" ]]; then
        fvm flutter pub run test_coverage_badge
    else
        flutter pub run test_coverage_badge
    fi
    echo "${GREEN}Test coverage badge generated.${RESET}"
}

# Function: Format Dart files
# Formats all Dart files in the project to adhere to the specified line length
dartFormat() {
    echo "${YELLOW}##### Formatting Dart files... #####${BLACK}"
    dart format . --line-length 120
    echo "${GREEN}##### Dart files formatted! #####${RESET}\n"
}