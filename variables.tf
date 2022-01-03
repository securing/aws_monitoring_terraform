variable "profile" {
    description = "Profile name"
    type        = string
    default     = "default"
}

variable "region" {
    description = "Default region"
    type        = string
    default     = "eu-west-1"
}

# ============================ AWS Budgets ============================

variable "include_budget" {
    description = "Enable initialization of Budget alerts"
    type        = bool
    default     = false
}

variable "enable_sms" {
    description = "Enable SMS notifications"
    type        = bool
    default     = false
}

variable "enable_email" {
    description = "Enable email notifications"
    type        = bool
    default     = false
}

variable "budget_emails" {
    description = "Emails for Budgets notifications"
    type        = list(string)
    default     = [ "" ]
}

variable "budget_number" {
    description = "Telephone number for Budgets notifictions"
    type        = string
    default     = ""
}

variable "budget_name" {
    description = "Name of the Budget"
    type        = string
    default     = "Cost Budget"
}

variable "budget_amount" {
    description = "Budget amount (limit)"
    type        = string
    default     = "50"
}

# ============================ AWS CloudTrail ============================

variable "include_cloudtrail" {
    description = "Enable initialization of CloudTrail"
    type        = bool
    default     = false
}

variable "is_organizational" {
    description = "Set trail to be an organization trail"
    type        = bool
    default     = false
}

variable "trail_name" {
    description = "Name of CloudTrail trail"
    type        = string
    default     = "management_trail"
}

variable "log_group_name" {
    description = "Name for CloudWatch Log Group to which streams new trail"
    type        = string
    default     = "cloudtrail_logs"
}

variable "encrypt_trail" {
    description = "Enable trail encryption"
    type        = bool
    default     = false
}

variable "cloudtrail_key_alias" {
    description = "Alias for key encrypting CloudTrail logs"
    type        = string
    default     = "alias/cloudtrail_key"
}

# ============================ AWS GuardDuty ============================

variable "include_guardduty" {
    description = "Enable initialization of Guard Duty"
    type        = bool
    default     = false
}

# ============================ AWS Config ============================

variable "include_config" {
    description = "Enable initialization of Config"
    type        = bool
    default     = false
}

