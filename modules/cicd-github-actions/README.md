# CI/CD — GitHub Actions Module (Premium)

This module is part of the [LaunchStack AWS Premium](https://marinamedhat0.gumroad.com/l/qkpvsi) package.

## What it sets up

- Complete GitHub Actions workflow for build → test → push → deploy
- Multi-environment pipeline (dev → staging → prod) with manual approval gates
- Docker build with layer caching for fast builds
- ECR push with immutable image tags (git SHA-based)
- ECS service deployment with automatic rollback on failure
- Terraform plan/apply workflow for infrastructure changes
- OIDC-based AWS authentication (no stored credentials)

## Included workflow files

```
.github/workflows/
├── deploy.yml          # Build and deploy application
├── terraform.yml       # Plan and apply infrastructure changes
└── destroy.yml         # Tear down an environment (manual trigger)
```

## Get the premium package

[Purchase LaunchStack AWS Premium](https://marinamedhat0.gumroad.com/l/qkpvsi) to unlock this module.
