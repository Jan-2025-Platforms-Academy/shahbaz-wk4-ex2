terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.84.0"
    }
  }

  backend "s3" {
    bucket  = "s3-shahbaz-tf-state-1"
    key     = "shahbaz/terraform/state/${"var.environment"}"
    region  = "eu-west-1"
    profile = "AWSAdministratorAccess-841162714039"

  }
}

provider "aws" {
  region  = var.region
  profile = "AWSAdministratorAccess-841162714039"
}

                                               