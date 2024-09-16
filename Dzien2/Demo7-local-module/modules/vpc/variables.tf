variable "env" {
  type        = string
  description = "Environment name"

  validation {
    condition     = contains(["prod", "test"], var.env)
    error_message = "Invalid environment name"
  }
}

variable "project_name" {
    type = string
}

variable "subnets" {
    type = map(object({
        name = string
        ip_cidr_range = string
        region = string
    }))
}