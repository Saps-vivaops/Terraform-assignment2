provider "aws" {
  region = "ap-south-1"
}

# Define a map of configurations for each environment
locals {
  env_config = {
    dev  = { instance_type = "t2.micro", bucket_name = "vivaopsTerraform2-dev-bucket" }
    qa   = { instance_type = "t2.small", bucket_name = "vivaopsTerraform2-qa-bucket" }
    prod = { instance_type = "t2.medium", bucket_name = "vivaopsTerraform2-prod-bucket" }
  }
}

# Get the current workspace
data "terraform_remote_state" "current" {
  backend = "local"
  config = {
    path = "terraform.tfstate"
  }
}

# Use the current workspace to select the configuration
locals {
  current_config = local.env_config[terraform.workspace]
}

resource "aws_s3_bucket" "vivaopsTerraform2_bucket" {
  bucket = local.current_config.bucket_name
}

resource "aws_instance" "vivaopsTerraform2_instance" {
  ami           = "ami-08718895af4dfa033" # Example AMI ID
  instance_type = local.current_config.instance_type
}

output "bucket_name" {
  value = aws_s3_bucket.vivaopsTerraform2_bucket.bucket
}

output "instance_id" {
  value = aws_instance.vivaopsTerraform2_instance.id
}
