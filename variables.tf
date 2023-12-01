variable "project_id" {
  type        = string
  description = "The GCP project ID"
}
variable "workload_identity_pool_id" {
  type        = string
  default     = "aws-oidc-pool"
  description = "Workload Identity Pool ID for AWS"
}
variable "workload_identity_pool_description" {
  type        = string
  default     = "Workload Identity Pool for AWS"
  description = "Workload Identity Pool description for AWS"
}
variable "workload_identity_pool_provider_id" {
  type        = string
  default     = "aws-oidc-provider"
  description = "Workload Identity Pool Provider id for AWS"
}
variable "workload_identity_pool_provider_description" {
  type        = string
  default     = "Workload Identity Pool Provider description for AWS"
  description = "Workload Identity Pool Provider for AWS"
}
variable "aws_account_id" {
  type        = string
  description = "The AWS Account ID for attribute condition."
}
variable "attribute_condition" {
  type        = string
  default     = "" # format("attribute.account == '%s'", var.aws_account_id)
  description = "The attribute condition for the workload identity pool provider. (default = 'attribute.account == var.aws_account_id')"
}
variable "attribute_mapping" {
  type        = map(string)
  description = <<-EOF
  Workload Identity Pool Provider attribute mapping.
  Your attribute mappings can use [the response fields for GetCallerIdentity](https://docs.aws.amazon.com/STS/latest/APIReference/API_GetCallerIdentity.html) as source attributes.
  [More info](https://cloud.google.com/iam/docs/configuring-workload-identity-federation#mappings-and-conditions)
  EOF
  default = {
    # NOTE: I want to use "assertion.arn" as "google.subject", but "google.subject" must be less than 127 bytes.
    #       So, you may need to change the value of this subject.
    #       The following error message is shown on audit logging if the length of "google.subject" is exceeded.
    #       > The size of mapped attribute google.subject exceeds the 127 bytes limit. Either modify your attribute mapping or the incoming assertion to produce a mapped attribute that is less than 127 bytes.
    "google.subject"        = "assertion.arn" 
    "attribute.arn"         = "assertion.arn"
    "attribute.account"     = "assertion.account"
    "attribute.userid"      = "assertion.userid"
    "attribute.aws_account" = "assertion.account"
    # https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_identifiers.html#identifiers-arns
    "attribute.aws_iam_resource_type"      = "assertion.arn.contains(':root') ? 'root' : assertion.arn.extract(':{resource_type}/')"
    "attribute.aws_iam_user"               = "assertion.arn.extract(':user/{resource_id}')"
    "attribute.aws_iam_group"              = "assertion.arn.extract(':group/{resource_id}')"
    "attribute.aws_iam_role"               = "assertion.arn.extract(':role/{resource_id}')"
    "attribute.aws_iam_policy"             = "assertion.arn.extract(':policy/{resource_id}')"
    "attribute.aws_iam_instance_profile"   = "assertion.arn.extract(':instance-profile/{resource_id}')"
    "attribute.aws_iam_federated_user"     = "assertion.arn.extract(':federated-user/{resource_id}')"
    "attribute.aws_iam_assumed_role"       = "assertion.arn.extract(':assumed-role/{resource_id}/')" # arn:aws:sts::account:assumed-role/role-name/role-session-name
    "attribute.aws_iam_mfa"                = "assertion.arn.extract(':mfa/{resource_id}')"
    "attribute.aws_iam_u2f"                = "assertion.arn.extract(':u2f/{resource_id}')"
    "attribute.aws_iam_server_certificate" = "assertion.arn.extract(':server-certificate/{resource_id}')"
    "attribute.aws_iam_saml_provider"      = "assertion.arn.extract(':saml-provider/{resource_id}')"
    "attribute.aws_iam_oidc_provider"      = "assertion.arn.extract(':oidc-provider/{resource_id}')"
  }
}
variable "service_account_mappings" {
  type = list(object({
    id        = string # This `id` is only used internally in `for` expressions.
    email     = string
    attribute = string
  }))
  description = "Service Account resource names and corresponding WIF provider attributes. If attribute is set to `*` all identities in the pool are granted access to SAs."
  default     = []
  validation {
    condition     = length(var.service_account_mappings) == length(distinct([for m in var.service_account_mappings : m.id]))
    error_message = "The 'id' must be unique."
  }
}
