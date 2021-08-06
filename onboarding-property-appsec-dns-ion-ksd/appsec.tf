variable "configuration_name" { }
variable "configuration_description" { }
variable "policy_name" { }
variable "policy_prefix" { }
variable "ipblock_list" { }
variable "ipblock_list_exceptions" { }
variable "geoblock_list" { }
variable "securitybypass_list" { }
variable "ratepolicy_page_view_requests_action" { }
variable "ratepolicy_origin_error_action" { }
variable "ratepolicy_post_requests_action" { }
variable "slow_post_protection_action" { }
variable "attack_group_web_attack_tool_action" { }
variable "attack_group_web_protocol_attack_action" { }
variable "attack_group_sql_injection_action" { }
variable "attack_group_cross_site_scripting_action" { }
variable "attack_group_local_file_inclusion_action" { }
variable "attack_group_remote_file_inclusion_action" { }
variable "attack_group_command_injection_action" { }
variable "attack_group_web_platform_attack_action" { }
variable "activation_notes" { }


resource "akamai_appsec_configuration" "akamai_appsec" {
  contract_id = replace(var.contract_id, "ctr_", "")
  group_id  = replace(data.akamai_group.group.id, "grp_", "")
  name = var.configuration_name
  description = var.configuration_description
  host_names = [ var.hostname ]

  depends_on = [ akamai_property_activation.activation ]
}

resource "akamai_appsec_security_policy" "security_policy" {
  config_id = akamai_appsec_configuration.akamai_appsec.config_id
  security_policy_name = var.policy_name
  security_policy_prefix = var.policy_prefix
}

resource "akamai_appsec_advanced_settings_pragma_header" "pragma_header" {
  config_id = akamai_appsec_configuration.akamai_appsec.config_id
  security_policy_id = akamai_appsec_security_policy.security_policy.security_policy_id
  pragma_header = file("${path.module}/appsec-snippets/pragma_header.json")
}

resource "akamai_appsec_match_target" "match_target" {
  config_id = akamai_appsec_configuration.akamai_appsec.config_id
  match_target = templatefile("${path.module}/appsec-snippets/match_targets.json", { 
      config_id = akamai_appsec_configuration.akamai_appsec.config_id, 
      hostname = var.hostname, 
      policy_id = akamai_appsec_security_policy.security_policy.security_policy_id 
      securitybypass_list = akamai_networklist_network_list.SECURITYBYPASSLIST.id
      } 
    )
}

resource "akamai_networklist_network_list" "IPBLOCKLIST" {
  name = "IPBLOCKLIST"
  type = "IP"
  description = "IPBLOCKLIST"
  list = var.ipblock_list
  mode = "REPLACE"
}

resource "akamai_networklist_network_list" "IPBLOCKLISTEXCEPTIONS" {
  name = "IPBLOCKLISTEXCEPTIONS"
  type = "IP"
  description = "IPBLOCKLISTEXCEPTIONS"
  list = var.ipblock_list_exceptions
  mode = "REPLACE"
}

resource "akamai_networklist_network_list" "GEOBLOCKLIST" {
  name = "GEOBLOCKLIST"
  type = "GEO"
  description = "GEOBLOCKLIST"
  list = var.geoblock_list
  mode = "REPLACE"
}

resource "akamai_networklist_network_list" "SECURITYBYPASSLIST" {
  name = "SECURITYBYPASSLIST"
  type = "IP"
  description = "SECURITYBYPASSLIST"
  list = var.securitybypass_list
  mode = "REPLACE"
}

resource  "akamai_appsec_ip_geo" "ip_geo_block" {
  config_id = akamai_appsec_configuration.akamai_appsec.config_id
  security_policy_id = akamai_appsec_security_policy.security_policy.security_policy_id
  mode = "block"
  ip_network_lists = [ akamai_networklist_network_list.IPBLOCKLIST.id ]
  geo_network_lists = [ akamai_networklist_network_list.GEOBLOCKLIST.id ]
  exception_ip_network_lists = [ akamai_networklist_network_list.IPBLOCKLISTEXCEPTIONS.id ]
}

resource "akamai_appsec_rate_policy" "rate_policy_page_view_requests" {
  config_id = akamai_appsec_configuration.akamai_appsec.config_id
  rate_policy =  file("${path.module}/appsec-snippets/rate-policies/rate_policy_page_view_requests.json")
}

resource  "akamai_appsec_rate_policy_action" "appsec_rate_policy_page_view_requests_action" {
  config_id = akamai_appsec_configuration.akamai_appsec.config_id
  security_policy_id = akamai_appsec_security_policy.security_policy.security_policy_id
  rate_policy_id = akamai_appsec_rate_policy.rate_policy_page_view_requests.rate_policy_id
  ipv4_action = var.ratepolicy_page_view_requests_action
  ipv6_action = var.ratepolicy_page_view_requests_action
}

resource "akamai_appsec_rate_policy" "rate_policy_origin_error" {
  config_id = akamai_appsec_configuration.akamai_appsec.config_id
  rate_policy =  file("${path.module}/appsec-snippets/rate-policies/rate_policy_origin_error.json")
}

resource  "akamai_appsec_rate_policy_action" "appsec_rate_policy_origin_error_action" {
  config_id = akamai_appsec_configuration.akamai_appsec.config_id
  security_policy_id = akamai_appsec_security_policy.security_policy.security_policy_id
  rate_policy_id = akamai_appsec_rate_policy.rate_policy_origin_error.rate_policy_id
  ipv4_action = var.ratepolicy_origin_error_action
  ipv6_action = var.ratepolicy_origin_error_action
}

