resource "aws_instance" "web" {
  count = 2
  # London 
  # ami             = "ami-0c55b159cbfafe1f0"
  # Ireland 
  ami             = "ami-05edf2d87fdbd91c1"
  instance_type   = "t2.micro"
  key_name        = var.key_name
  security_groups = [aws_security_group.web-sg.id]
  subnet_id       = element([aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id], count.index)
  tags = {
    Name = "shahbaz-web-${count.index}-${var.environment}"
  }
  user_data  = <<-EOF
        #!/bin/bash
        yum update -y
        yum install -y httpd git php php-mysqli mariadb105
        systemctl start httpd
        systemctl enable httpd
        chmod -R 755 /var/www

        echo "DB_SERVER=${aws_db_instance.this.address}" >> /etc/environment
        echo "DB_USERNAME=admin" >> /etc/environment
        echo "DB_PASSWORD=1Password1" >> /etc/environment
        echo "DB_DATABASE=sample" >> /etc/environment
        
        source /etc/environment
        
        git clone https://github.com/rearviewmirror/platform_academy.git /tmp/platform_academy
        cp /tmp/platform_academy/db_connect.inc /var/www/html/db_connect.inc
        cp /tmp/platform_academy/index.php /var/www/html/index.php
    EOF
  depends_on = [aws_db_instance.this]
}