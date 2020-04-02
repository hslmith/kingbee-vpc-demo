#################################################
# Define Cloud-init scripts to run on provisioning
#################################################

data "local_file" "cloud-config-web-left-txt" {
  filename        = "web-left.txt"
}

data "local_file" "cloud-config-web-right-txt" {
  filename        = "web-right.txt"
}



data "template_cloudinit_config" "cloud-init-left" {
  gzip            = false
  base64_encode   = false

    filename      = "init.cfg"
    content_type  = "text/cloud-config"
    content       = "${data.local_file.cloud-config-web-left-txt.content}"
  }

  }
}

data "template_cloudinit_config" "cloud-init-right" {
  gzip            = false
  base64_encode   = false

    filename      = "init.cfg"
    content_type  = "text/cloud-config"
    content       = "${data.local_file.cloud-config-web-right-txt.content}"
  }

  }
}