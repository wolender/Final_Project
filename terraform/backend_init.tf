terraform {
  # ############################################################
  # # AFTER RUNNING TERRAFORM APPLY (WITH LOCAL BACKEND)
  # # YOU WILL UNCOMMENT THIS CODE THEN RERUN TERRAFORM INIT
  # # TO SWITCH FROM LOCAL BACKEND TO REMOTE AWS BACKEND
  # ############################################################

  #BACKEND---------------------------------------------------
  # backend "s3" {
  #   bucket         = "terraform-backend-13412"
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

resource "aws_s3_bucket" "terraform_state" {
  bucket        = var.bucket_name
  force_destroy = true
    tags = {
        Name = "Terraform-backend"
        Owner = var.owner
        Project = var.project
    }
}

resource "aws_s3_bucket_versioning" "terraform_bucket_versioning" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }

}

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state_crypto_conf" {
  bucket        = aws_s3_bucket.terraform_state.bucket 
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = "terraform-state-locking"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
    tags = {
        Name = "Terraform-lock"
        Owner = var.owner
        Project = var.project
    }
}