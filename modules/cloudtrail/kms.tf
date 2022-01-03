data "aws_caller_identity" "current" {}

resource "aws_kms_key" "cloudtrail_key" {
    count = var.encrypt_trail ? 1 : 0

    description = "Key for encrypting CloudTrail logs"
    policy      = data.aws_iam_policy_document.cloudtrail_key_policy.json
}

resource "aws_kms_alias" "cloudtrail_key_alias" {
    count = var.encrypt_trail ? 1 : 0

    name            = var.cloudtrail_key_alias
    target_key_id   = aws_kms_key.cloudtrail_key[0].key_id
}

data "aws_iam_policy_document" "cloudtrail_key_policy" {
    statement {
        sid = "Enable IAM User Permissions"
        actions = [
            "kms:*"
        ]
        effect = "Allow"
        resources = [ "*" ]
        principals {
            type = "AWS"
            identifiers = [
                "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root",
                "${data.aws_caller_identity.current.arn}"
            ]
        }
    }
    statement {
        sid = "Allow CloudTrail to encrypt logs"
        actions = [
            "kms:GenerateDataKey*"
        ]
        effect = "Allow"
        resources = [ "*" ]
        principals {
            type = "Service"
            identifiers = [ "cloudtrail.amazonaws.com" ]
        }
        condition {
            test = "StringLike"
            variable = "kms:EncryptionContext:aws:cloudtrail:arn"
            values = [ "arn:aws:cloudtrail:*:${data.aws_caller_identity.current.account_id}:trail/*" ]
        }
    }
    statement {
        sid = "Allow CloudTrail to describe key"
        actions = [
            "kms:DescribeKey"
        ]
        effect = "Allow"
        resources = [ "*" ]
        principals {
            type = "Service"
            identifiers = [ "cloudtrail.amazonaws.com" ]
        }
    }
    statement {
        sid = "Allow principals in the account to decrypt log files"
        actions = [
            "kms:Decrypt",
            "kms:ReEncryptFrom"
        ]
        effect = "Allow"
        resources = [ "*" ]
        principals {
            type = "AWS"
            identifiers = [ "*" ]
        }
        condition {
            test = "StringEquals"
            variable = "kmsCallerAccount"
            values = [ "${data.aws_caller_identity.current.account_id}" ]
        }
        condition {
            test = "StringLike"
            variable = "kms:EncryptionContext:aws:cloudtrail:arn"
            values = [ "arn:aws:cloudtrail:*:${data.aws_caller_identity.current.account_id}:trail/*" ]
        }
    }
}