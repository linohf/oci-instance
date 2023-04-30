output "instance" {
    value = oci_core_instance.instance
}

output "bastion_connection" {
    value = {
        "bastion_host"        = "host.bastion.${var.region}.oci.oraclecloud.com"
        "bastion_port"        = "22"
        "bastion_user"        = oci_bastion_session.instance_bastion_session.id
        "bastion_private_key" = tls_private_key.bastion_key.private_key_pem
    }
}