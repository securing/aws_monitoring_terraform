resource "aws_iam_role" "cw_log_iam_role" {
    name = "CloudTrailRoleForCloudWatchLogs"

    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [{
            Action  = "sts:AssumeRole",
            Effect  = "Allow",
            Sid     = ""
            Principal = {
                Service = "cloudtrail.amazonaws.com"
            }
        }]
    })
}

resource "aws_iam_role_policy" "cw_log_iam_role_policy" {
    name = "allow-access-to-cw-logs"
    role = aws_iam_role.cw_log_iam_role.id
    policy = jsonencode({
        Version = "2012-10-17"
        Statement = [{
            Effect = "Allow"
            Action = [
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ]
            Resource = "${aws_cloudwatch_log_group.cloudtrail_cw_log_group.arn}:*"
        }]
    })
}

resource "aws_cloudwatch_log_group" "cloudtrail_cw_log_group" {
    name = var.log_group_name
    retention_in_days = 0
}