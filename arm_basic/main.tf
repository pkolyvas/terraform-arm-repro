
resource "aws_key_pair" "arm64_key" {
  key_name   = "arm64_key"
  public_key = data.local_file.my_ssh_key.content
}

module "vpc" {
  source = "github.com/pkolyvas/terraform-aws-vpc.git?ref=pkolyvas-0.14"

  name = "conference-vpc"
  cidr = "10.230.0.0/16"

  azs             = ["us-east-2c", "us-east-2b"]
  private_subnets = ["10.230.1.0/24", "10.230.2.0/24"]
  public_subnets  = ["10.230.11.0/24", "10.230.22.0/24"]

  enable_nat_gateway = false
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow inbound ssh traffic"
  vpc_id      = module.vpc.vpc_id
  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
}

data "local_file" "my_ssh_key" {
  filename = var.my_ssh_key
}


resource "aws_instance" "arm64" {

  ami                         = "ami-0327b24ad9181634e"
  instance_type               = "t4g.micro"
  subnet_id                   = module.vpc.public_subnets.0
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.allow_ssh.id]
  key_name                    = aws_key_pair.arm64_key.key_name

  tags = {
    Name = "ARM64 Test Instance"
  }

  provisioner "remote-exec" {
    inline = [
      "wget https://releases.hashicorp.com/terraform/${var.terraform_version}/terraform_${var.terraform_version}_linux_arm64.zip",
      "sudo apt-get install unzip -y -q",
      "unzip terraform_${var.terraform_version}_linux_arm64.zip",
      "unzip terraform_0.14.0-test1_linux_arm64.zip",
      "sudo mv terraform /usr/local/bin",
      "terraform -v"

    ]

    connection {
      type = "ssh"
      user = "ubuntu"
      host = aws_instance.arm64.public_ip
    }
  }
}

output "instance_ip" {
  value       = aws_instance.arm64.public_ip
  description = "SSH into the above address, with username: ubuntu"
}

