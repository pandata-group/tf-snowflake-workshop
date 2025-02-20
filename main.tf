terraform {
  required_providers {
    snowflake = {
      source  = "Snowflake-Labs/snowflake"
      version = "1.0.3"
    }
  }
}

provider "snowflake" {
    account_name        = var.snowflake_account_name
    organization_name   = var.snowflake_organization
    user                = "SVC_TERRAFORM"
    role                = "SYSADMIN"
    private_key         = file(var.snowflake_private_key)
    authenticator       = var.snowflake_authenticator

    preview_features_enabled = [
        "snowflake_user_authentication_policy_attachment_resource"
    ]
}

provider "snowflake" {
    alias = "securityadmin"
    account_name        = var.snowflake_account_name
    organization_name   = var.snowflake_organization
    user                = "SVC_TERRAFORM"
    role                = "SECURITYADMIN"
    private_key         = file(var.snowflake_private_key)
    authenticator       = var.snowflake_authenticator

    preview_features_enabled = [
        "snowflake_user_authentication_policy_attachment_resource"
    ]
}

locals {
  users = {
    for user in csvdecode(file(var.csv_file)) :
    user.email => {
      email            = user.email
      password         = lower("${replace(user.name, " ", "")}${substr(user.email, 0, 3)}!2025")
      name             = user.name
      transformed_name = upper("${substr(split(" ", user.name)[0], 0, 1)}${split(" ", user.name)[1]}") # Pass = removes space from name, add first 3 letters from email, appens !2025
    }
  }
}

resource "snowflake_account_role" "workshop_role" {
  provider = snowflake.securityadmin
  name = "WORKSHOP_USER"
}

resource "snowflake_warehouse" "workshop_wh" {
  name           = "TF_WORKSHOP_WH"
  warehouse_size = "XSMALL"
  auto_suspend   = 60
  auto_resume    = true
}

resource "snowflake_user" "workshop_users" {
  provider = snowflake.securityadmin
  for_each = local.users

  name          = each.value.transformed_name
  login_name    = each.value.email
  display_name  = each.value.name
  password      = each.value.password
  email         = each.value.email
  must_change_password = true
  comment       = "WORKSHOP"
}

resource "snowflake_grant_account_role" "workshop_users_role" {
  for_each = local.users
  role_name = snowflake_account_role.workshop_role.name
  user_name = each.value.transformed_name
}

output "created_users" {
  value = keys(snowflake_user.workshop_users)
}
