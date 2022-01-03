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