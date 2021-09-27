data "google_compute_image" "coreos" {
  family  = var.image_family
  project = var.image_project
}

data "ignition_systemd_unit" "squid" {
  name    = "squid.service"
  enabled = true
  content = <<EOS
[Unit]
Description=Squid Proxy
After=network-online.target
Wants=network-online.target

[Service]
TimeoutStartSec=0
ExecStartPre=-/bin/podman kill squid
ExecStartPre=-/bin/podman rm squid
ExecStartPre=/bin/podman pull ${var.squid_container_image}

# configure iptables
ExecStartPre=/usr/sbin/iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-port 3129
ExecStartPre=/usr/sbin/iptables -t nat -A PREROUTING -p tcp --dport 443 -j REDIRECT --to-port 3130

ExecStart=/bin/podman run --name squid --network host \
          --env DOMAIN_WHITELIST=${join(",", var.domain_whitelist)} \
          ${var.squid_container_image}

[Install]
WantedBy=multi-user.target
EOS
}

data "ignition_user" "core" {
  name                = "core"
  ssh_authorized_keys = var.core_authorized_keys
}

data "ignition_config" "squid" {
  systemd = [
    data.ignition_systemd_unit.squid.rendered,
  ]

  users = [
    data.ignition_user.core.rendered,
  ]
}
