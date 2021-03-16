variable "subnet_id" {}
variable "vpc_security_group_ids" {
  type = list(any)
}
variable "web_count" {
  type        = number
  description = "Number of web servers"
  default     = 2
}
resource "aws_instance" "web" {
  # ami                    = data.aws_ami.ubuntu_16_04.image_id
  count                  = var.web_count
  ami                    = (var.server_os == "ubuntu") ? data.aws_ami.ubuntu_16_04.image_id : data.aws_ami.windows.image_id
  instance_type          = "t2.micro"
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.vpc_security_group_ids
  key_name               = var.key_name

  tags = {
    "Identity"    = var.identity
    "Name"        = "Student"
    "Environment" = "Training"
  }
}