resource "aws_instance" "web" {
    count = 4
    ami = "ami-0aa9ffd4190a83e11"
    instance_type = "t2-micro"
    subnet_id = element([aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_3.id], count.index)
    key_name = var.key_name
    user_data = <<-EOF
        #!/bin/bash
        yum update -y
        yum install -y httpd git php 
        systemctl start httpd
        systemctl enable httpd
        chmod -R 755 /var/www
        git clone https://github.com/rearviewmirror/platform_academy.git /tmp/platform_academy
        cp /tmp/platform_academy/index.php /var/www/html/index.php
        
        echo "<?php echo 'Instance: ' . getenv('INSTANCE_NAME') . ' - AZ: ' . getenv('AVAILABILITY_ZONE'); ?>" | cat - /var/www/html/index.php > temp && mv temp /var/www/html/index.php
        echo "DB_SERVER=${aws_db_instance.this.endpoint}" >> /etc/environment

        echo "DB_USERNAME=admin" >> /etc/environment
        echo "DB_PASSWORD=1Password1" >> /etc/environment
        echo "DB_DATABASE=sample" >> /etc/environment

        echo "INSTANCE_NAME=$(curl http://169.254.169.254/latest/meta-data/instance-id)" >> /etc/environment
        echo "AVAILABILITY_ZONE=$(curl http://169.254.169.254/latest/meta-data/placement/availability-zone)" >> /etc/environment
        source /etc/environment
    EOF

    tags = {
      Name = "Webserver-${count.index}"
    }

    security_groups = [ aws_security_group.web-sg.id ]
    depends_on = [aws_db_instance.this]
}