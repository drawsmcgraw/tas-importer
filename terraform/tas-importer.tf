data "aws_ami" "amazon_linux" {
  # Latest Amazon Linux 2
  most_recent = true
  name_regex = "^amzn2-ami-hvm-[0-9.]+-x86_64-ebs$"
  owners = ["amazon"]
}

#
# TAS-importer VM plus requisite IAM resources
#
resource "aws_instance" "tas-importer" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = "t2.large"
  key_name               = var.tas_importer_keypair
  vpc_security_group_ids = [aws_security_group.tas-importer.id]
  subnet_id              = aws_subnet.public-subnet[0].id
  iam_instance_profile   = aws_iam_instance_profile.tas-importer.id

  root_block_device {
    volume_size = 150
  }

  tags = {
    Name = "${var.environment_name}-opsman"
  }
}

#
# IAM wiring
#
resource "aws_iam_policy" "tas-importer-role" {
  name   = "${var.environment_name}-tas-importer-role"
  policy = data.aws_iam_policy_document.tas-importer.json
}

resource "aws_iam_role_policy_attachment" "tas-importer-policy" {
  role       = aws_iam_role.tas-importer.name
  policy_arn = aws_iam_policy.tas-importer-role.arn
}

resource "aws_iam_role" "tas-importer" {
  name = "${var.environment_name}-tas-importer-role"

  lifecycle {
    create_before_destroy = true
  }

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": [
          "ec2.amazonaws.com"
        ]
      },
      "Action": [
        "sts:AssumeRole"
      ]
    }
  ]
}
EOF

}

resource "aws_iam_instance_profile" "tas-importer" {
  name = "${var.environment_name}-tas-importer"
  role = aws_iam_role.tas-importer.name

  lifecycle {
    ignore_changes = [name]
  }
}

#
# This may be redundant but I copy/pasted this from a previous project and haven't the time to investigate if it's
# needed or not.
# Please forgive me, future reader.
# Ref: https://stevemcconnell.com/articles/cargo-cult-software-engineering/
#
data "aws_iam_policy_document" "tas-importer" {
  statement {
    sid       = "OpsMgrInfoAboutCurrentInstanceProfile"
    effect    = "Allow"
    actions   = ["iam:GetInstanceProfile"]
    resources = [aws_iam_instance_profile.tas-importer.arn]
  }

  statement {
    sid     = "OpsMgrCreateInstanceWithCurrentInstanceProfile"
    effect  = "Allow"
    actions = ["iam:PassRole"]
    resources = [
      aws_iam_role.tas-importer.arn,
      #aws_iam_role.pks-master.arn,
      #aws_iam_role.pks-worker.arn,
    ]
  }

  statement {
    sid     = "OpsMgrS3Permissions"
    effect  = "Allow"
    actions = ["s3:*"]
    resources = [
      "arn:aws:s3:::${var.environment_name}-tas-importer-bucket",
      "arn:aws:s3:::${var.environment_name}-tas-importer-bucket/*"
      # Use these values for govcloud
      #"arn:aws-us-gov:s3:::${var.environment_name}-tas-importer-bucket",
      #"arn:aws-us-gov:s3:::${var.environment_name}-tas-importer-bucket/*"
    ]
  }

  statement {
    sid    = "OpsMgrEC2Permissions"
    effect = "Allow"
    actions = [
      "ec2:DescribeKeypairs",
      "ec2:DescribeVpcs",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeAvailabilityZones",
      "ec2:DescribeAccountAttributes",
      "ec2:DescribeImages",
      "ec2:DeregisterImage",
      "ec2:DescribeSubnets",
      "ec2:RunInstances",
      "ec2:DescribeInstances",
      "ec2:TerminateInstances",
      "ec2:RebootInstances",
      "elasticloadbalancing:DescribeLoadBalancers",
      "elasticloadbalancing:DescribeTargetGroups",
      "elasticloadbalancing:DescribeTargetHealth",
      "elasticloadbalancing:RegisterTargets",
      "elasticloadbalancing:RegisterInstancesWithLoadBalancer",
      "elasticloadbalancing:DeregisterInstancesFromLoadBalancer",
      "ec2:DescribeAddresses",
      "ec2:DisassociateAddress",
      "ec2:AssociateAddress",
      "ec2:CreateTags",
      "ec2:DescribeVolumes",
      "ec2:CreateVolume",
      "ec2:AttachVolume",
      "ec2:DeleteVolume",
      "ec2:DetachVolume",
      "ec2:CreateSnapshot",
      "ec2:DeleteSnapshot",
      "ec2:DescribeSnapshots",
      "ec2:DescribeRegions"
    ]
    resources = ["*"]
  }
}

