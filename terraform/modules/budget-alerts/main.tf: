# ══════════════════════════════════════════════════════════
# WHAT:      Creates AWS Billing Alarms.
# WHY:       If we make a mistake and provision a paid resource, this emails us before the bill destroys our $50 constraint.
# BUSINESS:  Unchecked cloud spend kills startups. Companies like Snap and Lyft saved millions by enforcing FinOps at the engineering level.
# ENGINEER:  DevOps is not just about uptime; it is about cost-efficiency. Building this proves you treat company money with respect.
# RECRUITER: "FinOps" is a massive buzzword right now. Having a dedicated budget module makes your portfolio stand out instantly.
# ══════════════════════════════════════════════════════════

resource "aws_budgets_budget" "finops_alerts" {
  name              = "fintrack-monthly-budget-${var.environment}"
  budget_type       = "COST"
  limit_amount      = "20.0"
  limit_unit        = "USD"
  time_unit         = "MONTHLY"
  time_period_start = "2026-06-01_00:00"

  # Alert 1: Actual spend hits $5
  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = 5
    threshold_type             = "ABSOLUTE_VALUE"
    notification_type          = "ACTUAL"
    subscriber_email_addresses = [var.alert_email]
  }

  # Alert 2: Actual spend hits $10
  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = 10
    threshold_type             = "ABSOLUTE_VALUE"
    notification_type          = "ACTUAL"
    subscriber_email_addresses = [var.alert_email]
  }

  # Alert 3: Forecasted to hit 80% of our $20 soft limit ($16)
  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = 80
    threshold_type             = "PERCENTAGE"
    notification_type          = "FORECASTED"
    subscriber_email_addresses = [var.alert_email]
  }
}
