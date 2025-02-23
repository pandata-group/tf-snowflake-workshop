# Snowflake Automation for Workshops with Terraform

This repository provides Terraform scripts to automate the creation of Snowflake users, warehouses, and infrastructure for workshops. The setup leverages the Snowflake Terraform provider to ensure efficient provisioning and management.

## Features
- Automates Snowflake user creation from a CSV file in S3
- Creates and manages Snowflake warehouses and roles
- Uses Terraform for infrastructure-as-code (IaC)
- Secure authentication via private key
- Supports parameterized variables for flexibility

## Project Structure
```
.
├── main.tf                     # Terraform configuration for Snowflake
├── variables.tf                # Terraform variables
├── terraform.tfvars            # User-defined Terraform variables
├── terraform_example.tfvars    # Example of user-defined variables
├── terraform.tfstate           # Terraform state file (generated after apply)
├── terraform.tfstate.backup    # Backup of the Terraform state file
├── README.md                   # Documentation
```

## Prerequisites
Ensure you have the following installed:
- [Terraform](https://developer.hashicorp.com/terraform/downloads)
- A valid Snowflake account with API access
- Private key authentication for Snowflake

## Setup Instructions

### Clone the Repository
```sh
git clone https://github.com/pandata-group/tf-snowflake-workshop.git
cd tf-snowflake-workshop
```

### Configure Variables
Edit `terraform.tfvars` and `variables.tf` to provide your Snowflake details.

### Prepare the Users CSV File
Modify `users.csv` to include users you want to create. The format should be:
```csv
name,email
John Doe,john@example.com
Jane Smith,jane@example.com
```

### Initialize Terraform
```sh
terraform init
```

### Apply the Terraform Configuration
```sh
terraform apply -auto-approve
```

### Verify Users and Warehouses in Snowflake
Run the following SQL queries in Snowflake to verify user and warehouse creation:
```sql
SELECT * FROM SNOWFLAKE.ACCOUNT_USAGE.USERS WHERE LOGIN_NAME LIKE '%example.com%';
SELECT * FROM SNOWFLAKE.ACCOUNT_USAGE.WAREHOUSES;
```

## Modifying the Configuration
- To update users, modify `users.csv` and re-run `terraform apply`.
- To modify warehouses, update `main.tf` and re-run `terraform apply`.
- To destroy created resources, run:
```sh
terraform destroy -auto-approve
```

## Optional Shell Bash Script
Included in this repo is a tf_apply.sh shell script depicting the potential to automate local terraform commands.
It showcases a terraform apply with an auto approve as well as a 'terraform state rm' as an option to protect listed resources from being deleted in the event a 'terraform destroy' command is run.
