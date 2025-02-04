
resource "aws_vpc" "shahbaz_vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = "shahbaz-vpc-${var.environment}"
    description = "This is for week 4 exercise vpc-${var.environment}"
  }
}
