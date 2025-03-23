provider "aws" {
  region = var.aws_region
}

resource "aws_key_pair" "ssh_key_1" {
  key_name   = "ssh-key-1"
  public_key = file(var.ssh_key_1_path)
}

resource "aws_security_group" "ec2_security_group" {
  name        = "ec2_security_group"

  ingress {
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
}

resource "aws_security_group_rule" "postgresql" {
  type                     = "ingress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  security_group_id        = aws_security_group.ec2_security_group.id
  source_security_group_id = aws_security_group.ec2_security_group.id
}

resource "aws_instance" "ec2_instance" {
  count         = var.instance_count
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = aws_key_pair.ssh_key_1.key_name
  security_groups = [aws_security_group.ec2_security_group.name]

  user_data = <<-EOF
    #!/bin/bash
    mkdir -p /home/ubuntu/.ssh
    echo "${file(var.ssh_key_2_path)}" >> /home/ubuntu/.ssh/authorized_keys
    chown -R ubuntu:ubuntu /home/ubuntu/.ssh
    chmod 600 /home/ubuntu/.ssh/authorized_keys
  EOF

  tags = {
    Name = "ec2-instance-${count.index + 1}"
  }
}
