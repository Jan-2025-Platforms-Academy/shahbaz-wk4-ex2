resource "aws_eip" "this" {
  count = 2
}

resource "aws_nat_gateway" "this" {
  count         = 2
  allocation_id = aws_eip.this[count.index].id
  subnet_id     = element([aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id], count.index)

  tags = {
    Name = "shahbaz-nat-gateway-${count.index + 1}-${var.environment}"
  }
}

resource "aws_route" "private_subnet_route_to_natgw" {
  count                  = 2
  route_table_id         = aws_route_table.private[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.this[count.index].id
}
