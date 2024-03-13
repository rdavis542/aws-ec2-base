resource "aws_instance" "from_template" {
  launch_template {
    id      = aws_launch_template.launch_template.id
    version = "$Latest"
  }

  tags = merge(var.default_tags, { Name = "ec2-base" })
}
