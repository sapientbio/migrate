#!/usr/bin/env bash

set -eu

EXPORT_DIR=exported
SOURCE_PROFILE=source
TARGET_PROFILE=target
SOURCE_TOKEN_FILE=/tmp/source-token
TARGET_TOKEN_FILE=/tmp/target-token

# Check SOURCE config
: "${SOURCE_HOST?Need to set SOURCE_HOST}"
: "${SOURCE_TOKEN?Need to set SOURCE_TOKEN}"

# Check TARGET config
: "${TARGET_HOST?Need to set TARGET_HOST}"
: "${TARGET_TOKEN?Need to set TARGET_TOKEN}"

# Configure Databricks
echo "${SOURCE_TOKEN}" > "${SOURCE_TOKEN_FILE}"
echo "${TARGET_TOKEN}" > "${TARGET_TOKEN_FILE}"
databricks configure --token-file "${SOURCE_TOKEN_FILE}" --profile "${SOURCE_PROFILE}" --host "${SOURCE_HOST}"
databricks configure --token-file "${TARGET_TOKEN_FILE}" --profile "${TARGET_PROFILE}" --host "${TARGET_HOST}"

# Export -> Import
mkdir "${EXPORT_DIR}"
python3 export_db.py --profile "${SOURCE_PROFILE}" --workspace --users --skip-aws-instance-profiles --download --set-export-dir "${EXPORT_DIR}"
python3 import_db.py --profile "${TARGET_PROFILE}" --workspace --users --skip-aws-instance-profiles --set-export-dir "${EXPORT_DIR}" --archive-missing
