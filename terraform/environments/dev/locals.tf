locals {
  common_tags = {
    Environment = var.environment
  }

  name_prefix = "${var.name_prefix}-${var.environment}"
}