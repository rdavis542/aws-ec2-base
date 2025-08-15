resource "aws_instance" "from_template" {
  launch_template {
    id      = aws_launch_template.launch_template.id
    version = "$Latest"
  }

  tags = merge(var.default_tags, local.common_tags)
}


resource "aws_instance" "ssm_instance" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  iam_instance_profile   = aws_iam_instance_profile.ec2_instance_profile.name
  vpc_security_group_ids = [data.aws_security_group.https_private.id]
  subnet_id              = data.aws_subnet.private-subnet-a.id
  user_data              = local.user_data

  # Enable detailed monitoring
  monitoring = true

  # Root volume configuration
  root_block_device {
    volume_type = "gp3"
    volume_size = 20
    encrypted   = true
  }

  tags = merge(var.default_tags, local.common_tags)
}

