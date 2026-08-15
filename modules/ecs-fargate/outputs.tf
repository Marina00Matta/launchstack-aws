output "cluster_id" {
  description = "The ID of the ECS cluster."
  value       = aws_ecs_cluster.main.id
}

output "cluster_name" {
  description = "The name of the ECS cluster."
  value       = aws_ecs_cluster.main.name
}

output "service_name" {
  description = "The name of the ECS service."
  value       = aws_ecs_service.app.name
}

output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer. Point your domain here."
  value       = aws_lb.app.dns_name
}

output "alb_zone_id" {
  description = "Zone ID of the ALB (for Route53 alias records)."
  value       = aws_lb.app.zone_id
}

output "alb_arn" {
  description = "ARN of the Application Load Balancer."
  value       = aws_lb.app.arn
}

output "ecr_repository_url" {
  description = "URL of the ECR repository. Push your Docker images here."
  value       = aws_ecr_repository.app.repository_url
}

output "task_execution_role_arn" {
  description = "ARN of the ECS task execution role."
  value       = aws_iam_role.ecs_execution.arn
}

output "task_role_arn" {
  description = "ARN of the ECS task role. Attach additional policies for app permissions."
  value       = aws_iam_role.ecs_task.arn
}

output "ecs_security_group_id" {
  description = "Security group ID for ECS tasks. Use this to allow access from ECS to RDS."
  value       = aws_security_group.ecs_tasks.id
}

output "log_group_name" {
  description = "CloudWatch Log Group name for container logs."
  value       = aws_cloudwatch_log_group.app.name
}
