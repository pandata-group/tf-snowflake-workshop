terraform {
  required_providers {
    snowflake = {
      source  = "Snowflake-Labs/snowflake"
      version = "1.0.3"
    }

    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  cloud {
    organization = "pandatagroup"           # Replace with your Terraform Cloud org
    workspaces {
      name = "tf-snowflake-workshop"        # Replace with your Terraform Cloud workspace name
    }
  }
}

# Snowflake
provider "snowflake" {
  account_name      = var.snowflake_account_name
  organization_name = var.snowflake_organization
  user              = "SVC_TERRAFORM"
  role              = "SYSADMIN"
  private_key       = var.snowflake_private_key
  authenticator     = var.snowflake_authenticator

  preview_features_enabled = [
    "snowflake_user_authentication_policy_attachment_resource"
  ]
}

provider "snowflake" {
  alias             = "securityadmin"
  account_name      = var.snowflake_account_name
  organization_name = var.snowflake_organization
  user              = "SVC_TERRAFORM"
  role              = "SECURITYADMIN"
  private_key       = var.snowflake_private_key
  authenticator     = var.snowflake_authenticator

  preview_features_enabled = [
    "snowflake_user_authentication_policy_attachment_resource"
  ]
}


# AWS
provider "aws" {
  region     = "us-east-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}