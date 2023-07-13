
# terraform v12.29 for Azure Provider

# declaration of Cloud Provider

provider "azurerm" {
    version     = "= 2.18"
    features {}
}



# declaration of resource group

provider "azurerm_resouce_group" "rg" {
    name        = "sammy-rg"
    location    = "West Europe"
}