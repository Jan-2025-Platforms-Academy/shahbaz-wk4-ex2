variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "region" {
  description = "The AWS region"
  type        = string
  default     = "eu-west-2"
}

variable "environment" {
  description = "This the env for the resource"
  type = string
  default = "dev-shahbaz"
}

variable "owner" {
  description = "Owner/Team name of the resource"
  type = string
  default = "shahbaz"
}
