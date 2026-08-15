variable "project_name" {
  description = "Name of the project."
  type        = string
}

variable "environment" {
  description = "Deployment environment (dev, staging, prod)."
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC to deploy into."
  type        = string
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs for the ALB."
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs for ECS tasks."
  type        = list(string)
}

# --- Container configuration ---

variable "container_image" {
  description = "Docker image to deploy. Leave empty to use the ECR repository created by this module."
  type        = string
  default     = ""
}

variable "container_port" {
  description = "Port the container listens on."
  type        = number
  default     = 8080
}

variable "task_cpu" {
  description = "CPU units for the task (256 = 0.25 vCPU, 512 = 0.5 vCPU, 1024 = 1 vCPU)."
  type        = number
  default     = 256
}

variable "task_memory" {
  description = "Memory (MiB) for the task. Must be compatible with cpu value."
  type        = number
  default     = 512
}

variable "environment_variables" {
  description = "List of environment variables for the container."
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}

variable "health_check_path" {
  description = "Path for ALB and container health checks."
  type        = string
  default     = "/health"
}

# --- Scaling ---

variable "desired_count" {
  description = "Desired number of running tasks."
  type        = number
  default     = 2
}

variable "max_count" {
  description = "Maximum number of tasks for auto-scaling."
  type        = number
  default     = 6
}

variable "cpu_scaling_target" {
  description = "Target CPU utilization (%) for auto-scaling."
  type        = number
  default     = 70
}

variable "memory_scaling_target" {
  description = "Target memory utilization (%) for auto-scaling."
  type        = number
  default     = 80
}

# --- Observability ---

variable "enable_container_insights" {
  description = "Enable CloudWatch Container Insights for the ECS cluster."
  type        = bool
  default     = true
}

variable "log_retention_days" {
  description = "Number of days to retain container logs in CloudWatch."
  type        = number
  default     = 30
}

variable "ecr_image_retention_count" {
  description = "Number of images to retain in ECR before lifecycle cleanup."
  type        = number
  default     = 20
}

variable "tags" {
  description = "Additional tags to apply to all resources."
  type        = map(string)
  default     = {}
}
