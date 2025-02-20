#!/bin/bash
terraform apply -auto-approve

# Automatically remove specific resources from the Terraform state
terraform state rm snowflake_database.trever_terraform