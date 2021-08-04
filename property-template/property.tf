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

variable "group_name" { }
variable "contract_id" { }
variable "product_id" { }
variable "hostname" {  }
variable "cpcode_name" { }
variable "edge_hostname" { }
variable "origin_hostname" { }
variable "ip_behavior" { }
variable "rule_format" { }
variable "cert_provisioning_type" { }
variable "akamai_network" { }
variable "email" { }

data "akamai_group" "group" {
 group_name = var.group_name
 contract_id = var.contract_id
}

data "akamai_contract" "contract" {
  group_name = var.group_name
}

data "akamai_property_rules_template" "rules" {
  template_file = abspath("${path.module}/property-snippets/main.json")

  variables {
    name = "origin_hostname"
    value = var.origin_hostname
    type = "string"
  }

  variables {
    name = "cp_code"
    value = parseint(replace(akamai_cp_code.cp_code.id, "cpc_", ""), 10)
    type = "number"
  }
}

resource "akamai_cp_code" "cp_code" {
  product_id  = var.product_id
  contract_id = var.contract_id
  group_id = data.akamai_group.group.id
  name = var.cpcode_name
}

resource "akamai_edge_hostname" "edge_hostname" {
  product_id  = var.product_id
  contract_id = var.contract_id
  group_id = data.akamai_group.group.id
  ip_behavior = var.ip_behavior
  edge_hostname = var.edge_hostname 
}

resource "akamai_property" "akamai_property" {
  name = var.hostname
  product_id  = var.product_id
  contract_id = var.contract_id
  group_id = data.akamai_group.group.id
  rule_format = var.rule_format

  hostnames {
    cname_from = var.hostname
    cname_to = var.edge_hostname
    cert_provisioning_type = var.cert_provisioning_type
  }
 
  rules = data.akamai_property_rules_template.rules.json
}

resource "akamai_property_activation" "activation" {
  property_id = akamai_property.akamai_property.id
  contact = [ var.email ]
  version = akamai_property.akamai_property.latest_version
  network = upper(var.akamai_network)
}