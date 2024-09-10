locals {
  string = "hello world"

  string_length = length(local.string)

  list = [
    "string1",
    local.string,
    "string2",
  ]

  list_length = length(local.list)

  map = {
    key1 = "value1",
    key2 = "value2",
    key3 = "value3",
    key0 = "value4",
  }

  keys = keys(local.map)

  allowed_envs = [
    "production",
    "testing"
  ]
}

# variable "env" {
#   type        = string
#   description = "Environment name"

#   validation {
#     condition     = contains(["production", "testing"], var.env)
#     error_message = "Invalid environment name"
#   }
# }
