resource "aws_budgets_budget" "budget" {
    name            = var.budget_name
    budget_type     = "COST"
    limit_amount    = var.budget_amount
    limit_unit      = "USD"
    time_unit       = "MONTHLY"

    notification {
        notification_type   = "ACTUAL"
        comparison_operator = "GREATER_THAN"
        threshold           = "80"
        threshold_type      = "PERCENTAGE"

        subscriber_email_addresses = var.notification_email
    }

    notification {
        notification_type   = "ACTUAL"
        comparison_operator = "GREATER_THAN"
        threshold           = "95"
        threshold_type      = "PERCENTAGE"

        subscriber_sns_topic_arns = [ aws_sns_topic.budget_topic[0].arn ]
    }
}