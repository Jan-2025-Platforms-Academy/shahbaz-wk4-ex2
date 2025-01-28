terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.84.0"
    }
  }

  backend "s3" {}
}

provider "aws" {
  region = var.region
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
