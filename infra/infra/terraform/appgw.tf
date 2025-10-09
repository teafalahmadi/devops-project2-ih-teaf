# Public IP for Application Gateway

resource "azurerm_public_ip" "agw_pip" {

  name = "agw-pip"

  resource_group_name = azurerm_resource_group.rg.name

  location = azurerm_resource_group.rg.location

  allocation_method = "Static"

  sku = "Standard"

}



resource "azurerm_application_gateway" "agw" {

  name = "teaf-appgw"

  resource_group_name = azurerm_resource_group.rg.name

  location = azurerm_resource_group.rg.location


  sku {

    name = "WAF_v2"

    tier = "WAF_v2"

    capacity = 1

  }


  waf_configuration {

    enabled = true

    firewall_mode = "Prevention"

    rule_set_type = "OWASP"

    rule_set_version = "3.2"

  }


  gateway_ip_configuration {

    name = "gateway-ipcfg"

    subnet_id = azurerm_subnet.snet_appgw.id

  }


  frontend_ip_configuration {

    name = "frontend-ipcfg"

    public_ip_address_id = azurerm_public_ip.agw_pip.id

  }



  frontend_port {

    name = "frontend-port"

    port = 80

  }


  backend_address_pool {

    name = "backend-pool"

  }


  backend_http_settings {

    name = "http-settings"

    cookie_based_affinity = "Disabled"

    port = 80

    protocol = "Http"

    request_timeout = 20

  }


  http_listener {

    name = "http-listener"

    frontend_ip_configuration_name = "frontend-ipcfg"

    frontend_port_name = "frontend-port"

    protocol = "Http"

  }


  request_routing_rule {

    name = "rule1"

    rule_type = "Basic"

    http_listener_name = "http-listener"

    backend_address_pool_name = "backend-pool"

    backend_http_settings_name = "http-settings"

    priority = 100

  }

}
