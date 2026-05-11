output "ami_id" {
  description = "EC2 Base AMI used to launch instances"
  value       = data.aws_ami.ec2_base.id
}

output "image_name" {
  value = data.aws_ami.ec2_base.name
}

# Outputs
output "instance_id" {
  description = "EC2 Instance ID for SSM port forwarding"
  value       = aws_instance.ssm_instance.id
}

output "instance_private_ip" {
  description = "Private IP address of the EC2 instance"
  value       = aws_instance.ssm_instance.private_ip
}

output "vpc_id" {
  description = "VPC ID"
  value       = data.aws_vpc.selected.id
}

output "ssm_port_forwarding_examples" {
  description = "Example AWS CLI commands for port forwarding"
  value = <<-EOF
    # Forward local port 8080 to instance port 80 (web server):
    aws ssm start-session --target ${aws_instance.ssm_instance.id} --document-name AWS-StartPortForwardingSession --parameters '{"portNumber":["80"],"localPortNumber":["8080"]}'
    
    # Forward local port 3306 to instance port 3306 (MySQL):
    aws ssm start-session --target ${aws_instance.ssm_instance.id} --document-name AWS-StartPortForwardingSession --parameters '{"portNumber":["3306"],"localPortNumber":["3306"]}'
    
    # Forward local port 2222 to instance port 22 (SSH - if enabled):
    aws ssm start-session --target ${aws_instance.ssm_instance.id} --document-name AWS-StartPortForwardingSession --parameters '{"portNumber":["22"],"localPortNumber":["2222"]}'
    
    # Connect via SSM Session Manager:
    aws ssm start-session --target ${aws_instance.ssm_instance.id}
    EOF
}

# Optional: Create a terraform.tfvars file template
output "terraform_tfvars_example" {
  description = "Example terraform.tfvars content"
  value = <<-EOF
    # Copy this to terraform.tfvars and customize as needed
    aws_region    = "us-east-1"
    instance_type = "t3.micro"
    EOF
}