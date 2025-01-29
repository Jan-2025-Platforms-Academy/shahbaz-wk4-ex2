# Public Subnets

resource "aws_subnet" "public_subnet_1" {
  vpc_id = aws_vpc.shahbaz_vpc.id
  cidr_block = cidrsubnet(var.vpc_cidr_block, 8, 1)
  availability_zone = var.availability_zones[0]
  map_public_ip_on_launch = true
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id = aws_vpc.shahbaz_vpc.id
  cidr_block = cidrsubnet(var.vpc_cidr_block, 8, 2)
  availability_zone = var.availability_zones[1]
  map_public_ip_on_launch = true
}

resource "aws_subnet" "public_subnet_3" {
  vpc_id = aws_vpc.shahbaz_vpc.id
  cidr_block = cidrsubnet(var.vpc_cidr_block, 8, 3)
  availability_zone = var.availability_zones[0]
  map_public_ip_on_launch = true
}

# Private Subnets

resource "aws_subnet" "private_subnet_1" {
  vpc_id = aws_vpc.shahbaz_vpc.id
  cidr_block = cidrsubnet(var.vpc_cidr_block, 8, 4)
  availability_zone = var.availability_zones[0]
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id = aws_vpc.shahbaz_vpc.id
  cidr_block = cidrsubnet(var.vpc_cidr_block, 8, 5)
  availability_zone = var.availability_zones[0]
}

resource "aws_subnet" "private_subnet_3" {
  vpc_id = aws_vpc.shahbaz_vpc.id
  cidr_block = cidrsubnet(var.vpc_cidr_block, 8, 6)
  availability_zone = var.availability_zones[1]
}

resource "aws_subnet" "private_subnet_4" {
  vpc_id = aws_vpc.shahbaz_vpc.id
  cidr_block = cidrsubnet(var.vpc_cidr_block, 8, 7)
  availability_zone = var.availability_zones[1]
}

#This is meant for multi AZ RDS instance
resource "aws_subnet" "private_subnet_5" {
  vpc_id = aws_vpc.shahbaz_vpc.id
  cidr_block = cidrsubnet(var.vpc_cidr_block, 8, 8)
  availability_zone = var.availability_zones[1]  
}