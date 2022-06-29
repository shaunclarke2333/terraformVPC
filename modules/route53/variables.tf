variable "zone_id" {
  description = "input variable for ID of hosted zone to contain this record"
}

variable "record_name" {
  description = "input variable for record name"
}

variable "record_type" {
  description = "input variable for record type"
}

variable "alias_name" {
  description = "input variable for alias name"
}

variable "alias_zone_id" {
  description = "input variable for alias_zone_id"
}

variable "evaluate_target_health" {
  description = "input variable for evaluate_target_health"
}
