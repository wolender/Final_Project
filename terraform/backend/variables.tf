#backend variables
variable "region" {
  description = "Default region for provider"
  type        = string
  default     = "eu-central-1"
}
variable "bucket_name" {
  description = "s3 bucket name"
  type        = string
  default     = "gd-terraform-backend-13412"
}
variable "dynamoDB_name" {
  description = "name of dynamodb table for state lock"
  type = string
  default = "terraform-state-locking"
}

#Tags
variable "owner" {
  description = "Owner tag"
  type        = string
  default     = "wolender"
}

variable "project" {
  description = "Project name tag"
  type        = string
  default     = "2023_internship_warsaw"
}
