# Security Module (Premium)

This module is part of the [LaunchStack AWS Premium](https://gumroad.com/l/launchstack-aws) package.

## What it sets up

- IAM roles following least-privilege principle for all services
- S3 bucket policies blocking public access
- SSM Parameter Store for secrets management (no .env files)
- Security group rules audit — ensures no 0.0.0.0/0 ingress on private resources
- AWS Config rules for compliance monitoring
- CloudTrail for API audit logging

## Usage

```hcl
module "security" {
  source = "../../modules/security"

  project_name = "my-app"
  environment  = "prod"
  vpc_id       = module.networking.vpc_id
}
```

## Get the premium package

[Purchase LaunchStack AWS Premium](https://gumroad.com/l/launchstack-aws) to unlock this module.
