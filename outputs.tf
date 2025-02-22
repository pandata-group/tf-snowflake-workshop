output "created_users" {
  value = keys(snowflake_user.workshop_users)
}

output "csv_file_content" {
  value     = data.aws_s3_object.csv_file.body
  sensitive = true
}