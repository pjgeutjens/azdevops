# Configure the VMware vSphere Provider
provider "vsphere" {
    vsphere_server = "${var.vsphere_vcenter}"
    user = "${var.vsphere_user}"
    password = "${var.vsphere_password}"
    allow_unverified_ssl = true
}



module "cluster" {
source = "./modules/webserver-cluster"

cluster_name = "DCS"
resource_pool_name = "test"
datastore = "DCS_Lab_(vSAN)"
vm_network = "TN-Prooflab|LabMgmt|LabMgmt" 
vm_template = "centos-test"
virtual_machine_name_prefix = "web-vm-"
vm_count = "${var.count}" 
}

/*
variable "countA" {
default = 3
}
*/
