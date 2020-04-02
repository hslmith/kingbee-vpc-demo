data "template_cloudinit_config" "cloud-init-web" {
  base64_encode = false
  gzip          = false

  part {
    content = <<EOF
#cloud-config

runcmd:
- yum install -y httpd
- echo "<html><head><title>Deplyed by Terraform - How will selling VPC help you?</title></head><body><h1>Because...<p><img src='http://www.quickmeme.com/img/fa/fab021a8b7f181cf8543abd455227b03344c5de74cb991b4864d1643177429f9.jpg' alt='awesomecorgi'></h1></body></html>" > /var/www/html/index.html
- httpd -k start

 EOF
  }
}


