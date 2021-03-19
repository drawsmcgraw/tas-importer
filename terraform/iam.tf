data "aws_iam_policy_document" "tas-importer-policy" {
  statement {
    sid = "VisualEditor0"
    effect = "Allow"
    actions = ["iam:GetInstanceProfile"]
    resources = [aws_iam_role.tas-importer.arn]
  }

  statement {
    sid = "VisualEditor1"
    effect = "Allow"
    actions = ["iam:PassRole"]
    resources = [aws_iam_role.tas-importer.arn]
  }

  statement {
    sid = "PksMasterPolicy"
    effect = "Allow"
    actions = [
                "ec2:AttachVolume",
                "ec2:DisassociateAddress",
                "ec2:CopySnapshot",
                "ec2:DeregisterImage",
                "ec2:DeleteSnapshot",
                "ec2:DescribeAddresses",
                "ec2:DescribeInstances",
                "elasticloadbalancing:RegisterTargets",
                "ec2:DescribeRegions",
                "ec2:CopyImage",
                "ec2:DescribeSnapshots",
                "elasticloadbalancing:DescribeLoadBalancers",
                "ec2:DeleteVolume",
                "ec2:DescribeVolumeStatus",
                "ec2:StartInstances",
                "ec2:DescribeAvailabilityZones",
                "ec2:DescribeVolumes",
                "ec2:CreateSnapshot",
                "ec2:DescribeAccountAttributes",
                "ec2:ModifyInstanceAttribute",
                "ec2:DescribeKeyPairs",
                "elasticloadbalancing:DeregisterInstancesFromLoadBalancer",
                "elasticloadbalancing:RegisterInstancesWithLoadBalancer",
                "ec2:DescribeInstanceStatus",
                "ec2:DetachVolume",
                "ec2:RebootInstances",
                "ec2:ModifyVolume",
                "ec2:TerminateInstances",
                "s3:*",
                "ec2:CreateTags",
                "ec2:RegisterImage",
                "ec2:RunInstances",
                "ec2:StopInstances",
                "ec2:DescribeSecurityGroups",
                "ec2:CreateVolume",
                "ec2:DescribeImages",
                "ec2:DescribeVpcs",
                "elasticloadbalancing:DescribeTargetHealth",
                "elasticloadbalancing:DescribeTargetGroups",
                "ec2:AssociateAddress",
                "ec2:DescribeSubnets"
    ]

    resources = [
      "*",
    ]
  }
}