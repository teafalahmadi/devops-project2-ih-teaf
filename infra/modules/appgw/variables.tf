variable "resource_group_name" {
  type        = string
}

variable "location" {
  type        = string
}

variable "prefix" {
  type        = string
}

variable "subnet_id" {
  type        = string
  description = "App Gateway subnet ID"
}

variable "backend_addresses" {
  type        = list(string)
  default     = []
  description = "List of backend FQDNs or IPs for routing"
}

variable "log_analytics_id" {
  type        = string
  description = "Log Analytics Workspace ID for diagnostics"
}
