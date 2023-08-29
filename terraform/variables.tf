
# General Variables
variable "access_ip" {
  description = "ip that can access the aplication"
  type        = string
  default     = "0.0.0.0/0"
}
variable "region" {
  description = "Default region for provider"
  type        = string
  default     = "eu-central-1"
}
#must be part of region above
variable "az1" {
  description = "Avalabbiliity zone one for the application"
  type        = string
  default     = "eu-central-1a"
}
#must be part of region above
variable "az2" {
  description = "Availability zone two for the application"
  type        = string
  default     = "eu-central-1b"
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
# EC2 Variables

variable "ami" {
  description = "Amazon machine image to use for ec2 instance"
  type        = string
  default     = "ami-0dc7fe3dd38437495" # amazon machine eu-central
}

variable "aws_key" {
  description = "Amazon machine image to use for ec2 instance"
  type        = string
  default     = "wolender_key"
}

variable "instance_type" {
  description = "ec2 instance type"
  type        = string
  default     = "t2.small"
}

variable "SQ_instance_type" {
  description = "ec2 instance type"
  type        = string
  default     = "t2.medium"
}

variable "MySQL_passwword" {
  description = "password for database"
  type        = string
  default     = "petclinic-password"
}
variable "MySQL_login" {
  description = "login for database"
  type        = string
  default     = "admin"
}
variable "MuSQL_name" {
  description = "database name"
  type        = string
  default     = "petclinic"
}


