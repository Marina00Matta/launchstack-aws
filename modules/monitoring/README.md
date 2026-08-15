# Monitoring Module (Premium)

This module is part of the [LaunchStack AWS Premium](https://gumroad.com/l/launchstack-aws) package.

## What it sets up

- CloudWatch Dashboard with CPU, memory, request count, and latency widgets
- Alarms for high CPU (>80%), high memory (>85%), elevated 5xx rates, and high latency
- SNS topic with email notifications for all alarms
- ALB access logging to S3
- Container log metric filters for error detection
- Cost anomaly detection alarm

## Usage

```hcl
module "monitoring" {
  source = "../../modules/monitoring"

  project_name = "my-app"
  environment  = "prod"
  ecs_cluster  = module.ecs.cluster_name
  ecs_service  = module.ecs.service_name
  alb_arn      = module.ecs.alb_arn
  alert_email  = "oncall@yourcompany.com"
}
```

## Get the premium package

[Purchase LaunchStack AWS Premium](https://gumroad.com/l/launchstack-aws) to unlock this module.
