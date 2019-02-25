variable "subscription_id" {
  default = ""
  description = "TBD"
}

variable "client_id" {
  default = ""
  description = "TBD"
}

variable "tenant_id" {
  default = ""
  }

variable "client_secret" {
  default = ""
}

variable "resource_group_name" {
  default = "RG-Lab-SofianElM"
  description = "Azure Resource Group Name"
}

variable "resource_group_location" {
  description = "Azure Resource Group Location"
  default     = "westeurope"
}

variable "standard_is_public" {
  default = false
}

variable "standard_subnet" {
  default = "10.0.101.0/24"
}

variable "standard_vm_count" {
  default = 0
}

variable "standard_vm_type" {
  default = "Standard_A1_v2"
}

variable "prefix" {
  default = "sof"
}


variable "ssh_vaulted_key" { 
  default = ""
}
