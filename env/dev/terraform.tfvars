rg = {
  rg1 = {
    name     = "rg-agw"
    location = "eastus"
  }
}
vnet = {
  vnet1 = {
    name                = "vnet-agw"
    location            = "eastus"
    resource_group_name = "rg-agw"
    address_space       = ["10.0.0.0/16"]
  }
}
subnet = {
  sub1 = {
    name                 = "Subnet-vm1"
    resource_group_name  = "rg-agw"
    virtual_network_name = "vnet-agw"
    address_prefixes     = ["10.0.1.0/24"]
  }
  sub2 = {
    name                 = "Subnet-vm2"
    resource_group_name  = "rg-agw"
    virtual_network_name = "vnet-agw"
    address_prefixes     = ["10.0.2.0/24"]
  }
  sub3 = {
    name                 = "Subnet-agw"
    resource_group_name  = "rg-agw"
    virtual_network_name = "vnet-agw"
    address_prefixes     = ["10.0.3.0/24"]
  }
  sub4 = {
    name                 = "AzureBastionSubnet"
    resource_group_name  = "rg-agw"
    virtual_network_name = "vnet-agw"
    address_prefixes     = ["10.0.4.0/24"]
  }
}
nic = {
  nic1 = {
    name                          = "nic-vm1"
    location                      = "eastus"
    resource_group_name           = "rg-agw"
    virtual_network_name          = "vnet-agw"
    ip-conf-name                  = "internal"
    subnet-name                   = "Subnet-vm1"
    private_ip_address_allocation = "Dynamic"
  }
  nic2 = {
    name                          = "nic-vm2"
    location                      = "eastus"
    resource_group_name           = "rg-agw"
    virtual_network_name          = "vnet-agw"
    ip-conf-name                  = "internal"
    subnet-name                   = "Subnet-vm2"
    private_ip_address_allocation = "Dynamic"
  }
}
vm = {
  vm1 = {
    name                            = "vm1"
    resource_group_name             = "rg-agw"
    location                        = "eastus"
    nic-name                        = "nic-vm1"
    size                            = "Standard_F2"
    admin_username                  = "username"
    admin_password                  = "Pass@12341234"
    disable_password_authentication = false
    caching                         = "ReadWrite"
    storage_account_type            = "Standard_LRS"
    publisher                       = "Canonical"
    offer                           = "0001-com-ubuntu-server-jammy"
    sku                             = "22_04-lts"
    version                         = "latest"
  }
  vm2 = {
    name                            = "vm2"
    resource_group_name             = "rg-agw"
    location                        = "eastus"
    nic-name                        = "nic-vm2"
    size                            = "Standard_F2"
    admin_username                  = "username"
    admin_password                  = "Pass@12341234"
    disable_password_authentication = false
    caching                         = "ReadWrite"
    storage_account_type            = "Standard_LRS"
    publisher                       = "Canonical"
    offer                           = "0001-com-ubuntu-server-jammy"
    sku                             = "22_04-lts"
    version                         = "latest"
  }
}
bastion = {
  bastion1 = {
    pip-name             = "pip-bastion"
    location             = "eastus"
    resource_group_name  = "rg-agw"
    allocation_method    = "Static"
    sku                  = "Standard"
    bastion-name         = "bastion-host"
    if-conf-name         = "configuration"
    subnet-name          = "AzureBastionSubnet"
    virtual_network_name = "vnet-agw"
  }
}
agw = {
  agw1 = {
    pip-name             = "pip-agw"
    name                 = "agw"
    resource_group_name  = "rg-agw"
    location             = "eastus"
    subnet-name          = "Subnet-agw"
    virtual_network_name = "vnet-agw"
    nic-name1            = "nic-vm1"
    nic-name2            = "nic-vm2"
  }
}