# akamai-terraform-templates
Repository that contains Akamai Terraform Provider templates. 

**property-template**

This template can be used with Akamai Ion to create a basic Akamai delivery configuration from scratch. property.tf and main.json do not need to be altered for a functional configuration. property-variables.tf can be filled with your required settings/variables. Video tutorial (30 minutes) can be found here:  https://www.youtube.com/watch?v=Oo3rbkHhA2I&ab_channel=SECURITYLEVELUP

**onboarding-template**

This template can be used to provision Akamai Ion on Standard TLS with a Secure By Default Let's Encrypt Certificate together with a Kona Site Defender security configuration and all the best pratices protections in ALERT mode. It will also create two DNS records for your zone in Edge DNS, both the Domain Validation CNAME and the actual CNAME to Akamai for your hostname. WARNING - Please exercise caution with this as the CNAME to Akamai can disrupt your production traffic. Only use this template for test domains. NOTE - There is an open issue on creating Network Lists with empty values so currently some IPs and US are passed into the IP/GEO Lists.

More templates coming later.
