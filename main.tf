terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.84.0"
    }
  }

  backend "s3" {
    bucket  = "s3-shahbaz-tf-state"
    key     = "shahbaz/terraform/state"
    region  = "eu-west-2"
    profile = "AWSAdministratorAccess-841162714039"

  }
}

provider "aws" {
  region  = var.region
  profile = "AWSAdministratorAccess-841162714039"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = var.bucket_name

  tags = {
    Environment = var.environment
    Owner       = var.owner
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
    id     = "shahbaz_lifecycle_rule_1"
    status = "Enabled"

    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }
    expiration {
      days = 30
    }
  }

}
                                               