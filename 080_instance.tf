resource "aws_instance" "web" {
    count = 4
    ami = "ami-0aa9ffd4190a83e11"
    instance_type = "t2-micro"
    subnet_id = element([aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_3.id], count.index)

    user_data = <<-EOF

    EOF

    tags = {
      Name = "Webserver-${count.index}"
    }

    security_groups = [ aws_security_group.web-sg.id ]
  
}