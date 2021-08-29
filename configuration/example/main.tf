module "configuration" {
  source = "../"

  additional_imports = ["subnets"]
  instance_id        = local.instance_id
}

locals {
  instance_id = "brief-anteater"
}

output "ids" {
  value = module.configuration.instance_id
}

output "subnets" {
  value = nonsensitive(module.configuration.imports["subnets"])
}

provider "azurerm" {
  features {}
}