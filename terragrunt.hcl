remote_state {
  backend = "s3"
  config = {
    bucket         = "terragrunt-project-atlantis-devo2025"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "eu-west-1"
    encrypt        = true
    dynamodb_table = "tf_lock_table"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
 }
}