# Purpose: Create route tables for public and private subnets and associate them with the respective subnets.
resource "aws_route_table" "public" {
    vpc_id = aws_vpc.shahbaz_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }
}

resource "aws_route_table" "private" {
    vpc_id = aws_vpc.shahbaz_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.this.id
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
    subnet_id      = aws_subnet.private_subnet_1.id
    route_table_id = aws_route_table.private.id
}
resource "aws_route_table_association" "private_b" {
    subnet_id      = aws_subnet.private_subnet_2.id
    route_table_id = aws_route_table.private.id
}
resource "aws_route_table_association" "private_c" {
    subnet_id      = aws_subnet.private_subnet_3.id
    route_table_id = aws_route_table.private.id
}
resource "aws_route_table_association" "private_d" {
    subnet_id      = aws_subnet.private_subnet_4.id
    route_table_id = aws_route_table.private.id
}
resource "aws_route_table_association" "private_e" {
    subnet_id      = aws_subnet.private_subnet_5.id
    route_table_id = aws_route_table.private.id
}
