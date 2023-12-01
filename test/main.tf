resource "google_service_account" "aws_oidc" {
  account_id   = "aws-oidc"
  display_name = "aws-oidc"
  description  = "aws-oidc"
}
module "github_oidc" {
  source         = "../"
  aws_account_id = "9999999999999999"
  service_account_mappings = [
    { id = "test", email = google_service_account.aws_oidc.email, attribute = "*" },
  ]
}
