##############################
# Network Security Groups
##############################

# --- Web NSG ---
resource "azurerm_network_security_group" "web_nsg" {
  name                = "web-nsg"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "allow-appgw-to-web"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_address_prefix      = "10.0.4.0/24" # App Gateway subnet
    source_port_range          = "*"
    destination_address_prefix = "*"
    destination_port_ranges    = ["80", "5173"]
  }

  security_rule {
    name                       = "allow-ssh-out"
    priority                   = 200
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_address_prefix      = "*" # <── أضفناها هنا
    source_port_range          = "*"
    destination_address_prefix = "*"
    destination_port_ranges    = ["22"]
  }
}

# --- API NSG ---
resource "azurerm_network_security_group" "api_nsg" {
  name                = "api-nsg"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "allow-web-to-api"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_address_prefix      = "10.0.1.0/24"
    source_port_range          = "*"
    destination_address_prefix = "*"
    destination_port_ranges    = ["8080", "1433"]
  }

  security_rule {
    name                       = "allow-out-to-db"
    priority                   = 200
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_address_prefix      = "*" # <── وهنا كمان
    source_port_range          = "*"
    destination_address_prefix = "10.0.3.0/24"
    destination_port_range     = "1433"
  }
  security_rule {
    name                       = "allow-appgw-to-api"
    priority                   = 150
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "8080"
    source_address_prefix       = "10.0.4.0/24"   # شبكة الـ App Gateway
    destination_address_prefix  = "*"
  }



}

# --- DB NSG ---
resource "azurerm_network_security_group" "db_nsg" {
  name                = "db-nsg"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "allow-api-to-db"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_address_prefix      = "10.0.2.0/24"
    source_port_range          = "*"
    destination_address_prefix = "*"
    destination_port_range     = "1433"
  }
}

##############################
# NSG Associations
##############################
resource "azurerm_subnet_network_security_group_association" "web_assoc" {
  subnet_id                 = azurerm_subnet.web_subnet.id
  network_security_group_id = azurerm_network_security_group.web_nsg.id
}

resource "azurerm_subnet_network_security_group_association" "api_assoc" {
  subnet_id                 = azurerm_subnet.api_subnet.id
  network_security_group_id = azurerm_network_security_group.api_nsg.id
}

resource "azurerm_subnet_network_security_group_association" "db_assoc" {
  subnet_id                 = azurerm_subnet.db_subnet.id
  network_security_group_id = azurerm_network_security_group.db_nsg.id
}
