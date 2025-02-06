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


// S3 bucket for artifacts
resource "aws_s3_bucket" "artifact_bucket" {
  bucket = "shahbaz-eu-west-1-build-artifact"

  lifecycle {
    prevent_destroy = true
  }
}

// S3 bucket public access block
resource "aws_s3_bucket_public_access_block" "artifact_bucket_public_access" {
  bucket = aws_s3_bucket.artifact_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}


data "aws_secretsmanager_secret_version" "github_shahbaz" {
  secret_id = "github_shahbaz"
}

locals {
  github_secrets = jsondecode(data.aws_secretsmanager_secret_version.github_shahbaz.secret_string)
}

module "dev_codepipeline" {
  source = "./codepipeline"

  codepipeline_role_arn = module.iam_roles.codepipeline_role_arn
  dev_project_name      = var.dev_project_name
  prod_project_name     = var.prod_project_name
  artifact_bucket_name  = "shahbaz-eu-west-1-build-artifact"
  github_owner          = local.github_secrets.github_owner
  github_repo           = local.github_secrets.RepositoryName
  github_branch         = local.github_secrets.BranchName
  github_token          = local.github_secrets.OAuthToken
}
module "prod_codepipeline" {
  source = "./codepipeline"

  codepipeline_role_arn = module.iam_roles.codepipeline_role_arn
  dev_project_name      = var.dev_project_name
  prod_project_name     = var.prod_project_name
  artifact_bucket_name  = "shahbaz-eu-west-1-build-artifact"
  github_owner          = local.github_secrets.github_owner
  github_repo           = local.github_secrets.RepositoryName
  github_branch         = local.github_secrets.BranchName
  github_token          = local.github_secrets.OAuthToken
}
