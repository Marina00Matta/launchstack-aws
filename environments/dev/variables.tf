variable "project_name" {
  description = "Name of your project. Used for all resource naming."
  type        = string
}

variable "aws_region" {
  description = "AWS region to deploy into."
  type        = string
  default     = "us-east-1"
}

variable "container_image" {
  description = "Docker image to deploy (e.g., 'nginx:latest' for testing)."
  type        = string
  default     = "nginx:latest"
}

variable "container_port" {
  description = "Port your container listens on."
  type        = number
  default     = 80
}

variable "environment_variables" {
  description = "Environment variables for the container."
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}

variable "alert_email" {
  description = "Email address for monitoring alerts (premium module)."
  type        = string
  default     = ""
}

variable "additional_tags" {
  description = "Additional tags for all resources."
  type        = map(string)
  default     = {}
}
