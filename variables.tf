////////////////
//Define Zones
////////////////


variable "ibmcloud_region" {
  description = "Preferred IBM Cloud region to use for your infrastructure"
  default = "us-south"
}

variable "zone1" {
  default = "us-south-1"
  description = "Define the 1st zone of the region"
}

variable "zone2" {
  default = "us-south-3"
  description = "Define the 2nd zone of the region"
}


////////////////
//Define VPC
////////////////

variable "vpc_name" {
  default = "kingbee-vpc-demo-two"
  description = "Name of your VPC"
}


variable "resource_group" {
  default = "kingbee-iaas-demo"
}


////////////////
// Define CIDR
////////////////


variable "address-prefix-vpc" {
  default = "172.31.0.0/20"
}

variable "zone1_prefix" {
  default = "172.31.0.0/21"
  description = "CIDR block to be used for zone 1"
}

variable "zone2_prefix" {
  default = "172.31.8.0/21"
  description = "CIDR block to be used for zone 2"
}


////////////////////////////////
// Define Subnets for zones
////////////////////////////////

variable "web_subnet_zone1" {
  default = "172.31.0.0/24"
}

variable "web_subnet_zone2" {
  default = "172.31.8.0/24"
}




////////////////////////////////




variable "ssh_key_name" {
  default = "default"
  description = "Name of existing VPC SSH Key"
}

variable "web_server_count" {
  default = 1
}


variable "image" {
  // CENT7
  //default = "r006-e0039ab2-fcc8-11e9-8a36-6ffb6501dd33"
  default = "r006-14140f94-fcc4-11e9-96e7-a72723715315"
  description = "OS Image ID to be used for virtual instances"
}

variable "profile" {
  default = "cx2-2x4"
  description = "Instance profile to be used for virtual instances"
}


// LBaaS Define


variable "webtier-lb-connections" {
  default = 2000
}

variable "webtier-lb-algorithm" {
  default = "round_robin"
}
