# CI/CD — GitLab CI Module (Premium)

This module is part of the [LaunchStack AWS Premium](https://gumroad.com/l/launchstack-aws) package.

## What it sets up

- Complete `.gitlab-ci.yml` pipeline for build → test → push → deploy
- Multi-environment stages (dev → staging → prod) with manual approval gates
- Docker-in-Docker builds with layer caching
- ECR push with immutable image tags
- ECS deployment with rollback
- Terraform plan/apply pipeline with MR-based review
- AWS credential injection via GitLab CI/CD variables

## Included files

```
.gitlab/
├── .gitlab-ci.yml      # Main pipeline definition
├── deploy.yml          # Deploy stage template
└── terraform.yml       # Infrastructure stage template
```

## Get the premium package

[Purchase LaunchStack AWS Premium](https://gumroad.com/l/launchstack-aws) to unlock this module.
