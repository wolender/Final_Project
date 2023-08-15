terraform {
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

module "networking" {
  source = "networking"
}
module "compute"{
  source = "compute"
}