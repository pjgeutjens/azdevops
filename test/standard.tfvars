###########################
##         Azure       ####
###########################

resource_group_name = "RG-Lab-gitlabci-cicd"

resource_groupe_location = "westeurope"

# Prefix used by all the resources 
prefix = "standard"
ssh_vaulted_key = "cicd_ansible"

### standard 
standard_vm_count = 2
standard_vm_type = "Standard_A2_v2"  
standard_subnet = "10.0.102.0/24"
standard_is_public = true
