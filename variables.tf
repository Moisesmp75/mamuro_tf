variable "instance_name" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
  default     = "Mamuro_Api"
}

variable "aws_access_key" {
  description = "AWS Access key"
  type        = string
}

variable "aws_secret_key" {
  description = "AWS Secret key"
  type        = string
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-west-2"
}