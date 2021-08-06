group_name = "" //your Akamai Group Name
contract_id = "" //your Akamai Contract ID
product_id = "prd_Site_Accel" //Akamai Product ID, Akamai Ion = prd_Fresca
hostname = "" //your hostname you want to Akamaize
cpcode_name = "" //your CP Code name, best practice is to make it similar to your hostname
edge_hostname = "" //your Akamai EdgeHostname ending in .edgesuite.net, .akamaized.net or .edgekey.net
origin_hostname = "" //your Origin Hostname where Akamai will retrieve the content
ip_behavior = "IPV6_COMPLIANCE" //IPV4+IPV6 enabled with IPV6_COMPLIANCE FLAG.
rule_format = "v2020-11-02" //latest stable Property Rule Format
cert_provisioning_type = "CPS_MANAGED" //DEFAULT = Secure By Default, CPS_MANAGED = CPS managed certificates
akamai_network = "staging" //Akamai Network, staging or production
email = "s" //your email address for notication