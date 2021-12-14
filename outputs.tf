output "svc_acct_email" {
  value = (var.existing_svc_acct_email != "") ? var.existing_svc_acct_email : toString(try(google_service_account.secret_accessor[0].email, null))
}
