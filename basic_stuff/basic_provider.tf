# terraform v12.29 for Azure Provider

# declaration of basic provider

provider "azurerm" {
    features
}


#######################################################################
# terraform v14 for Azure Provider
# declaration of basic provider

terraform {
    require_providers {
        azurerm = {
            source  = "hashicorp/azurerm"
            version = "= 2.18"
        }
    }
}

provider "azurerm" {
    features
}