output "alb_url" {
  description = "URL of the Application Load Balancer. Your app is accessible here."
  value       = "http://${module.ecs.alb_dns_name}"
}

output "ecr_repository_url" {
  description = "Push your Docker images here."
  value       = module.ecs.ecr_repository_url
}

output "vpc_id" {
  description = "VPC ID (for reference)."
  value       = module.networking.vpc_id
}

output "ecs_cluster_name" {
  description = "ECS cluster name."
  value       = module.ecs.cluster_name
}

output "ecs_service_name" {
  description = "ECS service name."
  value       = module.ecs.service_name
}

output "push_and_deploy" {
  description = "Quick reference: how to push a new image and deploy."
  value       = <<-EOT

    # Build and push your image:
    aws ecr get-login-password --region ${var.aws_region} | docker login --username AWS --password-stdin ${module.ecs.ecr_repository_url}
    docker build -t ${module.ecs.ecr_repository_url}:v1 .
    docker push ${module.ecs.ecr_repository_url}:v1

    # Update the service:
    aws ecs update-service --cluster ${module.ecs.cluster_name} --service ${module.ecs.service_name} --force-new-deployment

  EOT
}
