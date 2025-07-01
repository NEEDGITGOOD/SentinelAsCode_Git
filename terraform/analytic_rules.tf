resource "azurerm_sentinel_alert_rule_scheduled" "sign_in_alert" {
  name                       = "sign-in-failure-alert-signinlogs"
  log_analytics_workspace_id = azurerm_log_analytics_workspace.law.id
  display_name              = "Multiple Sign-in Failures - SignInLogs"
  description               = "Detects multiple sign-in failures within a 5-minute window"

  query = <<QUERY
SigninLogs
| where ResultType == "50074"
| summarize count() by bin(TimeGenerated, 5m), UserPrincipalName
| where count_ > 3
QUERY

  severity       = "Medium"
  tactics        = ["InitialAccess"]
  trigger_operator = "GreaterThan"
  trigger_threshold = 0
  query_frequency   = "PT5M"  # Every 5 minutes
  query_period   = "PT5M"  # Look back 5 minutes
  enabled        = true
}