terraform {
  required_version = ">= 1"

  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2"
    }
    kustomization = {
      source  = "kbst/kustomization"
      version = "~> 0"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2"
    }
  }
}