terraform {
  backend "s3" {
    bucket = "mybucket"
    key    = "my/terraform.tfstate"
    region = "us-east-1"
  }
}