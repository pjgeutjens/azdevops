resource "azurerm_network_interface" "internal" {
  count               = "${var.vm_count}"
  name                = "${var.hostname_prefix}-nic-${count.index}"
  location            = "${var.resource_group_location}"
  resource_group_name = "${var.resource_group_name}"

  ip_configuration {
    name                          = "${var.prefix}-ipconfig-${count.index}"
    subnet_id                     = "${azurerm_subnet.internal.id}"
    private_ip_address_allocation = "dynamic"

    #TODO Remove after debug
    public_ip_address_id = "${var.is_public ? element(concat(azurerm_public_ip.internal.*.id, list("")), count.index) : "" }"

    # public_ip_address_id = ""
  }
}

resource "azurerm_subnet" "internal" {
  count                = "${var.vm_count > 0 ? 1 : 0}"
  name                 = "${var.prefix}-${var.hostname_prefix}-subnet"
  resource_group_name  = "${var.resource_group_name}"
  virtual_network_name = "${var.virtual_network}"
  address_prefix       = "${var.subnet_prefix}"
}

resource "azurerm_public_ip" "internal" {
  count                        = "${var.is_public ? var.vm_count : 0}"
  name                         = "${var.prefix}-pubip-${var.hostname_prefix}-${count.index}"
  location                     = "${var.resource_group_location}"
  resource_group_name          = "${var.resource_group_name}"
  public_ip_address_allocation = "Static"
  idle_timeout_in_minutes      = 10
}
# data "azurerm_public_ip" "internal" {
#   count                        = "${var.is_public ? var.vm_count : 0}"
#   name                = "${element(azurerm_public_ip.internal.*.name, count.index )}"
#   # resource_group_name                = "${element(azurerm_public_ip.internal.*.name, count.index )}"
#   resource_group_name          = "${azurerm_public_ip.internal.resource_group_name}"
# }

## outputs 
output "private_ip" {
  value = "${azurerm_network_interface.internal.*.private_ip_address}"
}
output "public_ip"  {
  value =  "${azurerm_public_ip.internal.*.ip_address}"
}