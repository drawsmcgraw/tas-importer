locals {
  stable_config_tas_importer = {
    access_key         = var.access_key
    #secret_key         = var.secret_key
    environment_name   = var.environment_name
    availability_zones = var.availability_zones
    region             = var.region

    vpc_id = aws_vpc.vpc.id

    public_subnet_ids   = aws_subnet.public-subnet[*].id
    public_subnet_cidrs = aws_subnet.public-subnet[*].cidr_block

    #management_subnet_ids   = aws_subnet.management-subnet[*].id
    #management_subnet_cidrs = aws_subnet.management-subnet[*].cidr_block
    #management_subnet_gateways = [
    #  for i in range(length(var.availability_zones)) :
    #  cidrhost(aws_subnet.management-subnet[i].cidr_block, 1)
    #]
    #management_subnet_reserved_ip_ranges = [
    #  for i in range(length(var.availability_zones)) :
    #  "${cidrhost(aws_subnet.management-subnet[i].cidr_block, 1)}-${cidrhost(aws_subnet.management-subnet[i].cidr_block, 9)}"
    #]

    #tas_importer_subnet_id                 = aws_subnet.public-subnet[0].id
    #tas_importer_public_ip                 = aws_eip.tas-importer.public_ip
    tas_importer_public_ip                 =  aws_instance.tas-importer.public_ip
    #tas_importer_dns                       = aws_route53_record.tas-importer.name
    #tas_importer_iam_user_access_key       = aws_iam_access_key.tas-importer.id
    #tas_importer_iam_user_secret_key       = aws_iam_access_key.tas-importer.secret
    tas_importer_iam_instance_profile_name = aws_iam_instance_profile.tas-importer.name
    #tas_importer_key_pair_name             = aws_key_pair.tas-importer.key_name
    tas_importer_key_pair_name             = aws_instance.tas-importer.key_name
    #tas_importer_ssh_public_key            = tls_private_key.tas-importer.public_key_openssh
    #tas_importer_ssh_private_key           = tls_private_key.tas-importer.private_key_pem
    #tas_importer_bucket                    = aws_s3_bucket.tas-importer-bucket.bucket
    tas_importer_security_group_id         = aws_security_group.tas-importer.id
    tas_importer_security_group_name       = aws_security_group.tas-importer.name

    ###platform_vms_security_group_id   = aws_security_group.platform.id
    ###platform_vms_security_group_name = aws_security_group.platform.name

    #tkgi_security_group_id   = aws_security_group.tkgi-umbrella.id
    #tkgi_security_group_name = aws_security_group.tkgi-umbrella.name

    #nat_security_group_id   = aws_security_group.nat.id
    #nat_security_group_name = aws_security_group.nat.name

    #services_subnet_ids   = aws_subnet.services-subnet[*].id
    #services_subnet_cidrs = aws_subnet.services-subnet[*].cidr_block
    #services_subnet_gateways = [
    #  for i in range(length(var.availability_zones)) :
    #  cidrhost(aws_subnet.services-subnet[i].cidr_block, 1)
    #]
    #services_subnet_reserved_ip_ranges = [
    #  for i in range(length(var.availability_zones)) :
    #  "${cidrhost(aws_subnet.services-subnet[i].cidr_block, 1)}-${cidrhost(aws_subnet.services-subnet[i].cidr_block, 9)}"
    #]

    #ssl_certificate = var.ssl_certificate
    #ssl_private_key = var.ssl_private_key
  }
}

output "stable_config_opsmanager" {
  value     = local.stable_config_tas_importer
  sensitive = true
}

