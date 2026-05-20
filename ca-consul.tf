variable "consul_datacenter" {
  description = "value of the consul datacenter (eg. dc1)"
  default     = "dc1"
  type        = string
}

resource "vault_pki_secret_backend_cert" "consul_server" {
  auto_renew           = true
  backend              = vault_pki_secret_backend_role.servers.backend
  name                 = vault_pki_secret_backend_role.servers.name
  common_name          = "${local.default_issuer}.server.${var.consul_datacenter}.consul"
  exclude_cn_from_sans = true
  alt_names = [
    "server.${var.consul_datacenter}.consul",
    "consul.service.${var.consul_datacenter}.consul",
    "consul.service.consul",
    "localhost",
  ]
  ip_sans = [
    "127.0.0.1"
  ]
  ttl = "50d"
}

resource "local_sensitive_file" "consul_cert_pem" {
  content  = <<-EOT
    ${vault_pki_secret_backend_cert.consul_server.certificate}
    ${vault_pki_secret_backend_cert.consul_server.ca_chain}
  EOT
  filename = "${path.module}/consul-${var.consul_datacenter}-server.pem"

  file_permission = "0644"
}

resource "local_sensitive_file" "consul_key_pem" {
  content  = vault_pki_secret_backend_cert.consul_server.private_key
  filename = "${path.module}/consul-${var.consul_datacenter}-server-key.pem"

  file_permission = "0600"
}

resource "vault_pki_secret_backend_cert" "consul_client" {
  auto_renew           = true
  backend              = vault_pki_secret_backend_role.servers.backend
  name                 = vault_pki_secret_backend_role.servers.name
  common_name          = "${local.default_issuer}.client.${var.consul_datacenter}.consul"
  exclude_cn_from_sans = true
  alt_names = [
    "client.${var.consul_datacenter}.consul",
    "localhost",
  ]
  ip_sans = [
    "127.0.0.1"
  ]
  ttl = "50d"
}

resource "local_sensitive_file" "consul_client_cert_pem" {
  content  = <<-EOT
    ${vault_pki_secret_backend_cert.consul_client.certificate}
    ${vault_pki_secret_backend_cert.consul_client.ca_chain}
  EOT
  filename = "${path.module}/consul-${var.consul_datacenter}-client.pem"

  file_permission = "0644"
}

resource "local_sensitive_file" "consul_client_key_pem" {
  content  = vault_pki_secret_backend_cert.consul_client.private_key
  filename = "${path.module}/consul-${var.consul_datacenter}-client-key.pem"

  file_permission = "0600"
}
