#
# DO NOT DELETE THESE LINES UNTIL INSTRUCTED TO!
#
# Your AMI ID is:
#
#     ami-09943f9da1f1b7899
#
# Your subnet ID is:
#
#     subnet-05e9f01e53c9a38dd
#
# Your VPC security group ID is:
#
#     sg-0cf3d1190f348f5e5
#
# Your Identity is:
#
#     terraform-nyl-bat
#

variable "secret_key" {}
variable "access_key" {}
variable "region" {}

variable "subnet_id" {
}

variable "security_group_ids" {
}

variable "server_os" {
  type        = string
  description = "Server Operating System"
  default     = "ubuntu"
}
provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = var.region
}

module "server" {
  source      = "./server"
  count = 2
  server_os = "ubuntu"
  identity    = "gabeserver"
  key_name    = module.keypair.key_name
  private_key = module.keypair.private_key_pem
  subnet_id = var.subnet_id
  vpc_security_group_ids = var.security_group_ids

}

module "keypair" {
  source  = "mitchellh/dynamic-keys/aws"
  version = "2.0.0"
  path    = "${path.root}/keys"
  name    = "${local.identity}-key"
}

output "public_ip" {
  value = module.server.*.public_ip
}

output "public_dns" {
  value = module.server.*.public_dns
}
