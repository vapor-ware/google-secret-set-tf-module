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
    can(regex("^([a-z](?:[-a-z0-9]{4,28}[a-z0-9])|)$", var.svc_acct_name))
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
    can(regex("^([a-z](?:[-a-z0-9]{1,10}[a-z0-9])|)$", var.svc_acct_name))
  }
}
