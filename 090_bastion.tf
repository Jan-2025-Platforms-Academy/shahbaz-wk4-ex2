resource "aws_instance" "bastion" {
  ami                         = "ami-0aa9ffd4190a83e11"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public_subnet_1.id
  associate_public_ip_address = true
  key_name                    = var.key_name

  tags = {
    Name = "shahbaz-astion"
  }
  security_groups = [aws_security_group.bastion-sg.id]

}

resource "aws_eip" "bastion_eip" {
  domain     = "vpc"
  instance   = aws_instance.bastion.id
  depends_on = [aws_internet_gateway.this]
}
