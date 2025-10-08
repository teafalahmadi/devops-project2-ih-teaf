##############################################
# Public IP for Application Gateway
##############################################
resource "azurerm_public_ip" "main" {
  name                = "${var.prefix}-appgw-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}


##############################################
# Application Gateway (WAF v2)
##############################################
resource "azurerm_application_gateway" "main" {
  name                = "${var.prefix}-appgw"
  location            = var.location
  resource_group_name = var.resource_group_name

  sku {
    name     = "WAF_v2"
    tier     = "WAF_v2"
    capacity = 2
  }

  # ✅ Modern TLS 1.2+ policy (fixes deprecated TLS error)
  ssl_policy {
    policy_type          = "Predefined"
    policy_name          = "AppGwSslPolicy20220101"
    min_protocol_version = "TLSv1_2"
  }

  gateway_ip_configuration {
    name      = "appgw-ip-config"
    subnet_id = var.subnet_id
  }

  frontend_ip_configuration {
    name                 = "public-ip"
    public_ip_address_id = azurerm_public_ip.main.id
  }

  frontend_port {
    name = "port-80"
    port = 80
  }

  backend_address_pool {
    name = "frontend-pool"
  }

  backend_http_settings {
    name                  = "frontend-http"
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 30
  }

  http_listener {
    name                           = "listener-frontend"
    frontend_ip_configuration_name = "public-ip"
    frontend_port_name             = "port-80"
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = "route-frontend"
    rule_type                  = "Basic"
    http_listener_name         = "listener-frontend"
    backend_address_pool_name  = "frontend-pool"
    backend_http_settings_name = "frontend-http"
    priority                   = 100
  }

  waf_configuration {
    enabled          = true
    firewall_mode    = "Prevention"
    rule_set_type    = "OWASP"
    rule_set_version = "3.2"
  }

  depends_on = [azurerm_public_ip.main]
}


##############################################
# Diagnostic Settings → Log Analytics
##############################################
resource "azurerm_monitor_diagnostic_setting" "appgw_logs" {
  name                       = "${var.prefix}-appgw-logs"
  target_resource_id         = azurerm_application_gateway.main.id
  log_analytics_workspace_id = var.log_analytics_id

  enabled_log {
    category = "ApplicationGatewayAccessLog"
  }

  enabled_log {
    category = "ApplicationGatewayPerformanceLog"
  }

  enabled_log {
    category = "ApplicationGatewayFirewallLog"
  }

  metric {
    category = "AllMetrics"
    enabled  = true
  }
}


# Outputs
output "appgw_public_ip" {
  description = "The public IP address of the Application Gateway."
  value       = azurerm_public_ip.main.ip_address
}

output "appgw_id" {
  description = "The resource ID of the Application Gateway."
  value       = azurerm_application_gateway.main.id
}
