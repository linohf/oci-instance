resource "time_sleep" "wait_instance_boot" {
    depends_on = [ oci_core_instance.instance ]
    create_duration = "300s"
}

resource "tls_private_key" "bastion_key" {
  algorithm   = "RSA"
}

resource "oci_bastion_session" "instance_bastion_session" {
    depends_on = [ time_sleep.wait_instance_boot ]

    bastion_id = data.oci_bastion_bastions.bastions.bastions[0].id

    key_details {
        #public_key_content = "${file("${var.module_name}/bastion.pub")}"
        public_key_content = tls_private_key.bastion_key.public_key_openssh
    }

    target_resource_details {
        session_type       = "MANAGED_SSH"
        target_resource_id = oci_core_instance.instance.id

        target_resource_operating_system_user_name = "opc"
        target_resource_port                       = 22
    }

    display_name           = "ProvisioningSession-${var.hostname}"
    key_type               = "PUB"
    session_ttl_in_seconds = 1800
}

resource "null_resource" "instance_provision_remote_exec" {
    connection {
        type                = "ssh"
        user                = "opc"
        host                = oci_core_instance.instance.private_ip
        private_key         = var.ssh_private_key
        agent               = false
        timeout             = "10m"
        bastion_host        = "host.bastion.${var.region}.oci.oraclecloud.com"
        bastion_port        = "22"
        bastion_user        = oci_bastion_session.instance_bastion_session.id
        bastion_private_key =  tls_private_key.bastion_key.private_key_pem
    }

    provisioner "remote-exec" {
        inline = local.final_shell
    }
}

resource "null_resource" "lvs" {
  for_each = local.lvs
  depends_on = [ oci_core_volume_attachment.instance_volume_attachments ]
  triggers = {
    #attachments_ids = join(",", oci_core_volume_attachment.instance_volume_attachments.*.id)
    #lvs = local.lvs
    always_run = timestamp()
  }

  connection {
        type                = "ssh"
        user                = "opc"
        host                = oci_core_instance.instance.private_ip
        private_key         = var.ssh_private_key
        agent               = false
        timeout             = "10m"
        bastion_host        = "host.bastion.${var.region}.oci.oraclecloud.com"
        bastion_port        = "22"
        bastion_user        = oci_bastion_session.instance_bastion_session.id
        bastion_private_key =  tls_private_key.bastion_key.private_key_pem
  }

  provisioner "remote-exec" {
    inline = [
    "exec 200> /tmp/tf_lvm_create.lock",
    "flock -x 200",
    "size=$(sudo lvdisplay /dev/mapper/${each.value.vg_name}-${each.key} 2> /dev/null | grep 'Current LE' | awk '{print $3}')",
    "if [ -z $size ]; then",
    "  size=0",
    "fi",
    "free_vg_extent=$(sudo vgs ${each.value.vg_name} -o +vg_free_count | grep ${each.value.vg_name} | awk '{print $8}')",
    "needed_free_vg_extent=$(( (${each.value.lv_size}*1024)/4 - $size ))",
    "diff_extent=$(($free_vg_extent-$needed_free_vg_extent))",
    "if [ $diff_extent -ge 0 ]; then",
    "  new_extent=$(( $needed_free_vg_extent + $size ))",
    "elif [ $diff_extent -ge -25 ]; then",
    "  new_extent=$(( $free_vg_extent + $size ))",
    "else",
    "  echo insufficient free space for ${each.value.vg_name}-${each.key}",
    "  exit -1",
    "fi",
    "if [ $size -eq 0 ]; then",
    "  sudo lvcreate -n ${each.key} ${each.value.vg_name} -l $new_extent",
    "  sudo mkfs.xfs /dev/mapper/${each.value.vg_name}-${each.key}",
    "  sudo mkdir -p ${each.value.mount_point}",
    "  echo '/dev/mapper/${each.value.vg_name}-${each.key}      ${each.value.mount_point}  xfs     _netdev,nofail        0 0' | sudo tee -a /etc/fstab",
    "  sudo mount ${each.value.mount_point}",
    "elif [ $new_extent -eq $size ]; then",
    "  echo Size already ${each.value.lv_size}G for ${each.value.vg_name}-${each.key}",
    "else",
    "  sudo lvextend -l $new_extent /dev/mapper/${each.value.vg_name}-${each.key}",
    "  sudo xfs_growfs ${each.value.mount_point}",
    "fi",
    "flock -u 200"
    ]
  }
}