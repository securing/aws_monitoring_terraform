resource "random_string" "random" {
    length  = 12
    lower   = false
    upper   = false
    special = false
    number  = true
}

resource "aws_s3_bucket" "config_bucket" {
    bucket = "config-bucket-${random_string.random.result}"

    server_side_encryption_configuration {
        rule {
            apply_server_side_encryption_by_default {
                sse_algorithm = "AES256"
            }
        }
    }
}

resource "aws_s3_bucket_public_access_block" "block_public_access" {
    bucket = aws_s3_bucket.config_bucket.id

    block_public_acls       = true
    block_public_policy     = true
    ignore_public_acls      = true
    restrict_public_buckets = true
    
    depends_on = [ aws_s3_bucket_policy.bucket_policy ]
}

resource "aws_s3_bucket_policy" "bucket_policy" {
    bucket = aws_s3_bucket.config_bucket.id
    policy = data.aws_iam_policy_document.config_bucket_policy.json
}

data "aws_iam_policy_document" "config_bucket_policy" {
    statement {
        actions = [
            "s3:GetBucketAcl",
            "s3:ListBucket"
        ]
        effect = "Allow"
        resources = [ aws_s3_bucket.config_bucket.arn ]
        principals {
          type = "Service"
          identifiers = [ "config.amazonaws.com" ]
        }
    }
    statement {
        actions = [
            "s3:PutObject"
        ]
        effect = "Allow"
        resources = [ "${aws_s3_bucket.config_bucket.arn}/*" ]
        principals {
            type = "Service"
            identifiers = [ "config.amazonaws.com" ]
        }
        condition {
            test = "StringEquals"
            variable = "s3:x-amz-acl"
            values = [ "bucket-owner-full-control" ]
        }
    }
}