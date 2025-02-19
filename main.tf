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
    user                = var.snowflake_user
    role                = var.snowflake_role
    private_key         = file(var.snowflake_private_key)
    authenticator       = var.snowflake_authenticator
}

locals {
  users = csvdecode(file(var.csv_file))
}

resource "snowflake_account_role" "workshop_role" {
  name = "WORKSHOP_USER"
}

resource "snowflake_warehouse" "workshop_wh" {
  name           = "WORKSHOP_WH"
  warehouse_size = "XSMALL"
  auto_suspend   = 60
  auto_resume    = true
}

resource "snowflake_user" "workshop_users" {
  for_each       = { for user in local.users : user.email => user }
  name          = each.value.email
  login_name    = each.value.email
  display_name  = each.value.name
  password      = each.value.password
  email         = each.value.email
  must_change_password = true
  comment       = "WORKSHOP"
}

resource "snowflake_grant_account_role" "workshop_users_role" {
  for_each   = snowflake_user.workshop_users
  role_name  = snowflake_account_role.workshop_role.name
  user_name  = each.value.name
}
 
output "created_users" {
  value = keys(snowflake_user.workshop_users)
}
