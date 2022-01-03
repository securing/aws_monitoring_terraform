resource "aws_sns_topic" "budget_topic" {
    count = var.enable_sms ? 1 : 0

    name            = "BudgetNotification"
    display_name    = "AWSBudget"
}

resource "aws_sns_topic_policy" "budgets_publishing_permission_policy" {
    count = var.enable_sms ? 1 : 0
    
    arn     = aws_sns_topic.budget_topic[0].arn
    policy  = jsonencode({
        Version = "2012-10-17"
        Statement = [{
            Sid     = "AWSBudgetsSNSPublishingPermissions"
            Action  = "SNS:Publish"
            Effect  = "Allow"
            Principal = {
                Service = "budgets.amazonaws.com"
            }
            Resource = "${aws_sns_topic.budget_topic[0].arn}"
        }]
    })
}

resource "aws_sns_topic_subscription" "budget_sms_notification" {
    count = var.enable_sms ? 1 : 0

    topic_arn   = aws_sns_topic.budget_topic[0].arn
    protocol    = "sms"
    endpoint    = var.telephone_number
}