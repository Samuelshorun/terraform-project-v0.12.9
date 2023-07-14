/*  rg be-rg 
    vnent web-vnet
    subnet web-subnet
    nsg web-nsg
    nic web-vm01*/

    # terraform v12.29 used for this lab

resource "azurerm_resource_group" "be-rg" {
    name                        = "Be-rg"
    location                    = "wasteuroup"
    
}

resource "azurem_virtual_network" "be-rg" {
    name                        = "web-net"
    address_space               = ["10.0.2.0/23"]
    location                    = azurerm_resource_group.be-rg.location
    resource_group_name         = azurerm_resource_group.be-rg.name
  
}

resource "azurerm_subnet" "be-rg" {
    name                        = "web-subnet"
    resource_group_name         = azurerm_resource_group.be-rg.location
    virtual_network_name        = azurerm_virtual_network.be-rg.sku_name
    address_prefixes            = ["10.0.2.0/24"] 
  
}

resource "azurerm_network_interface" "be-rg" {
    name                        = "web-nic"
    location                    = azurerm_resource_group.be-rg.location
    resource_group_name         = azurerm_resource_group.be-rg.name

    ip_configuration {
      name                          = "internal"
      subnet_id                     = azurerm_resource_group.be-rg.location
      private_ip_address_allocation = azurerm_resource_group.be-rg.name
    }       
}

resource "azurerm_network_security_group" "be-rg" {
    name                       = "web-nsg"
    location                   = azurerm_resource_group.be-rg.location
    resource_group_name        = azurerm_resource_group.be-rg.name
    
}

resource "azurerm_network_security_rule" "be-rg" {
    name                        = "web"
    priority                    = 100
    direction                   = "Inbound"
    access                      = "allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "80"
    source_address_range        = "*"
    destination_address_prefix  = "${azurerm_resource_group.be-rg.private_ip_address}/32"
    resource_group_name         = azurerm_resource_group.be-rg.name
    network_security_group_name = azurerm_network_security_group.be-rg.name
  
}

resource "azurerm_network_interface_security_group_association" "be-rg" {
    network_interface_id                = azurerm_network_interface.be-rg.id
    network_network_security_group_id   = azurerm_network_security_group.be-rg.name
  
}

resource "azure_virtual_machine" "be-rg" {
    name                        = "web-vm01"
    location                    = azurerm_resouce_group.be-rg.location
    resource_group_name         = azurerm_resource_group
  
}