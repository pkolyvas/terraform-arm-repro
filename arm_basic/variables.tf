variable "aws_profile" {
  type        = string
  description = "The AWS profile to use for this configuration"
}

variable "terraform_version" {
  type        = string
  description = "Target Terraform version to use"
}

variable "my_ssh_key" {
  type        = string
  description = "My SSH Key"
}
