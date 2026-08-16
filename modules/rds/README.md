# RDS Module (Premium)

This module is part of the [LaunchStack AWS Premium](https://launchstacq.gumroad.com/l/qkpvsi) package.

## What it sets up

- PostgreSQL RDS instance with encryption at rest
- Multi-AZ deployment for production high availability
- Automated backups with configurable retention
- Performance-tuned parameter group
- Subnet group across private subnets
- Security group allowing access only from ECS tasks
- SSM Parameter Store for database credentials (no hardcoded passwords)

## Usage

```hcl
module "rds" {
  source = "../../modules/rds"

  project_name          = "my-app"
  environment           = "prod"
  vpc_id                = module.networking.vpc_id
  private_subnet_ids    = module.networking.private_subnet_ids
  ecs_security_group_id = module.ecs.ecs_security_group_id

  instance_class    = "db.t3.medium"
  allocated_storage = 50
  multi_az          = true
}
```

## Get the premium package

[Purchase LaunchStack AWS Premium](https://launchstacq.gumroad.com/l/qkpvsi) to unlock this module and all other premium modules including monitoring, security, and CI/CD.
