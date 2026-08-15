# 🚀 LaunchStack AWS

**Production-ready AWS infrastructure in 30 minutes. Not 2 weeks.**

LaunchStack is an opinionated, battle-tested Terraform starter kit for startups and small teams who need real infrastructure — not a tutorial.

One `terraform apply` gives you a fully configured AWS environment with networking, containers, database, monitoring, CI/CD, and security baselines. Every default is production-grade. Every module is documented.

---

## What you get

### Free (this repo)

| Module | What it sets up |
|--------|----------------|
| **Networking** | VPC, public/private subnets across 3 AZs, NAT Gateway, flow logs |
| **ECS Fargate** | Cluster, service, task definition, ALB, auto-scaling, health checks |

### [Premium](https://gumroad.com/l/launchstack-aws) — $99

Everything above, plus:

| Module | What it sets up |
|--------|----------------|
| **RDS** | PostgreSQL with Multi-AZ, automated backups, encryption at rest, parameter tuning |
| **Monitoring** | CloudWatch dashboards, alarms (CPU, memory, 5xx, latency), SNS alerting, log groups |
| **Security** | IAM least-privilege roles, security groups, S3 bucket policies, SSM Parameter Store for secrets |
| **CI/CD (GitHub Actions)** | Build, test, push to ECR, deploy to ECS — complete pipeline |
| **CI/CD (GitLab CI)** | Same pipeline for GitLab users |
| **Environments** | Pre-configured dev/staging/prod with sensible resource sizing |
| **Full Documentation** | Architecture diagrams, cost estimates, customization guide, runbook |

---

## Quick start

### Prerequisites

- [Terraform](https://www.terraform.io/downloads) >= 1.5
- [AWS CLI](https://aws.amazon.com/cli/) configured with appropriate credentials
- An AWS account

### Deploy in 5 steps

```bash
# 1. Clone the repo
git clone https://github.com/YOUR_USERNAME/launchstack-aws.git
cd launchstack-aws

# 2. Initialize the backend
cd environments/dev
cp terraform.tfvars.example terraform.tfvars

# 3. Edit your variables
# Open terraform.tfvars and set your project name, region, and domain

# 4. Initialize Terraform
terraform init

# 5. Deploy
terraform plan
terraform apply
```

That's it. Your infrastructure is live.

---

## Architecture

```
┌─────────────────────────────────────────────────────┐
│                      VPC (10.0.0.0/16)              │
│                                                     │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐          │
│  │ Public   │  │ Public   │  │ Public   │          │
│  │ Subnet   │  │ Subnet   │  │ Subnet   │          │
│  │ AZ-1     │  │ AZ-2     │  │ AZ-3     │          │
│  └────┬─────┘  └────┬─────┘  └────┬─────┘          │
│       │              │              │                │
│       └──────┬───────┴──────┬───────┘                │
│              │  ALB         │                        │
│              ▼              ▼                        │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐          │
│  │ Private  │  │ Private  │  │ Private  │          │
│  │ Subnet   │  │ Subnet   │  │ Subnet   │          │
│  │ AZ-1     │  │ AZ-2     │  │ AZ-3     │          │
│  │┌────────┐│  │┌────────┐│  │          │          │
│  ││Fargate ││  ││Fargate ││  │          │          │
│  ││Task    ││  ││Task    ││  │          │          │
│  │└────────┘│  │└────────┘│  │          │          │
│  └──────────┘  └──────────┘  └──────────┘          │
│                                                     │
│  ┌─────────────────────────────────────┐ (Premium) │
│  │  RDS PostgreSQL (Multi-AZ)          │           │
│  └─────────────────────────────────────┘           │
└─────────────────────────────────────────────────────┘
         │                          │
    CloudWatch ◄──────────────► SNS Alerts  (Premium)
```

---

## Cost estimates

| Environment | Monthly estimate (us-east-1) |
|-------------|------------------------------|
| Dev         | ~$45–65/mo                   |
| Staging     | ~$80–120/mo                  |
| Production  | ~$150–300/mo                 |

*Estimates based on minimal workloads. Your actual costs depend on traffic and data.*

---

## Modules

Each module is independent and can be used standalone:

```hcl
module "networking" {
  source = "./modules/networking"

  project_name = "myapp"
  environment  = "dev"
  vpc_cidr     = "10.0.0.0/16"
}

module "ecs" {
  source = "./modules/ecs-fargate"

  project_name       = "myapp"
  environment        = "dev"
  vpc_id             = module.networking.vpc_id
  private_subnet_ids = module.networking.private_subnet_ids
  public_subnet_ids  = module.networking.public_subnet_ids
}
```

---

## Why LaunchStack?

**vs. Free GitHub repos**: Those give you a VPC and a prayer. No monitoring, no security, no docs. You'll spend 2 weeks gluing pieces together.

**vs. Enterprise IaC platforms**: Spacelift, Env0, and Terraform Cloud are great — when you have a platform team. You don't. You need infrastructure that works today.

**vs. Building from scratch**: You absolutely can. It'll take 40–80 hours of your time, and you'll miss at least 3 security best practices. We've already made those mistakes so you don't have to.

---

## Contributing

Found a bug? Want to improve something? PRs are welcome. See [CONTRIBUTING.md](CONTRIBUTING.md).

## License

Free modules: MIT License. See [LICENSE](LICENSE).

Premium modules: Commercial license. See [purchase page](https://gumroad.com/l/launchstack-aws).
