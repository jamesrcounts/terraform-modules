module "istio_control_plane" {
  source = "../"

  revision = "canary"

  ingress_gateway = {
    namespace = "apps"
    ip = {
      resource_group = "rg-becoming-chicken"
      value          = "1.2.3.4"
    }
  }
}

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



