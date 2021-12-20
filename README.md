# google_secret_set

A Terraform module for implementing [Google Managed Secrets](https://cloud.google.com/secret-manager/docs)

## Compatibility

This module is meant for use with Terraform 0.14

## Introduction

This Terraform module creates one or more managed secrets in a Google Project, along with a service account with iam policy to access those secrets.

The following resources will be created:

one [google_service_account](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_service_account) and corresponding [google_iam_policy](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/iam_policy)

one of each of the following per defined secret:
- [google_secret_manager_secret](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret)
- [google_secret_manager_secret_version](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret_version)
- [google_secret_manager_secret_iam_policy](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret_iam#google_secret_manager_secret_iam_policy)

Ephemeral [google_kms_secret](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/kms_secret) datasources are also defined to carry ciphertext to the secret_version, but are not persistently created in the project.

## Usage

To implement this module in your project:
```
module "this-module-implementation" {
  source        = "git::git@github.com:vapor-ware/google-secret-set-tf-module?ref=tags/v1.0.0"
  crypto_key    = "projects/this-project/locations/this-location/keyRings/this-keyring/cryptoKeys/this-key"
  secrets       = {
    unique_secret_name  = "CipherTextGeneratedFromThisCryptoKey"
    another_secret_name = "OtherCipherTextFromTheSameKey"
  }
  svc_acct_name = "unique-acct-name"
  prefix        = "prefix-name"
}

## Required Variables

| NAME | DESCRIPTION | 
|:=====|:============|
| `crypto_key` | Google keyRing resource |
| `secrets` | A [map](https://www.terraform.io/docs/configuration-0-11/variables.html#maps) of secrets in `secret_name = "cipherText"` key/value pairs |

In addition to these two variables, one of the following three must be provided for the secret accessor service account.
| NAME | DESCRIPTION | DEFAULT |
|:=====|:============|:========|
| `svc_acct_name` | Name (alphanumeric and dashes only,between 6 and 30 characters long) to give a new service account | `""` |
| `prefix` | String to prepend to secret names for improved uniqueness and grouping (alphanumeric, not more than 13 characters long) | `""` |
`prefix` may be with or without `svc_acct_name`
If `svc_acct_name` is not provided, the service account name will be `${prefix}-secrets-accessor`

## Optional Variables
| NAME | DESCRIPTION | DEFAULT |
|:=====|:============|:========|
| `existing_svc_acct_email` | The email address of an existing service account to also grant secrets access | `""` |

```
The module will output the service account's email address.
