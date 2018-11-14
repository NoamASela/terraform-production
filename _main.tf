provider "aws" {
  region = "${var.region}"
}

resource "aws_key_pair" "key" {
  key_name   = "${var.key_name}"
  public_key = "${file("id_rsa.pub")}"
}
terraform {
    backend "s3" {
        #cant contain interpolations
        encrypt = true
        bucket = "noama-production-terraform-remote-state"
        dynamodb_table = "terraform-state-lock-dynamo"
        region = "us-west-1" 
        key = "terraform/state"
    }
}