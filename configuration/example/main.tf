module "configuration" {
  source = "../"

  additional_imports = ["subnets"]
  instance_id        = local.instance_id
}

locals {
  instance_id = "upward-badger"
}

output "ids" {
  value = module.configuration.instance_id
}

output "subnets" {
  value = nonsensitive(module.configuration.imports["subnets"])
}

output "tenant_id" {
  value = module.configuration.key_vault.tenant_id
}

provider "azurerm" {
  features {}
}