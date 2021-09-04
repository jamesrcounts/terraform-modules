module "example" {
  source = "../"

  log_analytics_workspace = azurerm_log_analytics_workspace.insights
  resource_group          = azurerm_resource_group.example
  environment             = "test"


  subnets = {
    "aks-subnet" = {
      bits                    = 8
      net                     = 238
      enable_private_endpoint = false
    }
    "ple-subnet" = {
      bits                    = 8
      net                     = 1
      enable_private_endpoint = true
    }
  }
}

output "virtual_network_id" {
  value = module.example.virtual_network_id
}

output "virtual_network_name" {
  value = module.example.virtual_network_name
}

resource "azurerm_log_analytics_workspace" "insights" {
  name                = "la-example"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
  tags                = azurerm_resource_group.example.tags
}

resource "azurerm_resource_group" "example" {
  location = "centralus"
  name     = "rg-example"
  tags = {
    instance_id = "test"
  }
}

provider "azurerm" {
  features {

  }
}