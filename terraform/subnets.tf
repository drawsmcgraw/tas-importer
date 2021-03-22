#
# Public Subnet
#
resource "aws_subnet" "public-subnet" {
  count = length(var.public_subnet_cidrs)

  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = element(var.public_subnet_cidrs, count.index)
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = true

  # With 'k8s_uuids', we merge in the UUIDs from the file 'terraform.tfvars'.
  tags = merge(
    var.tags,
    var.k8s_uuids,
    { Name = "${var.environment_name}-public-subnet-${count.index}"},
  )
}