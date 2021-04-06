resource "aws_s3_bucket" "s3-checkpoints-bucket" {
  bucket = "cmp-suraj"
  #region = "eu-west-1"
  versioning {
    enabled = true
  }
  lifecycle {
    prevent_destroy = true
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

provider "aws" {
  version = ">= 2.57"
  region  = "eu-west-1"
  profile = "maf-sandbox"
}

terraform {
  required_version = "= 0.12.9"
  backend "s3" {
    bucket         = "grid2.0-terraform-state"
    key            = "cmp/env-setup.tfstate"
    dynamodb_table = "s3-state-lock"
    region         = "eu-west-1"
    profile        = "maf-cdl-cicd"
  }
}
