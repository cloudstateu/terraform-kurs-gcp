variable "environment_name" {
  type    = string

  validation {
    condition = contains(["test", "prod"], var.environment_name)
    error_message = "The environment name is not valid"
  }
}

variable "project_name" {
  type    = string
  default = "example"
}