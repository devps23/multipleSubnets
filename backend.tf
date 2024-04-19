terraform {
  backend "s3" {
    bucket = "mybucket"
    key    = "test/env"
    region = "us-east-1"
  }
}
