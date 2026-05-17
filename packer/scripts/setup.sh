#!/bin/bash
set -euxo pipefail

echo "=== EC2 Base AMI Build Starting ==="
echo "Base OS: $(grep PRETTY_NAME /etc/os-release | cut -d= -f2)"

# System update
dnf update -y

# General tools
dnf install -y htop nano git jq unzip

# Web server for SSM port-forwarding demo
dnf install -y httpd
systemctl enable httpd
systemctl start httpd

cat > /var/www/html/index.html << 'HTML'
<h1>Hello from EC2 via SSM Port Forwarding!</h1>
<p>Server: HOSTNAME_PLACEHOLDER</p>
HTML

# Replace placeholder at runtime via a one-shot systemd unit
cat > /etc/systemd/system/update-hostname.service << 'UNIT'
[Unit]
Description=Update index.html with instance hostname
After=network.target

[Service]
Type=oneshot
ExecStart=/bin/bash -c "sed -i \"s/HOSTNAME_PLACEHOLDER/$(hostname)/\" /var/www/html/index.html"
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
UNIT
systemctl enable update-hostname.service

# MariaDB for database port-forwarding demo
# AL2023 ships MariaDB 10.5 as mariadb105-server
dnf install -y mariadb105-server
systemctl enable mariadb
systemctl start mariadb

# Set up demo database (demo credentials — do not use in production)
mysql -e "CREATE DATABASE IF NOT EXISTS testdb;"
mysql -e "CREATE USER IF NOT EXISTS 'testuser'@'localhost' IDENTIFIED BY 'testpass';"
mysql -e "GRANT ALL PRIVILEGES ON testdb.* TO 'testuser'@'localhost';"
mysql -e "FLUSH PRIVILEGES;"

# AWS CLI v2
curl -s "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "/tmp/awscliv2.zip"
unzip -q /tmp/awscliv2.zip -d /tmp/
/tmp/aws/install --update
rm -rf /tmp/awscliv2.zip /tmp/aws

# SSM Agent — install, reload unit files, then enable
dnf install -y amazon-ssm-agent
systemctl daemon-reload
systemctl enable amazon-ssm-agent
systemctl start amazon-ssm-agent

# Verify
echo "=== Verifying installations ==="
aws --version
httpd -v
mysql --version

echo "=== EC2 Base AMI Build Complete ==="
