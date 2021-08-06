variable "zone" { }

data "akamai_property_hostnames" "hostnames" {
    contract_id = var.contract_id
    group_id = data.akamai_group.group.id
    property_id = akamai_property.akamai_property.id
} 

resource "akamai_dns_record" "AKAMAIZE_CNAME" {
    zone = var.zone
    recordtype = "CNAME"
    ttl = 600
    target = [ var.edge_hostname ]
    name = var.hostname
}

resource "akamai_dns_record" "DV_CNAME" {
    zone = var.zone
    recordtype = "CNAME"
    ttl = 60

    target = [ data.akamai_property_hostnames.hostnames.hostnames[0].cert_status[0].target ]
    name = data.akamai_property_hostnames.hostnames.hostnames[0].cert_status[0].hostname  
    
    depends_on = [ akamai_property.akamai_property ]
}