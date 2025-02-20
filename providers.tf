#SYSADMIN
provider "snowflake" {
    account_name        = var.snowflake_account_name
    organization_name   = var.snowflake_organization
    user                = "SVC_TERRAFORM"
    role                = "SYSADMIN"
    private_key         = var.snowflake_private_key
    authenticator       = var.snowflake_authenticator

    preview_features_enabled = [
        "snowflake_user_authentication_policy_attachment_resource"
    ]
}
# SECURITYADMIN
provider "snowflake" {
    alias = "securityadmin"
    account_name        = var.snowflake_account_name
    organization_name   = var.snowflake_organization
    user                = "SVC_TERRAFORM"
    role                = "SECURITYADMIN"
    private_key         = var.snowflake_private_key
    authenticator       = var.snowflake_authenticator

    preview_features_enabled = [
        "snowflake_user_authentication_policy_attachment_resource"
    ]
}