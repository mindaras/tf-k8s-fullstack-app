variable "environment" {
  type        = string
  description = "(Required) Environment of the resources."
  default     = "development"
}

variable "name_prefix" {
  type        = string
  description = "(Required) Name prefix to use for the resources."
  default     = "counter-app"
}

variable "vpc_cidr" {
  type        = string
  description = "(Optional) VPC cidr block. Default: 10.0.0.0/16"
  default     = "10.0.0.0/16"
}

variable "ci_user_id" {
  type        = string
  description = "(Required) Id of AWS CI user."
}

variable "ci_username" {
  type        = string
  description = "(Required) Name of AWS CI user."
}