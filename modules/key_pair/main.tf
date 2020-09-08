locals {  aws_ssh_key = var.aws_ssh_key }

resource "tls_private_key" "private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "key_aws" {
  key_name   = var.key_name
  public_key = tls_private_key.private_key.public_key_openssh
}

resource "local_file" "aws_ssh_key" {
  depends_on = [tls_private_key.private_key]
  content    = tls_private_key.private_key.private_key_pem
  filename   = local.aws_ssh_key
  file_permission = 0600
}
