resource "azurerm_virtual_machine" "vm" {
  count                 = "${var.vm_count}"
  name                  = "${var.hostname_prefix}-vm-${count.index}"
  location              = "${var.resource_group_location}"
  resource_group_name   = "${var.resource_group_name}"
  network_interface_ids = ["${element(azurerm_network_interface.internal.*.id, count.index)}"]
  vm_size               = "${var.vm_type}"

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "${var.hostname_prefix}-disk-${count.index}"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "${var.hostname_prefix}-${count.index}"
    admin_username = "deploy"
    admin_password = "Password1234!"
  }

  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys                        = [{
    path     = "/home/deploy/.ssh/authorized_keys"
    key_data = "${var.ssh_key}"
    }
    ]
  }

  tags {
    prefix = "${var.prefix}"
  }
}


output "name" {
  value = "${azurerm_virtual_machine.vm.*.name}"
}