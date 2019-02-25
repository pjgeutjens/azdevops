resource "azurerm_virtual_network" "internal" {
  name                = "${module.var.prefix}-virtual-network"
  resource_group_name = "${var.resource_group_name}"
  location            = "${var.resource_group_location}"
  address_space       = ["10.0.0.0/16"]
}

output "name" {
  value = "${azurerm_virtual_network.internal.name}"
}
