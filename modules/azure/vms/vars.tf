###########################
##         Azure       ####
###########################
variable "subscription_id" {
  default     = ""
  description = "TBD"
}

variable "client_id" {
  default     = ""
  description = "TBD"
}

variable "tenant_id" {
  default = ""
}

variable "client_secret" {
  default = ""
}

variable "prefix" {
  default = ""
}

variable "hostname_prefix" {
  default = ""
}

variable "virtual_network" {
  default = ""
}

variable "vm_count" {
  default = 0
}

variable "is_public" {
  default = false
}

variable "subnet_prefix" {
  default = "10.0.3.0/24"
}

variable "ssh_key" {
  default = ""
}
variable "vm_type" {
  default = "Standard_A1_v2"
}

variable "resource_group_location" {
  default = "westeurope"
}

variable "resource_group_name" {}

variable "network_interface_count" {
  default = 0
}
