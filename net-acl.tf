resource "ibm_is_network_acl" "default_acl" {
  name = "${var.vpc_name}-default-acl"

  rules = [
    {
      name        = "${var.vpc_name}-default-deny-all-ingress"
      action      = "deny"
      source      = "0.0.0.0/0"
      destination = "0.0.0.0/0"
      direction   = "inbound"
    },
    {
      name        = "${var.vpc_name}-default-deny-all-egress"
      action      = "deny"
      source      = "0.0.0.0/0"
      destination = "0.0.0.0/0"
      direction   = "outbound"
    },
  ]
}

resource "ibm_is_network_acl" "webapptier_acl" {
  name = "${var.vpc_name}-webapptier-acl"

  rules = [
    {
      name      = "${var.vpc_name}-webapptier-icmp-all"
      direction = "inbound"
      action    = "allow"
      source    = "0.0.0.0/0"

      icmp = {
        type = "0"
        code = "0"
      }

      destination = "0.0.0.0/0"
    },
    {
      name        = "${var.vpc_name}-webapptier-within-vpc"
      direction   = "inbound"
      action      = "allow"
      source      = "${var.address-prefix-vpc}"
      destination = "${var.address-prefix-vpc}"
    },
    {
      name        = "${var.vpc_name}-webapptier-web-http-traffic"
      direction   = "inbound"
      action      = "allow"
      source      = "0.0.0.0/0"
      destination = "${var.address-prefix-vpc}"

      tcp = {
        port_min = "80"
        port_max = "80"
      }
    },
    {
      name        = "${var.vpc_name}-webapptier-allow-all-egress"
      action      = "allow"
      source      = "0.0.0.0/0"
      destination = "0.0.0.0/0"
      direction   = "outbound"
    },
  ]
}