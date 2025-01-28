terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.84.0"
    }
  }

  backend "s3" {
    bucket = "s3-shahbaz-tf-state"
    key    = "shahbaz/terraform/state"
    region = "eu-west-2"
    profile = "AWSAdministratorAccess-841162714039"

  }
}

provider "aws" {
  region = var.region
  profile = "AWSAdministratorAccess-841162714039"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = var.bucket_name

  tags = {
    Environment = var.environment
    Owner = var.owner
  }
}

resource "aws_s3_bucket_versioning" "terraform_state_versioning" {
  bucket = aws_s3_bucket.terraform_state.bucket

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "terraform_state_lifecycle" {
  bucket = aws_s3_bucket.terraform_state.bucket

  rule {
    id = "${var.owner}_lifecycle_rule_1"
    status = "Enabled"

    transition {
      days = 30
      storage_class = "STANDARD_IA"
    }    
    expiration {
      days = 30
    }
  }

}

resource "aws_vpc" "shahbaz_vpc" {
  cidr_block = var.vpc_cidr_block
}

resource "aws_subnet" "$${var.owner}_public_1_$${var.availability_zones[0]}" {
  vpc_id = aws_vpc.shahbaz_vpc.id
  cidr_block = cidrsubnet(var.vpc_cidr_block, 8, 1)
  availability_zone = var.availability_zones[0]
  map_public_ip_on_launch = true
}

resource "aws_subnet" "$${var.owner}_public_2_$${var.availability_zones[1]}" {
  vpc_id = aws_vpc.shahbaz_vpc.id
  cidr_block = cidrsubnet(var.vpc_cidr_block, 8, 2)
  availability_zone = var.availability_zones[1]
  map_public_ip_on_launch = true
}

resource "aws_subnet" "$${var.owner}_private_1_$${var.availability_zones[0]}" {
  vpc_id = aws_vpc.shahbaz_vpc.id
  cidr_block = cidrsubnet(var.vpc_cidr_block, 8, 3)
  availability_zone = var.availability_zones[0]
}

resource "aws_subnet" "$${var.owner}_private_2_$${var.availability_zones[0]}" {
  vpc_id = aws_vpc.shahbaz_vpc.id
  cidr_block = cidrsubnet(var.vpc_cidr_block, 8, 4)
  availability_zone = var.availability_zones[0]
}

resource "aws_subnet" "$${var.owner}_private_3_$${var.availability_zones[1]}" {
  vpc_id = aws_vpc.shahbaz_vpc.id
  cidr_block = cidrsubnet(var.vpc_cidr_block, 8, 5)
  availability_zone = var.availability_zones[1]
}

resource "aws_subnet" "$${var.owner}_private_4_$${var.availability_zones[1]}" {
  vpc_id = aws_vpc.shahbaz_vpc.id
  cidr_block = cidrsubnet(var.vpc_cidr_block, 8, 6)
  availability_zone = var.availability_zones[1]
}

resource "aws_internet_gateway" "shahbaz_igw" {
  vpc_id = aws_vpc.shahbaz_vpc.id
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.shahbaz_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.shahbaz_igw.id
  }
}



                                                                 