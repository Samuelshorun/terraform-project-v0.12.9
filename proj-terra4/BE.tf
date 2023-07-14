/*  rg be-rg 
    vnent web-vnet
    subnet web-subnet
    nsg web-nsg
    nic web-vm01*/

    # terraform v12.29 and Azure as provider is used for this lab

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
    resource_group_name         = azurerm_resource_group.be-rg.name
    network_interface_ids       = [azurerm_network_interface.be-rg.id]
    vm_size                     = "Standard_B2s"

    storage_image_reference { 
        publisher                   = "MicrosoftWindowsServer"
        offer                       = "WindowsServer"
        sku                         = "2016-Datacenter"
        version                     = "latest"
    }
    storage_os_disk {
        name                        = "web-osdisk"
        managed_disk_type           = "StandardSSD_LRS"
        caching                     = "ReadWrite"
        create_option               = "FromImage"
    }
    # definition of VM login propertise
    os_profile {
        computer_name               = "<Enter vm name>"
        admin_username              = "<Enter admin name>"
        admin_password              = "Enter vm password"
    }
    os_profile_windows_config {
        enable_automatic_upgrades   = true
        provision_vm_agent          = true

    }
  
}

resource "azurerm_virtual_machine_extension "be-rg" {
    name                        = "iis-extention"
    virtual_machine_id          = azurerm_virtual_machine.be-rg.id
    publisher                   = "Microsoft.Compute"
    type                        = "CustomScriptEtention"
    tpye_handler_version        = "1.10"
    settings                    = <<SETTINGS
    {
        "commandToExecute": "powershell Install-WindowsFeature -name Web-Server -IncludeManagementTools;"
    }
  SETTINGS
}
