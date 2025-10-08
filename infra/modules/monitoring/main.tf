# Log Analytics Workspace
resource "azurerm_log_analytics_workspace" "main" {
  name                = "${var.prefix}-law"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

# Application Insights
resource "azurerm_application_insights" "main" {
  name                = "${var.prefix}-appi"
  location            = var.location
  resource_group_name = var.resource_group_name
  workspace_id        = azurerm_log_analytics_workspace.main.id
  application_type    = "web"
}

# # Example alert (AKS CPU usage > 70%)
# resource "azurerm_monitor_metric_alert" "aks_cpu_high" {
#   name                = "${var.prefix}-aks-cpu-alert"
#   resource_group_name = var.resource_group_name
#   scopes              = [] # to be linked to AKS node pool when created
#   description         = "AKS CPU usage above 70%"
#   severity            = 2
#   frequency           = "PT1M"
#   window_size         = "PT5M"
#   criteria {
#     metric_namespace = "Microsoft.ContainerService/managedClusters"
#     metric_name      = "CPUUsagePercentage"
#     aggregation      = "Average"
#     operator         = "GreaterThan"
#     threshold        = 70
#   }
# }

output "log_analytics_id" {
  value = azurerm_log_analytics_workspace.main.id
}

output "app_insights_key" {
  value     = azurerm_application_insights.main.instrumentation_key
  sensitive = true
}
