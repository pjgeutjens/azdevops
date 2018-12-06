# Configure the VMware vSphere Provider
provider "vsphere" {
    vsphere_server = "${var.vsphere_vcenter}"
    user = "${var.vsphere_user}"
    password = "${var.vsphere_password}"
    allow_unverified_ssl = true
}

data "vsphere_datacenter" "dc" {
  name = "PROOFLAB"
}
data "vsphere_compute_cluster" "compute_cluster" {
  name          = "DCS"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_resource_pool" "test_pool" {
  name          = "test"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

/*
resource "vsphere_resource_pool" "test_pool" {
  name                    = "terraform-resource-pool-test"
  parent_resource_pool_id = "${data.vsphere_compute_cluster.compute_cluster.id}"
}
*/
data "vsphere_datastore" "datastore" {
  name          = "vsanDatastore (1)"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_network" "network" {
  name          = "TN-Prooflab|LabMgmt|LabMgmt"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}


data "vsphere_virtual_machine" "template" {
  name          = "centos-test"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}


resource "vsphere_virtual_machine" "vm" {
  name             = "test-vm-${count.index + 1}"
 # resource_pool_id = "${data.vsphere_compute_cluster.compute_cluster.resource_pool_id}"
  count = 2
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
        host_name = "test-vm-${count.index + 1}"
        domain    = "test.internal"
      }

      network_interface {
        ipv4_address = "10.166.160.${171 + count.index}"
        ipv4_netmask = "24" 
     }

      ipv4_gateway = "10.166.160.1"
      dns_server_list = ["10.166.160.202"]
    }

}

}

