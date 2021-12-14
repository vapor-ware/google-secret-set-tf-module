variable "secrets" {
  type = map
}

variable "crypto_key" {
  type = string
}

variable "svc_acct_name" {
  type    = string
  default = ""
  validation {
    condition     = can(regex("^([a-z](?:[-a-z0-9]{4,28}[a-z0-9])|)$", var.svc_acct_name))
    error_message = "Variable `svc_acct_name` must be alphanumeric, between 6 and 30 characters long."
  }
}

variable "existing_svc_acct_email" {
  type    = string
  default = ""
}

variable "prefix" {
  type    = string
  default = ""
  validation {
    condition     = can(regex("^([a-z](?:[-a-z0-9]{0,10}[a-z0-9])|)$", var.prefix))
    error_message = "Variable `prefix` must be alphanumeric, between 2 and 12 characters long."
  }
}
