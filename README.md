## Requirements

No requirements.

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_local"></a> [local](#provider\_local) | 2.5.3 |
| <a name="provider_vault"></a> [vault](#provider\_vault) | 5.4.0 |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [local_sensitive_file.consul_cert_pem](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/sensitive_file) | resource |
| [local_sensitive_file.consul_client_cert_pem](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/sensitive_file) | resource |
| [local_sensitive_file.consul_client_key_pem](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/sensitive_file) | resource |
| [local_sensitive_file.consul_key_pem](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/sensitive_file) | resource |
| [local_sensitive_file.nomad_cert_pem](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/sensitive_file) | resource |
| [local_sensitive_file.nomad_client_cert_pem](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/sensitive_file) | resource |
| [local_sensitive_file.nomad_client_key_pem](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/sensitive_file) | resource |
| [local_sensitive_file.nomad_key_pem](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/sensitive_file) | resource |
| [local_sensitive_file.vault_cert_pem](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/sensitive_file) | resource |
| [local_sensitive_file.vault_key_pem](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/sensitive_file) | resource |
| [vault_pki_secret_backend_cert.consul_client](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/pki_secret_backend_cert) | resource |
| [vault_pki_secret_backend_cert.consul_server](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/pki_secret_backend_cert) | resource |
| [vault_pki_secret_backend_cert.nomad_client](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/pki_secret_backend_cert) | resource |
| [vault_pki_secret_backend_cert.nomad_server](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/pki_secret_backend_cert) | resource |
| [vault_pki_secret_backend_cert.vault](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/pki_secret_backend_cert) | resource |
| [vault_pki_secret_backend_role.servers](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/pki_secret_backend_role) | resource |
| [vault_pki_secret_backend_issuers.intca](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/data-sources/pki_secret_backend_issuers) | data source |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_consul_datacenter"></a> [consul\_datacenter](#input\_consul\_datacenter) | value of the consul datacenter (eg. dc1) | `string` | `"dc1"` | no |
| <a name="input_nomad_region"></a> [nomad\_region](#input\_nomad\_region) | value of the nomad region (eg. global) | `string` | `"global"` | no |

## Outputs

No outputs.
