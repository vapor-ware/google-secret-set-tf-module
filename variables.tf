variable "secrets" {
  type = map
}

variable "crypto_key" {
  type = string
}

variable "svc_acct_name" {
  type = string
}

variable "prefix" {
  type    = string
  default = ""
}
