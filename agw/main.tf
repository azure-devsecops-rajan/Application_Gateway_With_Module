resource "azurerm_public_ip" "pip" {
    for_each = var.agw
  name                = each.value.pip-name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  allocation_method   = "Static"
  sku = "Standard"
}
resource "azurerm_application_gateway" "agw" {
    for_each = var.agw
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location

  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "ip-conf-name"
    subnet_id = data.azurerm_subnet.datasubagw[each.key].id
  }

  frontend_port {
    name = "frontend-port"
    port = 80
  }

  frontend_ip_configuration {
    name                 = "frontend-ip-conf"
    public_ip_address_id = azurerm_public_ip.pip[each.key].id
  }

  backend_address_pool {
    name = "backend-add-pool"
  }

  backend_http_settings {
    name                  = "backend-http-setting"
    cookie_based_affinity = "Disabled"
    path                  = "/path1/"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
  }

  http_listener {
    name                           = "http-listener"
    frontend_ip_configuration_name = "frontend-ip-conf"
    frontend_port_name             = "frontend-port"
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = "request_routing_rule"
    priority                   = 9
    rule_type                  = "Basic"
    http_listener_name         = "http-listener"
    backend_address_pool_name  = "backend-add-pool"
    backend_http_settings_name = "backend-http-setting"
  }
}
resource "azurerm_network_interface_application_gateway_backend_address_pool_association" "associate1" {
    for_each = var.agw
  network_interface_id    = data.azurerm_network_interface.datanicagw1[each.key].id
  ip_configuration_name   = "internal"
  backend_address_pool_id = tolist(azurerm_application_gateway.agw[each.key].backend_address_pool).0.id
}
resource "azurerm_network_interface_application_gateway_backend_address_pool_association" "associate2" {
    for_each = var.agw
  network_interface_id    = data.azurerm_network_interface.datanicagw2[each.key].id
  ip_configuration_name   = "internal"
  backend_address_pool_id = tolist(azurerm_application_gateway.agw[each.key].backend_address_pool).0.id
}