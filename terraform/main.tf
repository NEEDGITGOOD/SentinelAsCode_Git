resource "azurerm_resource_group" "sentinel_rg" {
  name     = "SentinelTest"
  location = "germanywestcentral"
}

resource "azurerm_log_analytics_workspace" "law" {
  name                = "Sentinel-LogAnalytics"
  location            = azurerm_resource_group.sentinel_rg.location
  resource_group_name = azurerm_resource_group.sentinel_rg.name
  sku                 = "PerGB2018"  # Check this matches your actual SKU
  daily_quota_gb      = 5
  retention_in_days   = 30
}

resource "azurerm_sentinel_log_analytics_workspace_onboarding" "sentinel" {
  workspace_id = azurerm_log_analytics_workspace.law.id
}