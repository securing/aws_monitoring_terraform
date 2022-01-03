terraform {
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~> 3.58.0"
        }
        random = {
            source  = "hashicorp/random"
            version = "~> 3.1.0"
        }
    }
    
    required_version = "~>1.0"
}

provider "aws" {
    profile = var.profile
    region  = var.region
}

module "budget" {
    source  = "./modules/budget"
    count   = var.include_budget ? 1 : 0
    
    enable_sms      = var.enable_sms
    enable_email    = var.enable_email

    telephone_number    = var.budget_number
    notification_email  = var.budget_emails

    budget_name     = var.budget_name
    budget_amount   = var.budget_amount
    # I recommend going to ./modules/budget/budget.tf and modifiying notifications for desirable options
}

module "cloudtrail" {
    source  = "./modules/cloudtrail"
    count   = var.include_cloudtrail ? 1 : 0

    trail_name      = var.trail_name
    log_group_name  = var.log_group_name

    encrypt_trail           = var.encrypt_trail
    cloudtrail_key_alias    = var.cloudtrail_key_alias

    is_organizational = var.is_organizational
}

module "guard_duty" {
    source  = "./modules/guardduty"
    count   = var.include_guardduty ? 1 : 0
}

module "config" {
    source  = "./modules/config"
    count   = var.include_config ? 1 : 0
}
