resource "aws_eip" "this" {}

resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.this.id
  subnet_id     = aws_subnet.public_subnet_1.id

  tags = {
    Name = "shahbaz-nat-gateway-${var.environment}"
  }
}
