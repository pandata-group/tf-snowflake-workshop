output "created_users" {
  value = keys(snowflake_user.workshop_users)
}