
variable "bucket" {
  description = "variable for bucket name input"
}

variable "bucket_key_enabled" {
  description = "variable for bucket key enabled name input"
}

variable "algorithm" {
  description = "variable for sse algorithm input"
}

variable "enabled" {
  description = "variable for versioning enabled input"
}

variable "mfa_delete" {
  description = "variable for mfa delete input"
}

variable "prevent_destroy" {
  description = "variable for prevent destroy input"
}
