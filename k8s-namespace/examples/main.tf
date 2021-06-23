terraform {
  required_version = ">= 1"
}

module "ns" {
  source = "../"

  name = "example"
}