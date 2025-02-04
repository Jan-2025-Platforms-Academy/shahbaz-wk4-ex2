resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.shahbaz_vpc.id

  tags = {
    Name = "shahbaz-igw-${var.environment}"
  }

}
