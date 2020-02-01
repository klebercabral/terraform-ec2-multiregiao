provider "aws" {
  region  = "${terraform.workspace == "production" ? "us-east-1" : "us-east-2"}"
  version = "~> 2.0"
}

provider "aws" {
  region  = "us-west-1"
  alias   = "west"
  version = "~> 2.0"
}

terraform {
  backend "s3" {
    bucket = "terraform.statefile"
    #    dynamodb_table = "terraform-state-lock-dynamo"
    key     = "terraform-test.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}