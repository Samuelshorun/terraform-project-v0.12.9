# terraform v12.29

provider "azurerm" {
    version = "= 2.18"
    features {}
}


resource "azurerm_resouce_group" "rg" {
    name        = "SamTerra-rg"
    location    = "West Euroup"
}

# data "azurerm_client_config "current" { }

resource "azurerm_key_vault" "rg" {
    name                = "kvault01"
    location            = azurerm_resouce_group.rg.location
    resource_group_name = azurerm_resouce_group.rg.name
    tenant_id           = azurerm_client_config.current.tenant_id
    sku_name            = "standard"
    access_policy {
        tenant_id = data.azurerm_client_config.current.tenant_id
        object_id = data.azurerm_client_config.current.object_id
        key_permission = [
            "get", "list", "create", "delete", "update",
        ]
    }
}

resource "azurerm_storage_account" "rg" {
    name                        = "storagea01"
    resource_group_name         = azurerm_resouce_group.rg.name
    location                    = azurerm_resouce_group.rg.location
    account_tier                = "standard"
    account_replication_type    = "LRS"
}