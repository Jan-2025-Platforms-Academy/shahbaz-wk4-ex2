variable "dev_project_name" {
  description = "The name of the development CodeBuild project"
  type        = string
  default     = "shahbaz-dev-deploy"
}

variable "prod_project_name" {
  description = "The name of the production CodeBuild project"
  type        = string
  default     = "shahbaz-prod-deploy"
}
