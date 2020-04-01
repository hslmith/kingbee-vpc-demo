resource "ibm_is_network_acl" "default_acl" {
  name = "${var.vpc_name}-default-acl"

  rules = [
    {
      name        = "${var.vpc_name}-default-deny-all-ingress"
      action      = "deny"
      source      = "0.0.0.0/0"
      destination = "0.0.0.0/0"
      direction   = "ingress"
    },
    {
      name        = "${var.vpc_name}-default-deny-all-egress"
      action      = "deny"
      source      = "0.0.0.0/0"
      destination = "0.0.0.0/0"
      direction   = "egress"
    },
  ]
}

resource "ibm_is_network_acl" "webapptier_acl" {
  name = "${var.vpc_name}-webapptier-acl"

  rules = [
    {
      name      = "${var.vpc_name}-webapptier-icmp-all"
      direction = "ingress"
      action    = "allow"
      source    = "0.0.0.0/0"

      icmp = {
        type = "0"
        code = "0"
      }

      destination = "0.0.0.0/0"
    },
    {
      name        = "${var.vpc_name}-webapptier-udp-user-ports"
      direction   = "ingress"
      action      = "allow"
      source      = "0.0.0.0/0"
      destination = "0.0.0.0/0"

      udp = {
        port_min = "1024"
        port_max = "65535"
      }
    },
    {
      name        = "${var.vpc_name}-webapptier-tcp-user-ports"
      direction   = "ingress"
      action      = "allow"
      source      = "0.0.0.0/0"
      destination = "0.0.0.0/0"

      tcp = {
        port_min = "1024"
        port_max = "65535"
      }
    },
    {
      name        = "${var.vpc_name}-webapptier-from-vpn-network"
      direction   = "ingress"
      action      = "allow"
      source      = "${var.onprem_cidr}"
      destination = "${var.address-prefix-vpc}"
    },
    {
      name        = "${var.vpc_name}-webapptier-within-vpc"
      direction   = "ingress"
      action      = "allow"
      source      = "${var.address-prefix-vpc}"
      destination = "${var.address-prefix-vpc}"
    },
    {
      name        = "${var.vpc_name}-webapptier-web-http-traffic"
      direction   = "ingress"
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
      direction   = "egress"
    },
  ]
}

/////////////////////
Edit for transit gateway
////////////////////

resource "ibm_is_network_acl" "vpn_acl" {
  name = "${var.vpc_name}-vpn-acl"

  rules = [
    {
      name        = "${var.vpc_name}-vpn-all-ingress"
      action      = "allow"
      source      = "0.0.0.0/0"
      destination = "0.0.0.0/0"
      direction   = "ingress"
    },
    {
      name        = "${var.vpc_name}-vpn-allow-all-egress"
      action      = "allow"
      source      = "0.0.0.0/0"
      destination = "0.0.0.0/0"
      direction   = "egress"
    },
  ]
}
