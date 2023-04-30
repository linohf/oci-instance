data "oci_identity_compartments" "selected_instance_compartment" {
    compartment_id = lookup(data.oci_identity_compartments.selected_vcn_compartment.compartments[0], "id")

    filter {
        name = "name"
        values = [var.instance_compartment_name]
    }
}

data "oci_identity_compartments" "selected_vcn_compartment" {
    compartment_id = var.tenancy_ocid

    filter {
        name = "name"
        values = [var.vcn_compartment_name]
    }
}

data "oci_identity_availability_domains" "ADs" {
    compartment_id = lookup(data.oci_identity_compartments.selected_instance_compartment.compartments[0], "id")
    
    filter {
        name = "name"
        values = ["-${var.ad_number}"]
        regex = true
    }
}

data "oci_core_vcns" "selected_vcns" {
    compartment_id = lookup(data.oci_identity_compartments.selected_vcn_compartment.compartments[0], "id")
    display_name = var.vcn_name
}

data "oci_core_subnets" "selected_subnets" {
    compartment_id = lookup(data.oci_identity_compartments.selected_vcn_compartment.compartments[0], "id")
    vcn_id = lookup(data.oci_core_vcns.selected_vcns.virtual_networks[0], "id")
    display_name = var.subnet_name
}

data "oci_core_images" "plataform_images_list" {
    compartment_id = "ocid1.compartment.oc1..aaaaaaaa27oaurw3afyxat3jvperectk7lzrhxi4f6bnut553qyessif2g5a"
    operating_system = var.operating_system_name
    operating_system_version = var.operating_system_version
    shape = var.shape
}

data "oci_core_images" "custom_images_list" {
    compartment_id = "ocid1.compartment.oc1..aaaaaaaa27oaurw3afyxat3jvperectk7lzrhxi4f6bnut553qyessif2g5a"
    shape = var.shape
}

data "oci_core_volume_backup_policies" "selected_volume_backup_policies" {
    filter {
        name = "display_name"
        values = [local.backup_policy_name]
    }
}

data "oci_bastion_bastions" "bastions" {
    compartment_id = lookup(data.oci_identity_compartments.selected_vcn_compartment.compartments[0], "id")    
    bastion_lifecycle_state = "Active"
    name = "ProvisionBastion"
}