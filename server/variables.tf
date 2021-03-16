variable "identity" {}
variable "key_name" {}
variable "private_key" {}
variable "server_os" {
  type        = string
  description = "Server Operating System"
  default     = "ubuntu"
}