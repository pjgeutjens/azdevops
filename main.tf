# 
#
#
###### INIT ######
module "resource_group" {
  source                  = "./modules/azure/resourcegroup"
  resource_group_name  = "${var.resource_group_name}"
  resource_group_location = "${var.resource_group_location}"
}

module "storage_account" {
  source = "./modules/azure/storage_account"
  storage_account_name = "sasofianelm"
  container_name = "sofiantfstate"
  resource_group_location = "${var.resource_group_location}"
  resource_group_name = "${var.resource_group_name}"
  env_name = "staging"
}
###### END INIT ######

/* module "virtual_network_all" {
  source                  = "./modules/azure/virtualnetwork"
  resource_group_name     = "${module.resource_group.name}"
  resource_group_location = "${var.resource_group_location}"
  prefix                  = "${var.prefix}"
} */

/* module "vm_standard1" {
  source                  = "./modules/azure/vms"
  vm_count                = "${var.standard_vm_count}"
  resource_group_name     = "${module.resource_group.name}"
  resource_group_location = "${var.resource_group_location}"
  hostname_prefix         = "${var.prefix}-standard"
  prefix                  = "${var.prefix}"
  vm_type                 = "${var.standard_vm_type}"
  virtual_network         = "${module.virtual_network_all.name}"
  subnet_prefix           = "${var.standard_subnet}"
  is_public               = "${var.standard_is_public}"
  #ssh_key = "${data.vault_generic_secret.ssh_keys.data[var.ssh_vaulted_key]}"
} */


# Based on your storage account
/* terraform {
  backend "azurerm" {
    storage_account_name = "sasofianelm"
    container_name = "sofiantfstate"
    resource_group_name  = "RG-Lab-SofianElM"
    # not possible// access_key = "${module.storage_access_key.name}"
    #access_key = "WKIv36SwrQGWHsS/LSsQm9kRTll/Ae3sOIuluTaaJQ73OayZBr6LcEXDy2s++nw90IR4UPOa6doJMWekWOYx3w=="
  }
} */

provider "azurerm" {
  # whilst the `version` attribute is optional, we recommend pinning to a given version of the Provider
  version = "=1.20.0"

  # subscription_id = "${var.subscription_id}"
  /* subscription_id = "${data.vault_generic_secret.azure-credentials.data["subscription_id"]}"
  client_id       = "${data.vault_generic_secret.azure-credentials.data["client_id"]}"
  tenant_id       = "${data.vault_generic_secret.azure-credentials.data["tenant_id"]}"
  client_secret   = "${data.vault_generic_secret.azure-credentials.data["client_secret"]}" */
}

/* provider "vault" {}

data "vault_generic_secret" "azure-credentials" {
  path = "secret/azure-cicd"
}

data "vault_generic_secret" "ssh_keys" {
 path = "secret/ssh_keys" 
} */
