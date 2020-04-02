data "template_cloudinit_config" "cloud-init-web-a" {
  base64_encode = false
  gzip          = false

  part {
    content = <<EOF
#cloud-config

runcmd:
- yum install -y httpd
- echo "<html><head><title>How will selling VPC help you?</title></head><body><h1>Because...<p><img src='http://www.quickmeme.com/img/fa/fab021a8b7f181cf8543abd455227b03344c5de74cb991b4864d1643177429f9.jpg' alt='awesomecorgi'></h1></body></html>" > /var/www/html/index.html
- httpd -k start

 EOF
  }
}


data "template_cloudinit_config" "cloud-init-web-b" {
  base64_encode = false
  gzip          = false

  part {
    content = <<EOF
#cloud-config

runcmd:
- yum install -y httpd
- echo "<html><head><title>How will selling VPC help you?</title></head><body><h1>Because...<p><img src='http://www.quickmeme.com/img/92/92b5b07b0511b84519ce3c63ed880a5f043d6735e4e8e8a0841ecd6e22599ac1.jpg' alt=‘noawesomebeagle’></h1></body></html>" > /var/www/html/index.html
- httpd -k start

 EOF
  }
}