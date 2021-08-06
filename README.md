# akamai-terraform-templates
Repository that contains Akamai Terraform Provider templates. 

NOTES AUGUST 6 2021: This is the first iteration of these templates and are still being tested by the Akamai Terraform Champions to ensure they work for certain corner cases as well. Please verify your Akamai product in the notes below. 

**property-template**

This template can be used with **Akamai Ion (prd_Fresca)** to create a basic Akamai delivery configuration from scratch. property.tf and main.json do not need to be altered for a functional configuration. property.auto.tfvars can be filled with your required settings/variables. Video tutorial (30 minutes) can be found here:  https://www.youtube.com/watch?v=Oo3rbkHhA2I&ab_channel=SECURITYLEVELUP

**property-template-akamai-dsa**

This template can be used with **Akamai Dynamic Site Accelerator (prd_Site_Accel)** to create a basic Akamai delivery configuration from scratch. property.tf and main.json do not need to be altered for a functional configuration. property.auto.tfvars can be filled with your required settings/variables.

**onboarding-template**

This template can be used to provision **Akamai Ion on Standard TLS with a Secure By Default Let's Encrypt Certificate together with a Kona Site Defender security configuration and all the best pratices protections in ALERT mode. It will also create two DNS records for your zone in Edge DNS**, both the Domain Validation CNAME and the actual CNAME to Akamai for your hostname. WARNING - Please exercise caution with this as the CNAME to Akamai can disrupt your production traffic. Only use this template for test domains. NOTE - There is an open issue on creating Network Lists with empty values so currently some IPs and US are passed into the IP/GEO Lists.

More templates coming later.
