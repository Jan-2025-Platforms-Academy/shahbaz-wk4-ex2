
provider "aws" {
  region  = "eu-west-1"
  profile = "AWSAdministratorAccess-841162714039"
}

// Include IAM roles and policies
module "iam_roles" {
  source = "./iam"
}

// Include CodeBuild projects
module "codebuild_dev" {
  source             = "./codebuild_dev"
  codebuild_role_arn = module.iam_roles.codebuild_role_arn
}

module "codebuild_prod" {
  source             = "./codebuild_prod"
  codebuild_role_arn = module.iam_roles.codebuild_role_arn
}

// Include CodePipeline
module "codepipeline" {
  source                = "./codepipeline"
  codepipeline_role_arn = module.iam_roles.codepipeline_role_arn
  dev_project_name      = module.codebuild_dev.dev_project_name
  prod_project_name     = module.codebuild_prod.prod_project_name
}

// S3 bucket for artifacts
resource "aws_s3_bucket" "artifact_bucket" {
  bucket = "shahbaz-eu-west-1-build-artifact"
}

// S3 bucket public access block
resource "aws_s3_bucket_public_access_block" "artifact_bucket_public_access" {
  bucket = aws_s3_bucket.artifact_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
