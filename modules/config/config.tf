resource "aws_config_configuration_recorder" "config_recorder" {
    role_arn = aws_iam_role.config_iam_role.arn

    recording_group {
        all_supported = true
        include_global_resource_types = true
    }
}

resource "aws_config_delivery_channel" "config_delivery" {
    s3_bucket_name = aws_s3_bucket.config_bucket.id

    depends_on = [ aws_config_configuration_recorder.config_recorder ]
}

resource "aws_config_configuration_recorder_status" "config_recorder_status" {
    name        = aws_config_configuration_recorder.config_recorder.name
    is_enabled  = true

    depends_on = [ aws_config_delivery_channel.config_delivery ]
}

resource "aws_iam_role" "config_iam_role" {
    name = "iamRoleForAWSConfig"

    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [{
            Action  = "sts:AssumeRole",
            Effect  = "Allow"
            Sid     = ""
            Principal = {
                Service = "config.amazonaws.com"
            }
        }]
    })
}

resource "aws_iam_role_policy_attachment" "config_iam_role_managed_policy_attachment" {
    role        = aws_iam_role.config_iam_role.name
    policy_arn  = "arn:aws:iam::aws:policy/service-role/AWSConfigRole"
}