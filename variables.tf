variable "ssh_public_key" {}
variable "ssh_private_key" {}
variable "tenancy_ocid" {}
variable "instance_compartment_name" {}
variable "vcn_compartment_name" {}
variable "ambiente" {}
variable "ad_number" {}
variable "hostname" {}
variable "shape" {}
variable "ocpus" {
    default = ""
}
variable "memory" {
    default = ""
}
variable "vcn_name" {}
variable "subnet_name" {}
variable "project_name" {}
variable "running_period" {
  default = { "RUNNING_PERIOD.WEEKDAYS_8_20" = "2"}
}
variable "env" {}
variable "backup_policy_name" {
    default = ""
}
variable "operating_system_name" {
    default = "Oracle Linux"
}
variable "operating_system_version" {
    default = "7.9"
}
variable "image_id" {
    default = ""
}
variable "vg_disks" {
  default = {
  }
}

variable "ambientes" {
  default = {
    "TDECLNOPROD" = {
      proxy = "http://10.12.30.131:3128",
      timezone = "America/Santiago",
      root_ssh_public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDJHtu0JdBpqkQzhZeNqYJDaRtd1QICKIYjIfyOpsf0kv0g+xK3QSQwGy0Z0phvL+R9hn/tmbO62US0YUJkF+/+ifKxyBlG9knaCht4SQtlNzdxVe5ff9GRir6nGiZj0mN6SRR7F6/fqRQ0XLdgSMRY4ZBnsjwG4FhaDparTl9a+Xbm4MwvA9DofhUlqi9M6jiMIVf+vph49l+BYmZaL6mJtryLkZ6RdB0JR4xuEq5UpS3nA9zjg0e7dpU9BKcIEG2sIH/2a7v+TRcIMbdQFdVyyZXBiGYnWLpFGQwJmUrAOd7htsmmO6GYy21H8f+8Xc6PsxN6Z3+FYnlgYkEN9Lql root@CDV1OTADMAPV01",
      hpadmin_ssh_public_key = ""
    },
    "TDECLPROD" = {
      proxy = "http://10.52.133.139:3128",
      timezone = "America/Santiago",
      root_ssh_public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCjuAiJwd7zzdH5WM9quiaTNdKkdeI1dOIdmsNGCBBqfb9kNBofoY4NO8Zuj1P+j0Jf3/KKBQxsVjJavCxascoGJKdlBPqLmbEPHp14wjX42yOyf4xtB5M4qL2kQe0AMRKW03CwxDnqGQz0vbYfgGqFe2okvsjOjbwiiDG4VlQAEcXeLLyx+0Oi/bAcX3W6WoknzNnQr90zrDq5lpMmdljNk71/JgJjkQWAYCvf7XDZlr44nFxpYj7xG8zoBH4FUVngH0sPUvXxAw4KrLudqJRgTzDvnBdpCIZshYYEgDV6TFOosZiJ+BJUwrt0ybEFep8v80Co261Ad7C7WolDzhdF root@cdv1pradmapv01\nssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC1LCQXb7KVI4CuNQeOAYGgS9scUGDE3uhkfpxgDcDSkX27gYfKH763WXgm+Kzh0ZaPzE+aIVxbc12veHOlbEtd17ZJEQFcXg0neeIk6lNfdqI0Z4CXPnBOKwTJgZkzURi6QW1enc6UyJhtPJEgJ2fYZQVR8SLZwo7K3NSQaeq0FI5Nnif25UCjTXXYBnhwW4KZYalclf72VbXIWpRVrlf6e1EWPIXsyPu/cBkTGQvZqu1rIO14R3COQRN2CWQ9k70pixeIfxlxNNA4GohG+i8zLn8A2HJZYqcvhM+vq7ZniDgd9tdcfhhGLYpfvJBoUOM+RQFL+lspNAXBg8Z8viWUWVkG2bYY+SJp4NBcD5Gph9c2QMcmvi3jj+J3CY4wnYLxoehMm4dLmfVYkNN+auK45re+/tqs7evR8DvRnSndMRsjdmBGejE+uACfHfeRVDIoo7UraFiQgl/j+3xTw/2RpCREsof0+GGgc1N/nqlyLRU3k5nICk/Qb4pgoY3+t98= root@cdv1pransbapv01",
      hpadmin_ssh_public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCZItXqAY2+sn/nuZj3JVDyxG2qkHNHyQcQrZerzy6dlKgoa6/g3ksy7n+1JmjLBGSkjjz7tuoVazoiYUyfD9CPNC2LVQbgBQ1xwqGhIWY2kAHC1TlMft2LI47133FQyARwacr8vMYPGLxfTqnagyayq3gWEx3SyP0kHxo8TCCriT1VF5JGBxj2lm117B9GEZbX5L81gIJsCqluJxQ/QTeLfuk4XrDmS2SLUUjmqpC5vbbDKu0kEYqiClS0Ugz5e5BvnUhR854VlWbYzcoCKwcBT0mkayoq3mqDJKqBFg0AtoUkt1bvudPF8/c8GM9azhUAfdb4wVr+JqramSMuHyAF"
    },
    "TDEPENOPROD" = {
      proxy = "http://172.30.21.132:3128",
      timezone = "America/Lima",
      root_ssh_public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQClJyiZRD22qsdZrXhddtTbgrSzvAlCw78pChdivAxkgl6qE47VLpmzR12TyvT6ry4tNlk8hHgOOg/1kXJPI3KqbhVw663/UK+btfs8z7JI4lU7TRPVskkxBIlyEg7osZaeYgwYR0Epgu5MuL+CAmnVY/sKa9q+ECaSpRkG0k9nyFVcB8zG5iFjYdvd76PNxU2zEF6w7Yhzqh49/bfRZMl2UJdVKnxtuVizmbkdM2N2IVrwNI1M83uSqjrB5tE88IbvN4d483DmGPeYBc8K1+xHlgVvQbsFUFDBuh9BkzbkA5xYx804x6qdIr76nSIyw2ly2FfJyN037rF4PKS7sK7P root@SBJ1OTADMAPV01",
      hpadmin_ssh_public_key = ""
    },
    "TDEPEPROD" = {
      proxy = "http://172.30.29.138:3128",
      timezone = "America/Lima",
      root_ssh_public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC6qAqxQGxp4C5GgyYUmfP7/jPbix6/8C76OyF9GW+OoBibXPbqQLENUUH0mcmFXjHvwc/geMk5jA7laATIsuLglRiqApZ677c8WF2so2eVpqHRTzPTE5R6ehdg40bc2n9ONPaRXjhEZfSo9l8j/EU8yRElgRYdQmA97ac/QYkm1dUISQNYzEx9TMZ0CQYsbRdmGtvYavI2JEmkfxlHv5UFzlbGVH4jx552copNDVBdMg+mhdks+Bk0ln8sJnl6QzVGLH0PWyg64ok+AVmJn+S/RyShpOsuZqhF5hvOk7nrtTU/dxcKHaZXg9HNkM0rw0xF6hEw7Cwdjv4587Kpc/mF root@olg1pradmapv01\nssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCuMHDGcXGBFeScoP0AeGdhzV8wYwm3oFfRozzzjjC2Iyqh7fGS2WWa6oaZ2G+LytM8jfwLc+tcMwy33Weil0quwrryuXHDbOYqvZWfQGEYeWo0NUjB/skrhC1kEXbu0ekbGwuaXwzmhDgV/2YnK+u66atBbL8E3OwIT6a9pHGLx5cdNuOYwEIgRcvcCJlRIwgAg3tRoGKBn1xXLJYzipP4zlhbXAtC88jlbHnPCIW8I98F72VWf8G9rJnNmo+sYxJMvitKxlGJz9eqQ77CIhzw3qFPSelnuilVEpi0ffzlc2fCdtuuKQqaMM29eyFmSCCS07+Fq25liTO9CPBFcFTVte6D0Y437rhuKYDW1Clep/KkqpKU1jVBsfMG5J4D1i6722Q5Q5lZTkooTwY6JnONHW+571hT1Q464F83puOULykH+GKLud93aUFRIGOoYFX9/h1COOSI4uc6M3BX52aJWeyMKbbdB3jWgcrwUdjGNmq3P+eem3E7It/zh8aiCdk= root@olg1pransbapv01",
      hpadmin_ssh_public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDHPwVe081p4YxOUKSdpJkM08O0dEqfjw5Cap/psEMxOeDihGwE6STLT4eyIV+tlEhIcEy59a37YFob8Gmr8UB8kiCKH5VOUroULwltjbJ1kL14t9XtHpOOSJYs1ZQKsceEk32rGlMoCu5vPXveR+SeyWBrm3jGA/LxbmbU5emRjqEuy0apmu9QnTOHQbLSke80bJgfZXZJunIsR4g0OX0+e3TjNm+onxLbi7qWoXzVX+hNROSAOzkQXmPI/C3vqwaCzHKfoIuY7eAsjEPY2enGnGSBvY2RrlWvPh/YJiUFfDD+JsGj9nKAEysO5pvyLPkwT4GtjikYckLPecWgVSwD hpadmin@olg1prsisapv01"
    },
    "TDECLPROD-STG" = {
      proxy = "",
      timezone = "America/Santiago",
      root_ssh_public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCjuAiJwd7zzdH5WM9quiaTNdKkdeI1dOIdmsNGCBBqfb9kNBofoY4NO8Zuj1P+j0Jf3/KKBQxsVjJavCxascoGJKdlBPqLmbEPHp14wjX42yOyf4xtB5M4qL2kQe0AMRKW03CwxDnqGQz0vbYfgGqFe2okvsjOjbwiiDG4VlQAEcXeLLyx+0Oi/bAcX3W6WoknzNnQr90zrDq5lpMmdljNk71/JgJjkQWAYCvf7XDZlr44nFxpYj7xG8zoBH4FUVngH0sPUvXxAw4KrLudqJRgTzDvnBdpCIZshYYEgDV6TFOosZiJ+BJUwrt0ybEFep8v80Co261Ad7C7WolDzhdF root@cdv1pradmapv01\nssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC1LCQXb7KVI4CuNQeOAYGgS9scUGDE3uhkfpxgDcDSkX27gYfKH763WXgm+Kzh0ZaPzE+aIVxbc12veHOlbEtd17ZJEQFcXg0neeIk6lNfdqI0Z4CXPnBOKwTJgZkzURi6QW1enc6UyJhtPJEgJ2fYZQVR8SLZwo7K3NSQaeq0FI5Nnif25UCjTXXYBnhwW4KZYalclf72VbXIWpRVrlf6e1EWPIXsyPu/cBkTGQvZqu1rIO14R3COQRN2CWQ9k70pixeIfxlxNNA4GohG+i8zLn8A2HJZYqcvhM+vq7ZniDgd9tdcfhhGLYpfvJBoUOM+RQFL+lspNAXBg8Z8viWUWVkG2bYY+SJp4NBcD5Gph9c2QMcmvi3jj+J3CY4wnYLxoehMm4dLmfVYkNN+auK45re+/tqs7evR8DvRnSndMRsjdmBGejE+uACfHfeRVDIoo7UraFiQgl/j+3xTw/2RpCREsof0+GGgc1N/nqlyLRU3k5nICk/Qb4pgoY3+t98= root@cdv1pransbapv01",
      hpadmin_ssh_public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCZItXqAY2+sn/nuZj3JVDyxG2qkHNHyQcQrZerzy6dlKgoa6/g3ksy7n+1JmjLBGSkjjz7tuoVazoiYUyfD9CPNC2LVQbgBQ1xwqGhIWY2kAHC1TlMft2LI47133FQyARwacr8vMYPGLxfTqnagyayq3gWEx3SyP0kHxo8TCCriT1VF5JGBxj2lm117B9GEZbX5L81gIJsCqluJxQ/QTeLfuk4XrDmS2SLUUjmqpC5vbbDKu0kEYqiClS0Ugz5e5BvnUhR854VlWbYzcoCKwcBT0mkayoq3mqDJKqBFg0AtoUkt1bvudPF8/c8GM9azhUAfdb4wVr+JqramSMuHyAF"
    }
  }
}
variable "def_init_shell" {
  default = [
    "sudo sed -E 's/^#?X11UseLocalhost.*/X11UseLocalhost no/g' /etc/ssh/sshd_config -i",
    "sudo sed -E 's/^#?X11Forwarding.*/X11Forwarding yes/g' /etc/ssh/sshd_config -i",
    "sudo sed -E 's/^#?PasswordAuthentication.*/PasswordAuthentication yes/g' /etc/ssh/sshd_config -i",
    "sudo sed -E 's/^#?PermitRootLogin.*/PermitRootLogin yes/g' /etc/ssh/sshd_config -i",
    "sudo service sshd restart",
    "sudo systemctl stop firewalld",
    "sudo systemctl disable firewalld",
    "sudo setenforce 0",
    "sudo sed 's/SELINUX=.*/SELINUX=permissive/g' /etc/selinux/config -i",
    "echo proxy=$proxy | sudo tee -a /etc/yum.conf",
    "sudo unlink /etc/localtime",
    "sudo ln -s /usr/share/zoneinfo/$timezone /etc/localtime",
    "echo $ssh_public_key_root | sudo tee -a /root/.ssh/authorized_keys",
    "sudo chmod 700 /root/.ssh",
    "sudo chmod 600 /root/.ssh/authorized_keys",
    "sudo adduser hpadmin",
    "sudo -u hpadmin mkdir /home/hpadmin/.ssh/",
    "echo $ssh_public_key_hpadmin | sudo -u hpadmin tee -a /home/hpadmin/.ssh/authorized_keys",
    "sudo chmod 700 /home/hpadmin/.ssh/",
    "sudo chmod 600 /home/hpadmin/.ssh/authorized_keys"
  ]
}
variable "init_shell" {
  default = []
}
variable "assign_public_ip" {
  default = "false"
}

variable "region" {
  default = ""
}