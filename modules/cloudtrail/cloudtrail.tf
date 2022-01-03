resource "aws_cloudtrail" "cloudtrail" {
    name            = var.trail_name
    s3_bucket_name  = aws_s3_bucket.cloudtrail_bucket.id

    is_multi_region_trail           = true
    enable_log_file_validation      = true
    include_global_service_events   = true
    is_organization_trail           = var.is_organizational

    cloud_watch_logs_group_arn  = "${aws_cloudwatch_log_group.cloudtrail_cw_log_group.arn}:*"
    cloud_watch_logs_role_arn   = aws_iam_role.cw_log_iam_role.arn

    kms_key_id = (
        length(aws_kms_key.cloudtrail_key) > 0 ?
        aws_kms_key.cloudtrail_key[0].key_id :
        ""
    )

    depends_on = [ aws_s3_bucket_policy.bucket_policy ]

    event_selector {
        include_management_events   = true
        read_write_type             = "All"
    }
}
