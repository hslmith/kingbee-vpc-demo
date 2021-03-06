///Dual Zone vpc demo


////////////////
//SSH Key 
////////////////

data "ibm_is_ssh_key" "sshkey1" {
  name = "${var.ssh_key_name}"
}


////////////////
//Create VPC
///////////////

data "ibm_resource_group" "resource" {
  name = "${var.resource_group}"
}

resource "ibm_is_vpc" "vpc1" {
  name = "${var.vpc_name}"
  address_prefix_management = "manual"
  resource_group = "${data.ibm_resource_group.resource.id}"
}

////////////////
//Create VPC CIDR and Zone Prefixes
///////////////




//--- security group creation for web tier


resource "ibm_is_security_group" "public_facing_sg" {
  name = "${var.vpc_name}-public-facing-sg"
  vpc  = "${ibm_is_vpc.vpc1.id}"
  resource_group ="${data.ibm_resource_group.resource.id}"
}

resource "ibm_is_security_group_rule" "public_facing_tcp22" {
    group = "${ibm_is_security_group.public_facing_sg.id}"
    direction = "inbound"
    remote = "0.0.0.0/0"
    tcp = {
      port_min = "22"
      port_max = "22"
    }
}

resource "ibm_is_security_group_rule" "public_facing_sg_tcp80" {
    group = "${ibm_is_security_group.public_facing_sg.id}"
    direction = "inbound"
    remote = "0.0.0.0/0"
    tcp = {
      port_min = "80"
      port_max = "80"
    }
}

resource "ibm_is_security_group_rule" "public_facing_icmp" {
    group = "${ibm_is_security_group.public_facing_sg.id}"
    direction = "inbound"
    remote = "0.0.0.0/0"
    icmp = {
      code = "0"
      type = "8"
    }
}

resource "ibm_is_security_group_rule" "public_facing_egress" {
    group = "${ibm_is_security_group.public_facing_sg.id}"
    direction = "outbound"
    remote = "0.0.0.0/0"
}





///////////////////////////////////////
// Public Gateway's for Zone 1 & Zone 2
////////////////////////////////////////


resource "ibm_is_public_gateway" "pubgw-zone1" {
  name = "${var.vpc_name}-${var.zone1}-pubgw"
  vpc  = "${ibm_is_vpc.vpc1.id}"
  zone = "${var.zone1}"
  resource_group ="${data.ibm_resource_group.resource.id}"
}

resource "ibm_is_public_gateway" "pubgw-zone2" {
  name = "${var.vpc_name}-${var.zone2}-pubgw"
  vpc  = "${ibm_is_vpc.vpc1.id}"
  zone = "${var.zone2}"
  resource_group = "${data.ibm_resource_group.resource.id}"
}


/////////////////////
//   ZONE 1 (LEFT)
/////////////////////

//--- address prexix for VPC

resource "ibm_is_vpc_address_prefix" "prefix_z1" {
  name = "vpc-zone1-cidr"
  zone = "${var.zone1}"
  vpc  = "${ibm_is_vpc.vpc1.id}"
  cidr = "${var.zone1_prefix}"
}

//--- subnets 

resource "ibm_is_subnet" "websubnet1" {
  name            = "web-subnet-zone1"
  vpc             = "${ibm_is_vpc.vpc1.id}"
  zone            = "${var.zone1}"
  network_acl     = "${ibm_is_network_acl.isWebServerACL.id}"
  public_gateway  = "${ibm_is_public_gateway.pubgw-zone1.id}"
  ipv4_cidr_block = "${var.web_subnet_zone1}"
  depends_on      = ["ibm_is_vpc_address_prefix.prefix_z1"]

  provisioner "local-exec" {
    command = "sleep 300"
    when    = "destroy"
  }
}


//--- Web Server(s)

resource "ibm_is_instance" "web-instancez01" {
  count   = "${var.web_server_count}"
  name    = "web-kb01-${count.index+1}"
  image   = "${var.image}"
  profile = "${var.profile}"

  primary_network_interface = {
    subnet = "${ibm_is_subnet.websubnet1.id}"
    security_groups = ["${ibm_is_security_group.public_facing_sg.id}"]
  }
  vpc  = "${ibm_is_vpc.vpc1.id}"
  zone = "${var.zone1}"
  keys = ["${data.ibm_is_ssh_key.sshkey1.id}"]
  resource_group = "${data.ibm_resource_group.resource.id}"
  //user_data = "${data.template_cloudinit_config.cloud-init-web.rendered}"
  user_data = "${data.local_file.cloud-config-web-left-txt.content}"
}


/////////////////////
//   ZONE 2 (RIGHT)
/////////////////////

//--- address prexix for VPC

resource "ibm_is_vpc_address_prefix" "prefix_z2" {
  name = "vpc-zone2-cidr"
  zone = "${var.zone2}"
  vpc  = "${ibm_is_vpc.vpc1.id}"
  cidr = "${var.zone2_prefix}"
}

//--- subnets 

resource "ibm_is_subnet" "websubnet2" {
  name            = "web-subnet-zone2"
  vpc             = "${ibm_is_vpc.vpc1.id}"
  zone            = "${var.zone2}"
  network_acl     = "${ibm_is_network_acl.isWebServerACL.id}"
  public_gateway  = "${ibm_is_public_gateway.pubgw-zone2.id}"
  ipv4_cidr_block = "${var.web_subnet_zone2}"
  depends_on      = ["ibm_is_vpc_address_prefix.prefix_z2"]

  provisioner "local-exec" {
    command = "sleep 300"
    when    = "destroy"
  }
}



//--- Web Server(s)

resource "ibm_is_instance" "web-instancez02" {
  count   = "${var.web_server_count}"
  name    = "web-kb02-${count.index+1}"
  image   = "${var.image}"
  profile = "${var.profile}"

  primary_network_interface = {
    subnet = "${ibm_is_subnet.websubnet2.id}"
    security_groups = ["${ibm_is_security_group.public_facing_sg.id}"]
  }
  vpc  = "${ibm_is_vpc.vpc1.id}"
  zone = "${var.zone2}"
  keys = ["${data.ibm_is_ssh_key.sshkey1.id}"]
  resource_group = "${data.ibm_resource_group.resource.id}"
  //user_data = "${data.template_cloudinit_config.cloud-init-web.rendered}"
  user_data = "${data.local_file.cloud-config-web-right-txt.content}"
  //user_data = file("${path.module}/web_a.cfg")
}

