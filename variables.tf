variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-1"
}

variable "ami_id" {
  description = "AMI ID for EC2 instances"
  type        = string
  default     = "ami-03fd334507439f4d1"
}

variable "instance_type" {
  description = "Instance type"
  type        = string
  default     = "t2.micro"
}

variable "instance_count" {
  description = "Number of EC2 instances"
  type        = number
  default     = 2
}

variable "ssh_key_1_path" {
  description = "Path to SSH public key 1"
  type        = string
  default     = "ssh-key-1.pem"
}

variable "ssh_key_2_path" {
  description = "Path to SSH public key 2"
  type        = string
  default     = "ssh-key-2.pem"
}
