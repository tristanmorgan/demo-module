data "vault_pki_secret_backend_issuers" "intca" {
  backend = "intca"
}

locals {
  default_issuer = one([for key, val in data.vault_pki_secret_backend_issuers.intca.key_info : key if jsondecode(val).is_default])
}

import {
  id = "intca/roles/servers"
  to = vault_pki_secret_backend_role.servers
}

resource "vault_pki_secret_backend_role" "servers" {
  backend          = "intca"
  name             = "servers"
  allowed_domains  = ["consul", "nomad", "local"]
  allow_subdomains = true
  allow_localhost  = true
  generate_lease   = false
  no_store         = true
  ttl              = "5184000"
  max_ttl          = "7776000"
  key_bits         = 256
  key_type         = "ec"
  key_usage = [
    "DigitalSignature",
    "KeyAgreement",
    "KeyEncipherment",
  ]
}

resource "vault_pki_secret_backend_cert" "vault" {
  auto_renew           = true
  backend              = vault_pki_secret_backend_role.servers.backend
  name                 = vault_pki_secret_backend_role.servers.name
  common_name          = "${local.default_issuer}.vault.service.home.consul"
  exclude_cn_from_sans = true
  alt_names = [
    "vault.service.${var.consul_datacenter}.consul",
    "vault.service.consul",
    "localhost",
  ]
  ip_sans = [
    "127.0.0.1"
  ]
  ttl = "50d"
}

resource "local_sensitive_file" "vault_cert_pem" {
  content  = <<-EOT
    ${vault_pki_secret_backend_cert.vault.certificate}
    ${vault_pki_secret_backend_cert.vault.ca_chain}
  EOT
  filename = "${path.module}/vault-${var.consul_datacenter}-server.pem"

  file_permission = "0644"
}

resource "local_sensitive_file" "vault_key_pem" {
  content  = vault_pki_secret_backend_cert.vault.private_key
  filename = "${path.module}/vault-${var.consul_datacenter}-server-key.pem"

  file_permission = "0600"
}
