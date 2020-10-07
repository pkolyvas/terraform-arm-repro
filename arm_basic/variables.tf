variable "aws_profile" {
  type        = string
  description = "The AWS profile to use for this configuration"
  default     = "hashipm"
}

variable "terraform_version" {
  type        = string
  description = "Target Terraform version to use"
  default     = "0.14.0"
}

variable "my_ssh_key" {
  type        = string
  description = "My SSH Key"
  default     = "/Users/pkolyvas/.ssh/keys/hashi_rsa_main.pub"
}
