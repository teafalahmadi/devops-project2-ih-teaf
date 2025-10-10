# Resource Group
resource "azurerm_resource_group" "main" {
  name     = "${var.prefix}-rg"
  location = var.location
}

# Network
module "network" {
  source              = "./modules/network"
  resource_group_name = azurerm_resource_group.main.name
  location            = var.location
  prefix              = var.prefix
}

# AKS
module "aks" {
  source              = "./modules/aks"
  resource_group_name = azurerm_resource_group.main.name
  location            = var.location
  prefix              = var.prefix
  subnet_id           = module.network.aks_subnet_id
}

# Monitoring
module "monitoring" {
  source              = "./modules/monitoring"
  resource_group_name = azurerm_resource_group.main.name
  location            = var.location
  prefix              = var.prefix
}

# Application Gateway (WAF v2)
module "appgw" {
  source              = "./modules/appgw"
  resource_group_name = azurerm_resource_group.main.name
  location            = var.location
  prefix              = var.prefix
  subnet_id           = module.network.appgw_subnet_id
  backend_addresses   = [] # to be updated after workloads are deployed
  log_analytics_id    = module.monitoring.log_analytics_id
}
