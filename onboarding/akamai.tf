terraform {
  required_providers {
    akamai = { 
      source = "akamai/akamai" 
    }
  }
  required_version = ">= 0.13"
}

provider "akamai" {
  edgerc = "~/.edgerc"
  config_section = "default"
}