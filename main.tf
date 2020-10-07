provider "aws" {
  region  = "us-east-2"
  profile = var.aws_profile
}

module "arm64" {
  source = "./arm_basic/"
  # Specify the Terraform version you'd like to test
  terraform_version = "0.14.0"
  # Specify the location of the SSH public key you'd like to use
  my_ssh_key  = "/Users/pkolyvas/.ssh/hashi_rsa_public"
  aws_profile = var.aws_profile
}

output "instance_ip" {
  value       = module.arm64.instance_ip
  description = "SSH into the above address, with username: ubuntu"
}
