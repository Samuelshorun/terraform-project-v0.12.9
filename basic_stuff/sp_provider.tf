# terraform v12.29 for Azure Provider

# declaration of service principal provider

provider "azurerm" {
    version     = "= 2.4.0"

 # declaration of sample values

    subscription_id     = "00000000-0000-0000-0000-000000000000"
    client_id           =  "00000000-0000-0000-0000-000000000000"
    client_secret       =  "0000-0000-0000-0000-0000000000"
    tenant_id           = "00000000-0000-0000-0000-000000000000"

    features
}

#######################################################################
# terraform v14 for Azure Provider
# declaration of service principal provider

terraform {
    require_providers {
        azurerm = {
            source  = "hashicorp/azurerm"
            version = "= 2.18"
        }
    }
}

provider "azurerm" {
    version     = "= 2.4.0"

 # declaration of sample values

    subscription_id     = "00000000-0000-0000-0000-000000000000"
    client_id           =  "00000000-0000-0000-0000-000000000000"
    client_secret       =  "0000-0000-0000-0000-0000000000"
    tenant_id           = "00000000-0000-0000-0000-000000000000"

    features
}