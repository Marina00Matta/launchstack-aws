# ============================================================================
# LaunchStack AWS — Dev Environment
# ============================================================================
# Cost-optimized development environment.
# Estimated cost: ~$45–65/month (us-east-1)
#
# Differences from production:
# - Single NAT Gateway (saves ~$32/mo per extra NAT)
# - Smaller task sizes (256 CPU / 512 MB)
# - 2 desired tasks (vs 3+ in prod)
# - ECR allows force delete
# - ALB deletion protection disabled
# ============================================================================

terraform {
  required_version = ">= 1.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # Uncomment and configure for remote state (recommended)
  # backend "s3" {
  #   bucket         = "your-terraform-state-bucket"
  #   key            = "launchstack/dev/terraform.tfstate"
  #   region         = "us-east-1"
  #   dynamodb_table = "terraform-locks"
  #   encrypt        = true
  # }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = var.project_name
      Environment = "dev"
      ManagedBy   = "terraform"
      Repository  = "launchstack-aws"
    }
  }
}

# ----------------------------------------------------------------------------
# Networking
# ----------------------------------------------------------------------------

module "networking" {
  source = "../../modules/networking"

  project_name       = var.project_name
  environment        = "dev"
  vpc_cidr           = "10.0.0.0/16"
  az_count           = 2              # 2 AZs is fine for dev
  single_nat_gateway = true           # Save money in dev
  enable_flow_logs   = true

  tags = var.additional_tags
}

# ----------------------------------------------------------------------------
# ECS Fargate
# ----------------------------------------------------------------------------

module "ecs" {
  source = "../../modules/ecs-fargate"

  project_name       = var.project_name
  environment        = "dev"
  vpc_id             = module.networking.vpc_id
  public_subnet_ids  = module.networking.public_subnet_ids
  private_subnet_ids = module.networking.private_subnet_ids

  # Container config
  container_image = var.container_image
  container_port  = var.container_port
  task_cpu        = 256   # 0.25 vCPU — plenty for dev
  task_memory     = 512   # 512 MB

  # Scaling
  desired_count = 1       # Single task for dev
  max_count     = 2

  # Observability
  enable_container_insights = false  # Save money in dev
  log_retention_days        = 7

  environment_variables = var.environment_variables

  tags = var.additional_tags
}

# ============================================================================
# Premium modules (uncomment after purchase)
# ============================================================================

# module "rds" {
#   source = "../../modules/rds"
#
#   project_name       = var.project_name
#   environment        = "dev"
#   vpc_id             = module.networking.vpc_id
#   private_subnet_ids = module.networking.private_subnet_ids
#   ecs_security_group_id = module.ecs.ecs_security_group_id
#
#   instance_class     = "db.t3.micro"
#   allocated_storage  = 20
#   multi_az           = false  # Single AZ for dev
#
#   tags = var.additional_tags
# }

# module "monitoring" {
#   source = "../../modules/monitoring"
#
#   project_name   = var.project_name
#   environment    = "dev"
#   ecs_cluster    = module.ecs.cluster_name
#   ecs_service    = module.ecs.service_name
#   alb_arn        = module.ecs.alb_arn
#   alert_email    = var.alert_email
#
#   tags = var.additional_tags
# }

# module "security" {
#   source = "../../modules/security"
#
#   project_name = var.project_name
#   environment  = "dev"
#   vpc_id       = module.networking.vpc_id
#
#   tags = var.additional_tags
# }
