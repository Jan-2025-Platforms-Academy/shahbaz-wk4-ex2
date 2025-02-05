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
