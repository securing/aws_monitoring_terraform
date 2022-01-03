variable "telephone_number" {
    description = "Telephone number"
    type        = string
}

variable "notification_email" {
    description = "List of emails (can be single) for notifications from Budget alarm"
    type        = list(string)
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