resource "akamai_appsec_rate_policy" "rate_policy_post_requests" {
  config_id = akamai_appsec_configuration.akamai_appsec.config_id
  rate_policy =  file("${path.module}/appsec-snippets/rate-policies/rate_policy_post_requests.json")
}

resource  "akamai_appsec_rate_policy_action" "appsec_rate_policy_post_requests_action" {
  config_id = akamai_appsec_configuration.akamai_appsec.config_id
  security_policy_id = akamai_appsec_security_policy.security_policy.security_policy_id
  rate_policy_id = akamai_appsec_rate_policy.rate_policy_post_requests.rate_policy_id
  ipv4_action = var.ratepolicy_post_requests_action
  ipv6_action = var.ratepolicy_post_requests_action
}

resource "akamai_appsec_slow_post" "slow_post" {
  config_id = akamai_appsec_configuration.akamai_appsec.config_id
  security_policy_id = akamai_appsec_security_policy.security_policy.security_policy_id
  slow_rate_action = var.slow_post_protection_action
  slow_rate_threshold_rate = 10
  slow_rate_threshold_period = 60
}

resource "akamai_appsec_attack_group" "attack_group_web_attack_tool" {
  config_id = akamai_appsec_configuration.akamai_appsec.config_id
  security_policy_id = akamai_appsec_security_policy.security_policy.security_policy_id
  attack_group = "TOOL"
  attack_group_action = var.attack_group_web_attack_tool_action
  condition_exception = file("${path.module}/appsec-snippets/attack-groups/attack_group_web_attack_tool_exception.json")
}

resource "akamai_appsec_attack_group" "attack_group_web_protocol_attack" {
  config_id = akamai_appsec_configuration.akamai_appsec.config_id
  security_policy_id = akamai_appsec_security_policy.security_policy.security_policy_id
  attack_group = "PROTOCOL"
  attack_group_action = var.attack_group_web_protocol_attack_action
  condition_exception = file("${path.module}/appsec-snippets/attack-groups/attack_group_web_protocol_attack_exception.json")
}

resource "akamai_appsec_attack_group" "attack_group_sql_injection" {
  config_id = akamai_appsec_configuration.akamai_appsec.config_id
  security_policy_id = akamai_appsec_security_policy.security_policy.security_policy_id
  attack_group = "SQL"
  attack_group_action = var.attack_group_sql_injection_action
  condition_exception = file("${path.module}/appsec-snippets/attack-groups/attack_group_sql_injection_exception.json")
}

resource "akamai_appsec_attack_group" "attack_group_cross_site_scripting" {
  config_id = akamai_appsec_configuration.akamai_appsec.config_id
  security_policy_id = akamai_appsec_security_policy.security_policy.security_policy_id
  attack_group = "XSS"
  attack_group_action = var.attack_group_cross_site_scripting_action
  condition_exception = file("${path.module}/appsec-snippets/attack-groups/attack_group_cross_site_scripting_exception.json")
}

resource "akamai_appsec_attack_group" "attack_group_local_file_inclusion" {
  config_id = akamai_appsec_configuration.akamai_appsec.config_id
  security_policy_id = akamai_appsec_security_policy.security_policy.security_policy_id
  attack_group = "LFI"
  attack_group_action = var.attack_group_local_file_inclusion_action
  condition_exception = file("${path.module}/appsec-snippets/attack-groups/attack_group_local_file_inclusion_exception.json")
}

resource "akamai_appsec_attack_group" "attack_group_remote_file_inclusion" {
  config_id = akamai_appsec_configuration.akamai_appsec.config_id
  security_policy_id = akamai_appsec_security_policy.security_policy.security_policy_id
  attack_group = "RFI"
  attack_group_action = var.attack_group_remote_file_inclusion_action
  condition_exception = file("${path.module}/appsec-snippets/attack-groups/attack_group_remote_file_inclusion_exception.json")
}

resource "akamai_appsec_attack_group" "attack_group_command_injection" {
  config_id = akamai_appsec_configuration.akamai_appsec.config_id
  security_policy_id = akamai_appsec_security_policy.security_policy.security_policy_id
  attack_group = "CMDI"
  attack_group_action = var.attack_group_command_injection_action
  condition_exception = file("${path.module}/appsec-snippets/attack-groups/attack_group_command_injection_exception.json")
}

resource "akamai_appsec_attack_group" "attack_group_web_platform_attack" {
  config_id = akamai_appsec_configuration.akamai_appsec.config_id
  security_policy_id = akamai_appsec_security_policy.security_policy.security_policy_id
  attack_group = "PLATFORM"
  attack_group_action = var.attack_group_web_platform_attack_action
  condition_exception = file("${path.module}/appsec-snippets/attack-groups/attack_group_web_platform_attack_exception.json")
}

resource "akamai_appsec_activations" "activation" {
  config_id = akamai_appsec_configuration.akamai_appsec.config_id
  network = upper(var.akamai_network)
  notes  = var.activation_notes
  notification_emails = [ var.email ]

  depends_on = [ 
    akamai_appsec_configuration.akamai_appsec, 
    akamai_appsec_security_policy.security_policy, 
    akamai_appsec_advanced_settings_pragma_header.pragma_header,
    akamai_appsec_match_target.match_target, 
    akamai_appsec_ip_geo.ip_geo_block,
    akamai_appsec_rate_policy.rate_policy_page_view_requests,
    akamai_appsec_rate_policy.rate_policy_origin_error,
    akamai_appsec_rate_policy.rate_policy_post_requests,
    akamai_appsec_slow_post.slow_post
    ]
}