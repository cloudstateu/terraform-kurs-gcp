variable "identifier" {
  type        = string
  description = "VM identifier"
}

variable "subnetwork_name" {
  type        = string
  description = "Name of the Subnetwork to attach the VM interface to."
}

variable "ip" {
  type        = string
  description = "VM external IP address."
}
