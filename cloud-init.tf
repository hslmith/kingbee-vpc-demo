#################################################
# Define Cloud-init scripts to run on provisioning
#################################################

data "local_file" "cloud-config-web-left" {
  filename        = "web-left.txt"
}

data "local_file" "cloud-config-web-right" {
  filename        = "web-right.txt"
}
