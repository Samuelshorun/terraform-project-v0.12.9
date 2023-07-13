# terraform v12.29 for Azure Provider

# declaration of managed identity provider

provider "azurerm" {
    use_msi = true
}

#######################################################################
# terraform v14 for Azure Provider
# declaration of managed identity provider

terraform {
    require_providers {
        azurerm = {
            source  = "hashicorp/azurerm"
            version = "= 2.18"
        }
    }
}

provider azurerm {
    use_msi = true
}

