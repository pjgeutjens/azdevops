variable "cluster_name"          {}
variable "resource_pool_name"    {}
variable "datastore"    {}
variable "vm_network"    {}
variable "vm_template"    {}
variable "virtual_machine_name_prefix" {}
variable "vm_count" {}


data "vsphere_datacenter" "dc" {
  name = "PROOFLAB"
}
data "vsphere_compute_cluster" "compute_cluster" {
  name          = "${var.cluster_name}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_resource_pool" "test_pool" {
  name          = "${var.resource_pool_name}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_datastore" "datastore" {
  name          = "${var.datastore}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_network" "network" {
  name          = "${var.vm_network}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}


data "vsphere_virtual_machine" "template" {
  name          = "${var.vm_template}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}


resource "vsphere_virtual_machine" "vm" {
  name             = "web-${count.index + 1}"
 # resource_pool_id = "${data.vsphere_compute_cluster.compute_cluster.resource_pool_id}"
  count = "${var.vm_count}"
  resource_pool_id = "${data.vsphere_resource_pool.test_pool.id}"
  datastore_id     = "${data.vsphere_datastore.datastore.id}"
  num_cpus = 1
  memory   = 1024
  guest_id = "${data.vsphere_virtual_machine.template.guest_id}"

  disk {
    label            = "disk0"
    size             = "${data.vsphere_virtual_machine.template.disks.0.size}"
    eagerly_scrub    = "${data.vsphere_virtual_machine.template.disks.0.eagerly_scrub}"
    thin_provisioned = "${data.vsphere_virtual_machine.template.disks.0.thin_provisioned}"
    }

  network_interface {
    network_id   = "${data.vsphere_network.network.id}"
        }

  clone {
    template_uuid = "${data.vsphere_virtual_machine.template.id}"

    customize {
      linux_options {
        host_name = "${var.virtual_machine_name_prefix}${count.index + 1}"
        domain    = "test.internal"
      }

      network_interface {
        ipv4_address = "10.166.160.${169 + count.index}"
        ipv4_netmask = "24"
     }

      ipv4_gateway = "10.166.160.1"
      dns_server_list = ["10.166.160.202"]
    }

}

provisioner "local-exec" {
        command = "sleep 60; ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u terra --private-key ~/.ssh/id_rsa -i '${self.guest_ip_addresses[0]},' /etc/ansible/master.yml"
}

}
