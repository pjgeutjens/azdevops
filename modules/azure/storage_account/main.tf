resource "azurerm_storage_account" "test" {
  name                     = "${var.storage_account_name}"
  resource_group_name      = "${var.resource_group_name}"
  location                 = "${var.resource_group_location}"
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags {
    environment = "${var.env_name}"
  }
}

resource "azurerm_storage_container" "test" {
  name                  = "${var.container_name}"
  resource_group_name   = "${var.resource_group_name}"
  storage_account_name  = "${var.storage_account_name}"
  container_access_type = "private"
}

/* output "storage_access_key" {
  value = "${data.azurerm_storage_account.test.primary_access_key}"
} */