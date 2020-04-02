resource "ibm_is_network_acl" "isWebServerACL" {
  name = "${var.vpc_name}-WebServer-acl"
  rules {
    name        = "outbound"
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
    name        = "inbound"
    action      = "allow"
    source      = "0.0.0.0/0"
    destination = "${var.address-prefix-vpc}"
    direction   = "inbound"
    tcp {
      port_max        = 80
      port_min        = 80
      source_port_max = 60000
      source_port_min = 22
    }
  }


    rules {
    name        = "inbound"
    action      = "allow"
    source      = "0.0.0.0/0"
    destination = "${var.address-prefix-vpc}"
    direction   = "inbound"
    tcp {
      port_max        = 22
      port_min        = 22
      source_port_max = 60000
      source_port_min = 22
    }

  }
}