variable "group_name" { default = "" } //your Akamai Group Name
variable "contract_id" { default = "" } //your Akamai Contract ID
variable "product_id" { default = "" } //Akamai Product ID, Akamai Ion = prd_Fresca
variable "hostname" { default = "" } //your hostname you want to Akamaize
variable "cpcode_name" { default = "" } //your CP Code name, best practice is to make it similar to your hostname
variable "edge_hostname" { default = "" } //your Akamai EdgeHostname ending in .edgesuite.net, .akamaized.net or .edgekey.net
variable "origin_hostname" { default = "" } //your Origin Hostname where Akamai will retrieve the content
variable "ip_behavior" { default = "IPV6_COMPLIANCE" } //IPV4+IPV6 enabled with IPV6_COMPLIANCE FLAG.
variable "rule_format" { default = "v2020-11-02" } //latest stable Property Rule Format
variable "cert_provisioning_type" { default = "DEFAULT" } //DEFAULT = Secure By Default, CPS_MANAGED = CPS managed certificates
variable "akamai_network" { default = "staging" } //Akamai Network, staging or production
variable "email" { default = "" } //your email address for notications