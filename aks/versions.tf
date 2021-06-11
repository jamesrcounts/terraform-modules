terraform {
  required_version = ">= 1"

  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 1"
    }

    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2"
    }
  }
}