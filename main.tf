provider "aws" {
  region  = "us-east-2"
  profile = var.aws_profile
}

module "arm64" {
  source = "./arm_basic/"

  terraform_version = ""
  my_ssh_key        = ""
  aws_profile       = var.aws_profile

}
