resource "oci_core_volume" "instance_volumes" {
    for_each = local.disks
    availability_domain = lookup(data.oci_identity_availability_domains.ADs.availability_domains[0],"name")
    compartment_id = lookup(data.oci_identity_compartments.selected_instance_compartment.compartments[0], "id")
    display_name = "${var.hostname}_${each.key}"
    size_in_gbs = each.value.size
    //backup_policy_id = lookup(data.oci_core_volume_backup_policies.selected_volume_backup_policies.volume_backup_policies[0],"id")

    defined_tags = {
        "Finance.Project" = var.project_name
        "CIO.ENV" = var.env
    }

    freeform_tags = {
        "VOLUME_TYPE" = "LVM"
        "VG_NAME" = each.value.vg_name
    }
}

resource "oci_core_volume_backup_policy_assignment" "instance_volumes_backups" {
    for_each = oci_core_volume.instance_volumes
    asset_id = each.value.id
    policy_id = lookup(data.oci_core_volume_backup_policies.selected_volume_backup_policies.volume_backup_policies[0],"id")
}

resource "oci_core_volume_backup_policy_assignment" "instance_boot_backup_policy_assignment" {
    asset_id = oci_core_instance.instance.boot_volume_id
    policy_id = lookup(data.oci_core_volume_backup_policies.selected_volume_backup_policies.volume_backup_policies[0],"id")
}