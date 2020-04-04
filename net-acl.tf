resource "ibm_is_network_acl" "isWebServerACL" {
  name = "${var.vpc_name}-wwebserver-acl"
  vpc  = "${ibm_is_vpc.vpc1.id}"
//  resource_group ="${data.ibm_resource_group.resource.id}"

  rules {
    name        = "${var.vpc_name}-outbound-tcp-all"
    action      = "allow"
    source      = "0.0.0.0/0"
    destination = "0.0.0.0/0"
    direction   = "outbound"
    tcp {
      port_max        = 65535
      port_min        = 1
      source_port_max = 60000
      source_port_min = 22
    }
  }
  
    rules {
    name        = "${var.vpc_name}-outbound-udp-all"
    action      = "allow"
    source      = "0.0.0.0/0"
    destination = "0.0.0.0/0"
    direction   = "outbound"
    udp {
      port_max        = 65535
      port_min        = 1
      source_port_max = 60000
      source_port_min = 22
    }
  }
  
  rules {
    name        = "${var.vpc_name}-inbound-tcp-all"
    action      = "allow"
    source      = "0.0.0.0/0"
    destination = "${var.address-prefix-vpc}"
    direction   = "inbound"
    tcp {
      port_max        = 65535
      port_min        = 1
      source_port_max = 60000
      source_port_min = 22
    }
  }

  rules {
    name        = "${var.vpc_name}-inbound-udp-all"
    action      = "allow"
    source      = "0.0.0.0/0"
    destination = "${var.address-prefix-vpc}"
    direction   = "inbound"
    udp {
      port_max        = 65535
      port_min        = 1
      source_port_max = 60000
      source_port_min = 22
    }
  }

    
    rules {
    name        = "${var.vpc_name}-outbound-icmp"
    action      = "allow"
    source      = "0.0.0.0/0"
    destination = "0.0.0.0/0"
    direction   = "outbound"
    icmp {
      code = ""
      type = ""
    }
  }
  
  rules {
    name        = "${var.vpc_name}-inbound-icmp"
    action      = "allow"
    source      = "0.0.0.0/0"
    destination = "0.0.0.0/0"
    direction   = "inbound"
    icmp {
      code = ""
      type = ""
    }
  }
  
}
