resource "google_iam_workload_identity_pool" "main" {
  provider                  = google-beta
  project                   = var.project_id
  workload_identity_pool_id = var.workload_identity_pool_id
  display_name              = var.workload_identity_pool_id
  description               = var.workload_identity_pool_description
  disabled                  = false
}
resource "google_iam_workload_identity_pool_provider" "main" {
  provider                           = google-beta
  project                            = var.project_id
  workload_identity_pool_id          = google_iam_workload_identity_pool.main.workload_identity_pool_id
  workload_identity_pool_provider_id = var.workload_identity_pool_provider_id
  display_name                       = var.workload_identity_pool_provider_id
  description                        = var.workload_identity_pool_provider_description
  attribute_condition                = coalesce(var.attribute_condition, "attribute.account == '${var.aws_account_id}'")
  attribute_mapping                  = var.attribute_mapping
  aws {
    account_id = var.aws_account_id
  }
}
resource "google_service_account_iam_member" "wif-sa" {
  for_each = {
    for m in var.service_account_mappings
    : m.id => m
  }
  service_account_id = "projects/${var.project_id}/serviceAccounts/${each.value.email}"
  role               = "roles/iam.workloadIdentityUser"
  member             = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.main.name}/${each.value.attribute}"
}
