# Infrastructure setup

## Remote state configuration

1. Comment out the backend configuration in `terraform.tf`
2. Create the AWS resources:

```
terraform apply \
 -target=aws_s3_bucket.terraform_state \
 -target=aws_dynamodb_table.terraform_locks \
 -target=aws_s3_bucket_versioning.terraform_state_versioning \
 -target=aws_s3_bucket_server_side_encryption_configuration.terraform_state_encryption
```

3. Remove remote backend resources from Terraform state

```
terraform state rm aws_s3_bucket.terraform_state
terraform state rm aws_s3_bucket_versioning.terraform_state_versioning
terraform state rm aws_s3_bucket_server_side_encryption_configuration.terraform_state_encryption
terraform state rm aws_dynamodb_table.terraform_locks
```

4. Comment out remote state resource configuration in `remote_state.tf`
5. Uncomment the backend configuration in `terraform.tf` is not commented out
6. Download the necessary plugins and migrate the local state to S3 if one exists:

```
terraform init
```

## Setup AWS access

_Set a profile for a terminal session_

```
export AWS_PROFILE=<profile name>
```

## Deploy

_Apply configuration_

```
terraform apply -var="ci_user_id=<user id> -var="ci_user_name=<username>" -auto-approve
```
