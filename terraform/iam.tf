data "aws_iam_policy_document" "pks-master-policy" {
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

###resource "aws_iam_policy" "pks-master" {
###  name   = "${var.environment_name}-pks-master-policy"
###  policy = data.aws_iam_policy_document.pks-master-policy.json
###}
###
###resource "aws_iam_role" "pks-master" {
###  name = "${var.environment_name}-pks-master"
###
###  lifecycle {
###    create_before_destroy = true
###  }
###
###  assume_role_policy = data.aws_iam_policy_document.assume-role-policy.json
###}
###
###resource "aws_iam_role_policy_attachment" "pks-master" {
###  role       = aws_iam_role.pks-master.name
###  policy_arn = aws_iam_policy.pks-master.arn
###}
###
###resource "aws_iam_instance_profile" "pks-master" {
###  name = "${var.environment_name}-pks-master"
###  role = aws_iam_role.pks-master.name
###
###  lifecycle {
###    ignore_changes = [name]
###  }
###}

###data "aws_iam_policy_document" "pks-worker-policy" {
###  statement {
###    sid = "PksWorkerPolicy"
###
###    effect = "Allow"
###
###    actions = [
###      "ec2:DescribeInstances",
###      "ec2:DescribeRegions",
###      "ecr:GetAuthorizationToken",
###      "ecr:BatchCheckLayerAvailability",
###      "ecr:GetDownloadUrlForLayer",
###      "ecr:GetRepositoryPolicy",
###      "ecr:DescribeRepositories",
###      "ecr:ListImages",
###      "ecr:BatchGetImage",
###    ]
###
###    resources = [
###      "*",
###    ]
###  }
###}
###
###resource "aws_iam_policy" "pks-worker" {
###  name   = "${var.environment_name}-pks-worker-policy"
###  policy = data.aws_iam_policy_document.pks-worker-policy.json
###}

###data "aws_iam_policy_document" "assume-role-policy" {
###  statement {
###    actions = ["sts:AssumeRole"]
###
###    principals {
###      type        = "Service"
###      identifiers = ["ec2.amazonaws.com"]
###    }
###  }
###}
###
###resource "aws_iam_role" "pks-worker" {
###  name = "${var.environment_name}-pks-worker"
###
###  lifecycle {
###    create_before_destroy = true
###  }
###
###  assume_role_policy = data.aws_iam_policy_document.assume-role-policy.json
###}
###
###resource "aws_iam_role_policy_attachment" "pks-worker" {
###  role       = aws_iam_role.pks-worker.name
###  policy_arn = aws_iam_policy.pks-worker.arn
###}
###
###resource "aws_iam_instance_profile" "pks-worker" {
###  name = "${var.environment_name}-pks-worker"
###  role = aws_iam_role.pks-worker.name
###
###  lifecycle {
###    ignore_changes = [name]
###  }
###}
