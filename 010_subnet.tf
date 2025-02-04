# Below 2 Public subnet for ALB 
resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.shahbaz_vpc.id
  cidr_block              = cidrsubnet(var.vpc_cidr_block, 8, 1)
  availability_zone       = var.availability_zones[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "shahbaz-public-subnet-1-ALB-${var.environment}"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.shahbaz_vpc.id
  cidr_block              = cidrsubnet(var.vpc_cidr_block, 8, 2)
  availability_zone       = var.availability_zones[1]
  map_public_ip_on_launch = true

  tags = {
    Name = "shahbaz-public-subnet-2-ALB-${var.environment}"
  }

}


# Below 2 Private subnet for EC2 instances
resource "aws_subnet" "private_subnet_1" {
  vpc_id            = aws_vpc.shahbaz_vpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr_block, 8, 3)
  availability_zone = var.availability_zones[0]

  tags = {
    Name = "shahbaz-private-subnet-1-EC2-${var.environment}"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id            = aws_vpc.shahbaz_vpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr_block, 8, 4)
  availability_zone = var.availability_zones[1]

  tags = {
    Name = "shahbaz-private-subnet-2-EC2-${var.environment}"
  }
}

# Below 3 Private subnet for RDS instances
resource "aws_subnet" "private_subnet_3" {
  vpc_id            = aws_vpc.shahbaz_vpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr_block, 8, 5)
  availability_zone = var.availability_zones[0]

  tags = {
    Name = "shahbaz-private-subnet-3-RDS-${var.environment}"
  }
}

resource "aws_subnet" "private_subnet_4" {
  vpc_id            = aws_vpc.shahbaz_vpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr_block, 8, 6)
  availability_zone = var.availability_zones[1]

  tags = {
    Name = "shahbaz-private-subnet-4-RDS-${var.environment}"
  }
}

resource "aws_subnet" "private_subnet_5" {
  vpc_id            = aws_vpc.shahbaz_vpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr_block, 8, 7)
  availability_zone = var.availability_zones[0]

  tags = {
    Name = "shahbaz-private-subnet-5-RDS-${var.environment}"
  }
}
