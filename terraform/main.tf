terraform {
  # ############################################################
  # # AFTER RUNNING TERRAFORM APPLY (WITH LOCAL BACKEND)
  # # YOU WILL UNCOMMENT THIS CODE THEN RERUN TERRAFORM INIT
  # # TO SWITCH FROM LOCAL BACKEND TO REMOTE AWS BACKEND
  # ############################################################

  #BACKEND---------------------------------------------------
  # backend "s3" {
  #   bucket         = "gd-terraform-backend-13412"
  #   key            = "terraform.tfstate"
  #   region         = "eu-central-1"
  #   dynamodb_table = "terraform-state-locking"
  #   encrypt        = true
  # }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}
provider "aws" {
  region = var.region
}
