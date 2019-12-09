#!/bin/bash

# exit on failures
set -e
set -o pipefail

# run shellcheck against shell scripts
echo "running shell check in bash directory..."
shellcheck ./*.sh
find ./bash -name "*.sh" -exec shellcheck {} +

echo "Tests successful 👍"
