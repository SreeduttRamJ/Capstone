#!/bin/bash

set -e

yum -y update

yum -y install httpd

systemctl enable --now httpd

cat >/var/www/html/index.html <<'HTML'

<!doctype html>

<html>

  <head><meta charset="utf-8"><title>Project-1 Terraform EC2 Web Server</title></head>

  <body style="font-family: Arial; margin: 3rem;">

    <h1>✅ Terraform EC2 Web Server Working!</h1>

    <p>This page was provisioned automatically via user_data on Amazon Linux 2023.</p>

  </body>

</html>

HTML

``
