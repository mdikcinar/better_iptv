#!/bin/bash

source ./common.sh

CUSTOM_HOOKS_PATH="$project_dir/bin/git_hooks"

echo "${PURPLE}hooks.sh: ${YELLOW}Hooks are enabling...${RESET}";
git config core.hooksPath "$CUSTOM_HOOKS_PATH"
chmod -R +x "$CUSTOM_HOOKS_PATH"
echo "${PURPLE}hooks.sh: ${GREEN}Hooks are enabled.${RESET}";