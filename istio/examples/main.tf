terraform {
  required_version = ">= 1"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2"
    }
    kustomization = {
      source  = "kbst/kustomization"
      version = "~> 0"
    }
  }
}

provider "azurerm" {
  features {}
}

data "azurerm_kubernetes_cluster" "aks" {
  name                = "aks-example"
  resource_group_name = "rg-example"
}

provider "kustomization" {
  kubeconfig_raw = data.azurerm_kubernetes_cluster.aks.kube_admin_config_raw
}

module "istio" {
  source = "../"
}