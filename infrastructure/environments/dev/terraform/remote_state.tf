# # S3 Bucket for Terraform State
# resource "aws_s3_bucket" "terraform_state" {
#   bucket = "${local.name_prefix}-terraform-state"
#   tags   = local.common_tags
# }

# # S3 Bucket Versioning
# resource "aws_s3_bucket_versioning" "terraform_state_versioning" {
#   bucket = aws_s3_bucket.terraform_state.id

#   versioning_configuration {
#     status = "Enabled"
#   }
# }

# # S3 Bucket Encryption
# resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state_encryption" {
#   bucket = aws_s3_bucket.terraform_state.id

#   rule {
#     apply_server_side_encryption_by_default {
#       sse_algorithm = "AES256"
#     }
#   }
# }

# # DynamoDB for state locking
# resource "aws_dynamodb_table" "terraform_locks" {
#   name         = "${local.name_prefix}-terraform-locks"
#   billing_mode = "PAY_PER_REQUEST"
#   hash_key     = "LockID"

#   attribute {
#     name = "LockID"
#     type = "S"
#   }

#   tags = local.common_tags
# }
