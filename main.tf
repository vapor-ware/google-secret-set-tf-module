resource "google_service_account" "secret_accessor" {
  count = var.existing_svc_acct_email ? 0 : 1
  account_id = var.svc_acct_name ? var.svc_acct_name : "${var.prefix}_secrets_accessor"
  display_name = "google_secret_set accessor ${var.svc_acct_name}"
}

data "google_iam_policy" "secrets_access" {
  binding {
    role    = "roles/secretmanager.secretAccessor"
    members = [
      "serviceAccount:${var.existing_svc_acct_email ? var.existing_svc_acct_email : google_service_account.secret_accessor[0].email}"
    ]
  }
}

data "google_kms_secret" "secret_via_kms" {
  count      = length(keys(var.secrets))
  crypto_key = var.crypto_key
  ciphertext = values(var.secrets)[count.index]
}

resource "google_secret_manager_secret" "managed_secret" {
  count     = length(keys(var.secrets))
  secret_id = "${var.prefix}${keys(var.secrets)[count.index]}"
  
  replication {
    automatic = true
  }
}

resource "google_secret_manager_secret_iam_policy" "managed_secret_policy" {
  count       = length(keys(var.secrets))
  secret_id   = google_secret_manager_secret.managed_secret[count.index].id
  policy_data = data.google_iam_policy.secrets_access.policy_data
}

resource "google_secret_manager_secret_version" "managed_secret_version" {
  count  = length(keys(var.secrets))
  secret = google_secret_manager_secret.managed_secret[count.index].id
  secret_data = data.google_kms_secret.secret_via_kms[count.index].plaintext
}
