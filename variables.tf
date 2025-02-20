variable "snowflake_account_name" {
  description = "Your Snowflake account name"
  type        = string
}

variable "snowflake_organization" {
    description = "Your Snowflake organization name"
}

variable "snowflake_private_key" {
  description = "Path to the private key for authentication"
  type        = string
}

variable "snowflake_authenticator" {
    description = "Authenticator type"
    type        = string
}

variable "csv_file" {
    description = "CSV file of users"
    type = string
}