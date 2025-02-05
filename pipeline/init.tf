
provider "aws" {
  region = "eu-west-1"
}

// Include IAM roles and policies
module "iam_roles" {
  source = "./10_iam.tf"
}

// Include CodeBuild projects
module "codebuild_dev" {
  source = "./20_codebuild_dev.tf"
}

module "codebuild_prod" {
  source = "./30_codebuild_prod.tf"
}

// Include CodePipeline
module "codepipeline" {
  source = "./40_codepipeline.tf"
}

// S3 bucket for artifacts
resource "aws_s3_bucket" "artifact_bucket" {
  bucket = "shahbaz-eu-west-1-build-artifact"
}

// S3 bucket ACL
resource "aws_s3_bucket_acl" "artifact_bucket_acl" {
  bucket = aws_s3_bucket.artifact_bucket.id
  acl    = "private"
}

// S3 bucket public access block
resource "aws_s3_bucket_public_access_block" "artifact_bucket_public_access" {
  bucket = aws_s3_bucket.artifact_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
