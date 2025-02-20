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

resource "snowflake_database" "trever_terraform" {
  name = "TREVER_TERRAFORM"
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

  depends_on = [
    snowflake_user.workshop_users
  ]
}