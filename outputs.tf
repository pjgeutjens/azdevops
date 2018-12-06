output "vm-name" {
value = "${module.cluster.name}"
}

output "vm-ip" {
value = "${module.cluster.ip_address}"
}

output "vm-network-interace" {
value = "${module.cluster.interface_info}"
}

