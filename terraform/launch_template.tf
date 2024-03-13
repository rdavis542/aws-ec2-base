resource "aws_launch_template" "launch_template" {
  name_prefix            = "launch-template-"
  description            = "this is a basic launch template for EC2 base"
  image_id               = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [data.aws_security_group.ssh.id]
  user_data              = filebase64("${path.module}/script.sh")
  key_name               = aws_key_pair.db_key_pair.key_name

  block_device_mappings {
    device_name = "/dev/sda1"
    ebs {
      volume_size = var.volume_size
      volume_type = "gp2"
    }
  }

}