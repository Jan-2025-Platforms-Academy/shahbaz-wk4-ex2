variable "environment" {
  description = "This is the value for the env"
  type = string
}

variable "vpc_cidr_block" {
  description = "VPC's cidr block"
  type = string
}

variable "vpc_name" {
    description = "The name of the VPC"
    type = string
}

variable "region" {
  description = "The AWS region"
  type        = string
  default     = "eu-west-1"
}

variable "owner" {
  description = "Owner/Team name of the resource"
  type        = string
  default     = "shahbaz"
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["eu-west-1a", "eu-west-1b"]
}

variable "key_name" {
  description = "Name of the SSH key pair"
  type        = string
}
