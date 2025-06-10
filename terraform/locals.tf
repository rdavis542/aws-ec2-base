locals {
  user_data = base64encode(<<-EOF
    #!/bin/bash
    yum update -y
    
    # Install SSM Agent (usually pre-installed on Amazon Linux 2)
    yum install -y amazon-ssm-agent
    systemctl enable amazon-ssm-agent
    systemctl start amazon-ssm-agent
    
    # Install sample web server for port forwarding demo
    yum install -y httpd
    systemctl enable httpd
    systemctl start httpd
    
    # Create a simple test page
    echo "<h1>Hello from EC2 via SSM Port Forwarding!</h1>" > /var/www/html/index.html
    echo "<p>Server: $(hostname)</p>" >> /var/www/html/index.html
    echo "<p>Date: $(date)</p>" >> /var/www/html/index.html
    
    # Install MySQL for database port forwarding example
    yum install -y mariadb-server
    systemctl enable mariadb
    systemctl start mariadb
    
    # Set up a test database
    mysql -e "CREATE DATABASE testdb;"
    mysql -e "CREATE USER 'testuser'@'localhost' IDENTIFIED BY 'testpass';"
    mysql -e "GRANT ALL PRIVILEGES ON testdb.* TO 'testuser'@'localhost';"
    mysql -e "FLUSH PRIVILEGES;"
    
    # Install some additional useful tools
    yum install -y htop nano git
    EOF
  )
}