# terraform version1.2.9 

#provider declaration

provider "azurerm" {
    features {}
}


#resource group declaration
resource "azurerm_resouce_group" "rg"{
    name        = "SamTerra-rg"
    location    = "westus"
} 


resource "azure_key_vault" "rg" {
    name                    = "kvault01"
    location                = azurerm_resouce_group.rg.location
    resource_group_name     = azurerm_resouce_group.rg.name
    tenant_id               = data.azurerm_client_config.current.tenant_id
    sku_name                = "standard"

}

resource "azure_storage_account" "rg" {
    name                    = "sa01"
    location                = azurerm_resouce_group.rg.location
    resource_group_name     = azurerm_resouce_group.rg.name
    account_tier            = "standard"
    account_replication_type= "LRS"
}




/* test
this is a test comment 
for multple line comment
*/
