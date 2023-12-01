# gcp-aws-oidc

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |
| <a name="provider_google-beta"></a> [google-beta](#provider\_google-beta) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google-beta_google_iam_workload_identity_pool.main](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_iam_workload_identity_pool) | resource |
| [google-beta_google_iam_workload_identity_pool_provider.main](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_iam_workload_identity_pool_provider) | resource |
| [google_service_account_iam_member.wif-sa](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_iam_member) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_attribute_condition"></a> [attribute\_condition](#input\_attribute\_condition) | The attribute condition for the workload identity pool provider. (default = 'attribute.account == var.aws\_account\_id') | `string` | `""` | no |
| <a name="input_attribute_mapping"></a> [attribute\_mapping](#input\_attribute\_mapping) | Workload Identity Pool Provider attribute mapping.<br>Your attribute mappings can use [the response fields for GetCallerIdentity](https://docs.aws.amazon.com/STS/latest/APIReference/API_GetCallerIdentity.html) as source attributes.<br>[More info](https://cloud.google.com/iam/docs/configuring-workload-identity-federation#mappings-and-conditions) | `map(string)` | <pre>{<br>  "attribute.account": "assertion.account",<br>  "attribute.arn": "assertion.arn",<br>  "attribute.aws_account": "assertion.account",<br>  "attribute.aws_iam_assumed_role": "assertion.arn.extract(':assumed-role/{resource_id}/')",<br>  "attribute.aws_iam_federated_user": "assertion.arn.extract(':federated-user/{resource_id}')",<br>  "attribute.aws_iam_group": "assertion.arn.extract(':group/{resource_id}')",<br>  "attribute.aws_iam_instance_profile": "assertion.arn.extract(':instance-profile/{resource_id}')",<br>  "attribute.aws_iam_mfa": "assertion.arn.extract(':mfa/{resource_id}')",<br>  "attribute.aws_iam_oidc_provider": "assertion.arn.extract(':oidc-provider/{resource_id}')",<br>  "attribute.aws_iam_policy": "assertion.arn.extract(':policy/{resource_id}')",<br>  "attribute.aws_iam_resource_type": "assertion.arn.contains(':root') ? 'root' : assertion.arn.extract(':{resource_type}/')",<br>  "attribute.aws_iam_role": "assertion.arn.extract(':role/{resource_id}')",<br>  "attribute.aws_iam_saml_provider": "assertion.arn.extract(':saml-provider/{resource_id}')",<br>  "attribute.aws_iam_server_certificate": "assertion.arn.extract(':server-certificate/{resource_id}')",<br>  "attribute.aws_iam_u2f": "assertion.arn.extract(':u2f/{resource_id}')",<br>  "attribute.aws_iam_user": "assertion.arn.extract(':user/{resource_id}')",<br>  "attribute.userid": "assertion.userid",<br>  "google.subject": "assertion.arn"<br>}</pre> | no |
| <a name="input_aws_account_id"></a> [aws\_account\_id](#input\_aws\_account\_id) | The AWS Account ID for attribute condition. | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The GCP project ID | `string` | n/a | yes |
| <a name="input_service_account_mappings"></a> [service\_account\_mappings](#input\_service\_account\_mappings) | Service Account resource names and corresponding WIF provider attributes. If attribute is set to `*` all identities in the pool are granted access to SAs. | <pre>list(object({<br>    id        = string # This `id` is only used internally in `for` expressions.<br>    email     = string<br>    attribute = string<br>  }))</pre> | `[]` | no |
| <a name="input_workload_identity_pool_description"></a> [workload\_identity\_pool\_description](#input\_workload\_identity\_pool\_description) | Workload Identity Pool description for AWS | `string` | `"Workload Identity Pool for AWS"` | no |
| <a name="input_workload_identity_pool_id"></a> [workload\_identity\_pool\_id](#input\_workload\_identity\_pool\_id) | Workload Identity Pool ID for AWS | `string` | `"aws-oidc-pool"` | no |
| <a name="input_workload_identity_pool_provider_description"></a> [workload\_identity\_pool\_provider\_description](#input\_workload\_identity\_pool\_provider\_description) | Workload Identity Pool Provider for AWS | `string` | `"Workload Identity Pool Provider description for AWS"` | no |
| <a name="input_workload_identity_pool_provider_id"></a> [workload\_identity\_pool\_provider\_id](#input\_workload\_identity\_pool\_provider\_id) | Workload Identity Pool Provider id for AWS | `string` | `"aws-oidc-provider"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_pool_name"></a> [pool\_name](#output\_pool\_name) | Pool name |
| <a name="output_provider_name"></a> [provider\_name](#output\_provider\_name) | Provider name |
<!-- END_TF_DOCS -->
