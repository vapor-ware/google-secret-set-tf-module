# google_secret_set

A Terraform module for implementing [Google Managed Secrets](https://cloud.google.com/secret-manager/docs)

## Compatibility

This module is meant for use with Terraform 0.14

## Introduction

This Terraform module creates one or more managed secrets in a Google Project, along with a service account with iam policy to access those secrets.

The following resources will be created:

one [google_service_account](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_service_account) and corresponding [google_iam_policy](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/iam_policy)

and one of each of the following per defined secret:
- [google_secret_manager_secret](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret)
- [google_secret_manager_secret_version](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret_version)
- [google_secret_manager_secret_iam_policy](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret_iam#google_secret_manager_secret_iam_policy)

Ephemeral [google_kms_secret]() objects are also defined to carry ciphertext to the secret_version, but are not persistently created in the project.

## Usage

To implement this module in your project:
```
module "this-module-implementation" {
  source        = "git::git@github.com:vapor-ware/google-secret-set-tf-module?ref=tags/v1.0.0"
  svc_acct_name = "unique-acct-name"
  crypto_key    = "projects/this-project/locations/this-location/keyRings/this-keyring/cryptoKeys/this-key"
  secrets       = {
    unique_secret_name  = "CipherTextGeneratedFromThisCryptoKey"
    another_secret_name = "OtherCipherTextFromTheSameKey"
  }
# optional, useful for managing secret name uniqueness
  prefix        = "prefix-to-secret-names-"
}
```
The module will output the service account's email address.
