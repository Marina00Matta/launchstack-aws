# ============================================================================
# Example: Deploy a simple web app with LaunchStack
# ============================================================================
# This example deploys an nginx container to show the full setup working.
# Replace the image with your own Docker image to deploy your app.
#
# Usage:
#   cd examples/simple-web-app
#   cp terraform.tfvars.example terraform.tfvars
#   terraform init
#   terraform apply
#
# After apply, the ALB URL will be printed. Visit it to see nginx running.
# ============================================================================

terraform {
  required_version = ">= 1.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = {
      Project     = "launchstack-example"
      Environment = "dev"
      ManagedBy   = "terraform"
    }
  }
}

module "networking" {
  source = "../../modules/networking"

  project_name       = "example-app"
  environment        = "dev"
  vpc_cidr           = "10.0.0.0/16"
  az_count           = 2
  single_nat_gateway = true
}

module "ecs" {
  source = "../../modules/ecs-fargate"

  project_name       = "example-app"
  environment        = "dev"
  vpc_id             = module.networking.vpc_id
  public_subnet_ids  = module.networking.public_subnet_ids
  private_subnet_ids = module.networking.private_subnet_ids

  container_image   = "nginx:latest"
  container_port    = 80
  health_check_path = "/"
  task_cpu          = 256
  task_memory       = 512
  desired_count     = 1
  max_count         = 2
}

output "app_url" {
  value = "http://${module.ecs.alb_dns_name}"
}

output "ecr_url" {
  value = module.ecs.ecr_repository_url
}
