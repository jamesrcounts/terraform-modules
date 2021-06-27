module "istio_control_plane" {
  source = "../"

  ingress_gateway = {
    ip = {
      resource_group = "rg-becoming-chicken"
      value          = "1.2.3.4"
    }
  }
}

// data "azurerm_kubernetes_cluster" "aks" {
//   name                = "aks-becoming-chicken-dmz"
//   resource_group_name = "rg-becoming-chicken"
// }

provider "azurerm" {
  features {}
}

terraform {
  required_version = ">= 1"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2"
    }
  }
}



