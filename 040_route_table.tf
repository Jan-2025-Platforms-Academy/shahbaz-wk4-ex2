# Purpose: Create route tables for public and private subnets and associate them with the respective subnets.
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.shahbaz_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }
  tags = {
    Name = "shahbaz-public-route-table-${var.environment}"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.shahbaz_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.this.id
  }

  tags = {
    Name = "shahbaz-private-route-table-${var.environment}"
  }
}
# Public Association
resource "aws_route_table_association" "public_a" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public.id
}
resource "aws_route_table_association" "public_b" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public.id
}

# Private association
resource "aws_route_table_association" "private_a" {
  count          = 2
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.private.id
}
resource "aws_route_table_association" "private_b" {
  count          = 2
  subnet_id      = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.private.id
}
resource "aws_route_table_association" "private_c" {
  count          = 2
  subnet_id      = aws_subnet.private_subnet_3.id
  route_table_id = aws_route_table.private.id
}
resource "aws_route_table_association" "private_d" {
  count          = 2
  subnet_id      = aws_subnet.private_subnet_4.id
  route_table_id = aws_route_table.private.id
}
resource "aws_route_table_association" "private_e" {
  count          = 2
  subnet_id      = aws_subnet.private_subnet_5.id
  route_table_id = aws_route_table.private.id
}
