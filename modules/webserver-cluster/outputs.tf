output "name" {
 value = "${vsphere_virtual_machine.vm.*.name}"
}

output "interface_info" {
 value = "${vsphere_virtual_machine.vm.*.network_interface}"
}

output "ip_address" {
value = "${vsphere_virtual_machine.vm.*.guest_ip_addresses}"
}

/*
output "ip_address" {
value = "${vsphere_virtual_machine.vm.*.default_ip_address}"
}
*/
