resource "azurerm_resource_group" "main" {
  name     = "${var.resource_group_name}"
  location = "${var.resource_group_location}"
}
output  "name" {
  value = "${azurerm_resource_group.main.name}"
}