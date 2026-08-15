# Contributing to LaunchStack AWS

Thanks for your interest in contributing! Here's how to help.

## What we accept

- Bug fixes in the free modules (networking, ecs-fargate)
- Documentation improvements
- New examples in the `examples/` directory
- Terraform version compatibility fixes

## How to contribute

1. Fork the repository
2. Create a feature branch (`git checkout -b fix/vpc-flow-logs`)
3. Make your changes
4. Run `terraform fmt -recursive` to format your code
5. Run `terraform validate` in any modified module
6. Submit a Pull Request

## Code style

- Use `terraform fmt` formatting (enforced in CI)
- Every variable must have a `description`
- Every output must have a `description`
- Use `snake_case` for all resource names
- Tag all resources with `Name`, `Project`, and `Environment`

## Questions?

Open an issue — happy to help.
