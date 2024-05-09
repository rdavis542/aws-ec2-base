resource "aws_iam_policy" "SSM_Access_Policy" {

    name = "SSMAccessPolicy"
    policy = <<POLICY
    {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ssm:UpdateInstanceInformation",
                "ssmmessages:CreateControlChannel",
                "ssmmessages:CreateDataChannel",
                "ssmmessages:OpenControlChannel",
                "ssmmessages:OpenDataChannel"
            ],
            "Resource": "*"
        }
    ]
}
POLICY
  
}

resource "aws_iam_role" "SSM_Manager_Role" {
    name = "SessionManagerPermissions"
      assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}
  
resource "aws_iam_role_policy_attachment" "ssm_policy_attachment" {
  role       = aws_iam_role.SSM_Manager_Role.name
  policy_arn = "arn:aws:iam::aws:policy/SSMAccessPolicy"
}