resource "aws_instance" "from_template" {
  launch_template {
    id      = aws_launch_template.launch_template.id
    version = "$Latest"
  }

  tags = merge(var.default_tags, { Name = "ec2-base" })
  depends_on = [ aws_key_pair.ec2_key_pair ]
}

resource "aws_key_pair" "ec2_key_pair" {
  key_name    = "ec2-key-pair" # Choose a descriptive name
  public_key  = file("~/.ssh/my-key.pub")
  tags = {
    Name = "My App Key Pair"
  }
}

