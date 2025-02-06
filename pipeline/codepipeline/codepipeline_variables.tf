variable "codepipeline_role_arn" {
  description = "The ARN of the IAM role for CodeBuild"
  type        = string
}

variable "dev_project_name" {
  description = "The name of the development CodeBuild project"
  type        = string
}

variable "prod_project_name" {
  description = "The name of the production CodeBuild project"
  type        = string
}

variable "artifact_bucket_name" {
  description = "The name of the S3 bucket for artifacts"
  type        = string
  
}
variable "github_owner" {
  description = "The owner of the GitHub repository"
  type        = string
  
}
variable "github_repo" {
  description = "The name of the GitHub repository"
  type        = string
  
}
variable "github_branch" {
  description = "The branch of the GitHub repository"
  type        = string
  
}
variable "github_token" {
  description = "The OAuth token for GitHub"
  type        = string
  
}
