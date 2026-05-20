variable "nomad_region" {
  description = "value of the nomad region (eg. global)"
  default     = "global"
  type        = string
}

resource "vault_pki_secret_backend_cert" "nomad_server" {
  auto_renew           = true
  backend              = vault_pki_secret_backend_role.servers.backend
  name                 = vault_pki_secret_backend_role.servers.name
  common_name          = "${local.default_issuer}.server.${var.nomad_region}.nomad"
  exclude_cn_from_sans = true
  alt_names = [
    "server.${var.nomad_region}.nomad",
    "nomad.service.${var.consul_datacenter}.consul",
    "nomad.service.consul",
    "localhost",
  ]
  ip_sans = [
    "127.0.0.1"
  ]
  ttl = "50d"
}

resource "local_sensitive_file" "nomad_cert_pem" {
  content  = <<-EOT
    ${vault_pki_secret_backend_cert.nomad_server.certificate}
    ${vault_pki_secret_backend_cert.nomad_server.ca_chain}
  EOT
  filename = "${path.module}/${var.nomad_region}-server-nomad.pem"

  file_permission = "0644"
}

resource "local_sensitive_file" "nomad_key_pem" {
  content  = vault_pki_secret_backend_cert.nomad_server.private_key
  filename = "${path.module}/${var.nomad_region}-server-nomad-key.pem"

  file_permission = "0600"
}

resource "vault_pki_secret_backend_cert" "nomad_client" {
  auto_renew           = true
  backend              = vault_pki_secret_backend_role.servers.backend
  name                 = vault_pki_secret_backend_role.servers.name
  common_name          = "${local.default_issuer}.client.${var.nomad_region}.nomad"
  exclude_cn_from_sans = true
  alt_names = [
    "client.${var.nomad_region}.nomad",
    "localhost",
  ]
  ip_sans = [
    "127.0.0.1"
  ]
  ttl = "50d"
}

resource "local_sensitive_file" "nomad_client_cert_pem" {
  content  = <<-EOT
    ${vault_pki_secret_backend_cert.nomad_client.certificate}
    ${vault_pki_secret_backend_cert.nomad_client.ca_chain}
  EOT
  filename = "${path.module}/${var.nomad_region}-client-nomad.pem"

  file_permission = "0644"
}

resource "local_sensitive_file" "nomad_client_key_pem" {
  content  = vault_pki_secret_backend_cert.nomad_client.private_key
  filename = "${path.module}/${var.nomad_region}-client-nomad-key.pem"

  file_permission = "0600"
}
