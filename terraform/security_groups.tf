#
# NAT instances/gateways
#
resource "aws_security_group" "nat" {
  name   = "${var.environment_name}-nat-sg"
  vpc_id = aws_vpc.vpc.id

  # All traffic from within the VPC
  ingress {
    cidr_blocks = [aws_vpc.vpc.cidr_block]
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
  }

  # All traffic coming from the VPC
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
  }

  tags = merge(
    var.tags,
    { "Name" = "${var.environment_name}-nat-sg" },
  )
}

#
# TAS-importer VM
#
resource "aws_security_group" "tas-importer" {
  name   = "${var.environment_name}-tas-importer-sg"
  vpc_id = aws_vpc.vpc.id

  # SSH
  ingress {
    cidr_blocks = var.ops_manager_allowed_ips
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
  }

  # All traffic is allowed inside the VPC
  ingress {
    from_port = 0
    protocol = "-1"
    to_port = 65535
  }

  # All traffic is allowed to exit the VPC
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
  }

  tags = merge(
    var.tags,
    { "Name" = "${var.environment_name}-tas-importer-sg" },
  )
}