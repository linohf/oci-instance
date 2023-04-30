locals {

  disks_list = var.vg_disks != "" ? flatten([
    for vg_key, vg_def in var.vg_disks : [
        for idx, disk_size in vg_def.disks: {
            format("%s-%02d", vg_key, idx + 1) = { vg_name = vg_key, size = disk_size }
        }
    ]
  ]) : []

  disks = { for item in local.disks_list: 
     keys(item)[0] => values(item)[0]
  }

  lvs_list = var.vg_disks != "" ? flatten([
    for vg_key, vg_def in var.vg_disks : [
        for idx, lv_def in vg_def.lvs: {
            format("%s", lv_def.lv_name) = { vg_name = vg_key, lv_size = lv_def.lv_size, mount_point = lv_def.mount_point }
        }
    ]
  ]) : []

  lvs = { for item in local.lvs_list: 
     keys(item)[0] => values(item)[0]
  }

  selected_custom_images = [
    for image in data.oci_core_images.custom_images_list.images : image if lookup(image.freeform_tags, "OS_NAME", "") == var.operating_system_name && lookup(image.freeform_tags, "OS_VERSION", "") == var.operating_system_version
  ]
  
  selected_image = var.image_id != "" ? var.image_id : (length(data.oci_core_images.plataform_images_list.images) > 0 ? data.oci_core_images.plataform_images_list.images[0].id : local.selected_custom_images[0].id)

  freeform_tags = {
    "OS_NAME" = var.operating_system_name
    "OS_VERSION" = var.operating_system_version
  }

  defined_tags = merge(
    {"Finance.Project" = var.project_name},
    {"CIO.ENV" = var.env},
    (var.env == "PROD") ? {} : var.running_period
  )

  backup_policy_name = (var.backup_policy_name == "") ? (var.env == "PROD" ? "gold" : "silver") : var.backup_policy_name

  final_shell = flatten([
    "export timezone='${var.ambientes[var.ambiente].timezone}'",
    "export proxy='${var.ambientes[var.ambiente].proxy}'",
    "export ssh_public_key_root='${var.ambientes[var.ambiente].root_ssh_public_key}'",
    "export ssh_public_key_hpadmin='${var.ambientes[var.ambiente].hpadmin_ssh_public_key}'",
    var.def_init_shell, var.init_shell])

  is_flex = length(regexall(".*Flex", var.shape)) > 0
}
