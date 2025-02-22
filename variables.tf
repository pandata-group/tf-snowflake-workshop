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
  sensitive   = true
}

variable "snowflake_authenticator" {
  description = "Authenticator type"
  type        = string
}

variable "csv_file" {
  description = "CSV file of users"
  type        = string
}


# AWS

variable "aws_access_key" {
  description = "aws access key"
  type        = string
  sensitive   = true
  default     = "secret"
}

variable "aws_secret_key" {
  description = "aws secret key"
  type        = string
  sensitive   = true
  default     = "secret"
}