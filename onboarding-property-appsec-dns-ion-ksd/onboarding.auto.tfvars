contract_id = "" //your Akamai Contract ID
group_name = "" //your Akamai Group Name
product_id = "prd_Fresca" //Akamai Product ID, Akamai Ion = prd_Fresca
hostname = "" //your hostname you want to Akamaize
cpcode_name = "" //your CP Code name, best practice is to make it similar to your hostname
edge_hostname = "" //your Akamai EdgeHostname ending in .edgesuite.net, .akamaized.net or .edgekey.net
origin_hostname = "" //your Origin Hostname where Akamai will retrieve the content
ip_behavior = "IPV6_COMPLIANCE" //IPV4+IPV6 enabled with IPV6_COMPLIANCE FLAG.
rule_format = "v2020-11-02" //latest stable Property Rule Format
cert_provisioning_type = "DEFAULT" //DEFAULT = Secure By Default, CPS_MANAGED = CPS managed certificates
akamai_network = "staging" //Akamai Network, staging or production
email = "" //your email address for notications

configuration_name = "" //the name of your AppSec configuration
configuration_description = "" //the description of your AppSec configuration
policy_name = "" //the name of your AppSec policy
policy_prefix = "M1K3" //the four-character alphanumeric prefix for your policy. Eg. 0000 or M1K3
ipblock_list = [ "192.168.0.1", "192.168.0.2", "192.168.0.3", "192.168.0.5"] //the list of IP/CIDR addresses you want to block
ipblock_list_exceptions = [ "192.168.0.1", "192.168.0.2", "192.168.0.3", "192.168.0.5"] //the list of IP/CIDR addresses you want to block
geoblock_list = [ "US" ] //the list of GEO country codes you want to block
securitybypass_list = [ "192.168.0.1", "192.168.0.2", "192.168.0.3", "192.168.0.5"] //the list of IP/CIDR addresses you want to be able to bypass the security policy.
ratepolicy_page_view_requests_action = "alert" //Action set to either alert or deny.
ratepolicy_origin_error_action = "alert" //Action set to either alert or deny.
ratepolicy_post_requests_action = "alert" //Action set to either alert or deny.
slow_post_protection_action = "alert" //Action set to either alert or deny.
attack_group_web_attack_tool_action = "alert" //Action set to either alert or deny.
attack_group_web_protocol_attack_action = "alert" //Action set to either alert or deny.
attack_group_sql_injection_action = "alert" //Action set to either alert or deny.
attack_group_cross_site_scripting_action = "alert" //Action set to either alert or deny.
attack_group_local_file_inclusion_action = "alert" //Action set to either alert or deny.
attack_group_remote_file_inclusion_action = "alert" //Action set to either alert or deny.
attack_group_command_injection_action = "alert" //Action set to either alert or deny.
attack_group_web_platform_attack_action = "alert" //Action set to either alert or deny.
activation_notes = "AppSec configuration deployed with the Akamai Terraform Provider. v1" //Activation Notes, changing the notes will deploy a new version to your chosen Akamai network.

zone = "" //your domain hosted in Akamai Edge DNS