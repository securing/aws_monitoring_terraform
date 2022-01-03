resource "random_string" "random" {
    length  = 12
    lower   = false
    upper   = false
    special = false
    number  = true
} 

resource "aws_s3_bucket" "cloudtrail_bucket" {
    bucket = "cloudtrail-bucket-${random_string.random.result}"

    server_side_encryption_configuration {
        rule {
            apply_server_side_encryption_by_default {
                sse_algorithm = "AES256"
            }
        }
    }
}

resource "aws_s3_bucket_public_access_block" "block_public_access" {
    bucket = aws_s3_bucket.cloudtrail_bucket.id

    block_public_acls       = true
    block_public_policy     = true
    ignore_public_acls      = true
    restrict_public_buckets = true

    depends_on = [ aws_s3_bucket_policy.bucket_policy ]
}

data "aws_iam_policy_document" "bucket_policy_for_cloudtrail_bucket" {
    statement {
        actions = [
            "s3:GetBucketAcl"
        ]
        effect = "Allow"
        resources = [ aws_s3_bucket.cloudtrail_bucket.arn ]
        principals {
            type = "Service"
            identifiers = [ "cloudtrail.amazonaws.com" ]
        }
    }
    statement {
        actions = [
            "s3:PutObject"
        ]
        effect = "Allow"
        resources = [ "${aws_s3_bucket.cloudtrail_bucket.arn}/*" ]
        principals {
            type = "Service"
            identifiers = [ "cloudtrail.amazonaws.com" ]
        }
        condition {
            test = "StringEquals"
            variable = "s3:x-amz-acl"
            values = [ "bucket-owner-full-control" ]
        }
    }
}

resource "aws_s3_bucket_policy" "bucket_policy" {
    bucket = aws_s3_bucket.cloudtrail_bucket.id
    policy = data.aws_iam_policy_document.bucket_policy_for_cloudtrail_bucket.json
}