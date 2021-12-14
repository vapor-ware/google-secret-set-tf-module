variable "secrets" {
  type = map
}

variable "crypto_key" {
  type = string
}

variable "svc_acct_name" {
  type    = string
  default = ""
}

variable "existing_svc_acct_email" {
  type    = string
  default = ""
}

variable "prefix" {
  type    = string
  default = ""
}
