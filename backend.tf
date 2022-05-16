terraform {
  backend "s3" {
    bucket = "mybucket"
    key    = "terraform.tfstate"#"path/to/my/key"
    region = "us-east-1"
  }
}