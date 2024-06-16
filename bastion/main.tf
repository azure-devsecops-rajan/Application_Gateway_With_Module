resource "azurerm_public_ip" "pip" {
    for_each = var.bastion
  name                = each.value.pip-name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  allocation_method   = each.value.allocation_method
  sku                 = each.value.sku
}

resource "azurerm_bastion_host" "bastion" {
    for_each = var.bastion
  name                = each.value.bastion-name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name                 = each.value.if-conf-name
    subnet_id            = data.azurerm_subnet.datasubbastion[each.key].id
    public_ip_address_id = azurerm_public_ip.pip[each.key].id
  }
}