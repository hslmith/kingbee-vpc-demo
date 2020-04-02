#################################################
# Define Cloud-init scripts to run on provisioning
#################################################

data "local_file" "cloud-config-web-left" {
  filename        = "web-left.txt"
}

data "local_file" "cloud-config-web-right" {
  filename        = "web-right.txt"
}



data "template_cloudinit_config" "cloud-init-db-master" {
  gzip            = false
  base64_encode   = false

      filename      = "init.cfg"
    content_type  = "text/cloud-config"
    content       = "${data.local_file.cloud-config-db-txt.content}"
  }

  }
}