resource "oci_core_instance" "instance" {
    availability_domain = lookup(data.oci_identity_availability_domains.ADs.availability_domains[0],"name")
    compartment_id = lookup(data.oci_identity_compartments.selected_instance_compartment.compartments[0], "id")
    display_name = var.hostname
    shape = var.shape
  
    defined_tags = local.defined_tags

    freeform_tags = local.freeform_tags
    
    source_details {
        source_type = "image"
        source_id = var.image_id != "" ? var.image_id : local.selected_image
    }

    dynamic "shape_config" {
        for_each = local.is_flex ? [1] : []
        content {
            memory_in_gbs = var.memory
            ocpus = var.ocpus
            baseline_ocpu_utilization = "BASELINE_1_1"
        }
    }

    dynamic "launch_options" {
        for_each = var.operating_system_name == "Red Hat Enterprise Linux Server" && local.is_flex ? [1] : []
        content {
            boot_volume_type = "ISCSI"
            network_type = "PARAVIRTUALIZED"
        }
    }

    agent_config {
        plugins_config {
            desired_state = "ENABLED"
            name = "Bastion"
        }
    }

    create_vnic_details {
        subnet_id = lookup(data.oci_core_subnets.selected_subnets.subnets[0],"id")
        display_name = var.hostname
        hostname_label = var.hostname
        assign_public_ip = var.assign_public_ip
    }

    metadata = {
        ssh_authorized_keys = var.ssh_public_key
    }
}

resource "oci_core_volume_attachment" "instance_volume_attachments" {
    for_each = local.disks
    attachment_type = "iscsi"
    use_chap = true
    instance_id = oci_core_instance.instance.id
    volume_id = oci_core_volume.instance_volumes[each.key].id

    display_name = "${oci_core_volume.instance_volumes[each.key].display_name}_attachment"

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
        bastion_private_key = tls_private_key.bastion_key.private_key_pem
    }
	
    provisioner "remote-exec" {
        inline = [
            "sudo iscsiadm -m node -o new -T ${self.iqn} -p ${self.ipv4}:${self.port}",
            "sudo iscsiadm -m node -o update -T ${self.iqn} -n node.startup -v automatic",
            "sudo iscsiadm -m node -T ${self.iqn} -p ${self.ipv4}:${self.port} -o update -n node.session.auth.authmethod -v CHAP",
            "sudo iscsiadm -m node -T ${self.iqn} -p ${self.ipv4}:${self.port} -o update -n node.session.auth.username -v ${self.chap_username}",
            "sudo iscsiadm -m node -T ${self.iqn} -p ${self.ipv4}:${self.port} -o update -n node.session.auth.password -v ${self.chap_secret}",
            "sudo iscsiadm -m node -T ${self.iqn} -p ${self.ipv4}:${self.port} -l",
            "set -x",
            "export DEVICE_ID=ip-${self.ipv4}:${self.port}-iscsi-${self.iqn}-lun-1",
            "while [[ ! -e /dev/disk/by-path/$${DEVICE_ID} ]] ; do sleep 1; done",
            "export HAS_PARTITION=$(sudo partprobe -d -s /dev/disk/by-path/$${DEVICE_ID} | wc -l)",
            "if [ $HAS_PARTITION -eq 0 ] ; then",
            "  sudo parted /dev/disk/by-path/$${DEVICE_ID} mklabel gpt && sudo parted -s /dev/disk/by-path/$${DEVICE_ID} mkpart primary 0 100%",
            "  while [[ ! -e /dev/disk/by-path/$${DEVICE_ID}-part1 ]] ; do sleep 1; done",
            "  sudo pvcreate /dev/disk/by-path/$${DEVICE_ID}-part1",
            "  vgs ${each.value.vg_name} 2> /dev/null",
            "  if [ $? -eq 0 ] ; then",
            "    sudo vgextend ${each.value.vg_name} /dev/disk/by-path/$${DEVICE_ID}-part1",
            "  else",
            "    sudo vgcreate ${each.value.vg_name} /dev/disk/by-path/$${DEVICE_ID}-part1",
            "  fi",
            "fi",
        ]
    }
}