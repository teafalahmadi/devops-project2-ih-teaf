# ============================================
# Azure Container Instances - Frontend & Backend
# ============================================

# Frontend Container Group
resource "azurerm_container_group" "frontend" {
  name                = "frontend-container"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = "Linux"
  restart_policy      = "Always"

  ip_address_type = "Private"
  subnet_ids      = [azurerm_subnet.web_subnet.id]

  container {
    name   = "frontend"
    image  = "docker.io/teaf/frontend:latest"
    cpu    = 1
    memory = 1.5

    ports {
      port     = 5173
      protocol = "TCP"
    }
  }

  tags = {
    project = "devops-project2-ih"
    env     = "dev"
  }
}

# Backend Container Group
resource "azurerm_container_group" "backend" {
  name                = "backend-container"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = "Linux"
  restart_policy      = "Always"

  ip_address_type = "Private"
  subnet_ids      = [azurerm_subnet.api_subnet.id]

  container {
    name   = "backend"
    image  = "docker.io/teaf/backend:latest"
    cpu    = 1
    memory = 1.5

    ports {
      port     = 8080
      protocol = "TCP"
    }

    environment_variables = {
      NODE_ENV                      = "production"
      DB_SERVER                     = azurerm_mssql_server.sql.fully_qualified_domain_name
      DB_NAME                       = "teafdb"
      DB_USER                       = "sqladminuser"
      DB_PASSWORD                   = var.sql_admin_password
      APPINSIGHTS_CONNECTION_STRING = azurerm_application_insights.appi.connection_string
    }
  }

  tags = {
    project = "devops-project2-ih"
    env     = "dev"
  }
}
