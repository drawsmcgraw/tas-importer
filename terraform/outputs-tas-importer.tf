locals {
  stable_config_tas_importer = {
    access_key         = var.access_key
    secret_key         = var.secret_key
    environment_name   = var.environment_name
    availability_zones = var.availability_zones
    region             = var.region

    vpc_id = aws_vpc.vpc.id

    public_subnet_ids   = aws_subnet.public-subnet[*].id
    public_subnet_cidrs = aws_subnet.public-subnet[*].cidr_block


    tas_importer_public_ip                 = aws_instance.tas-importer.public_ip
    tas_importer_iam_instance_profile_name = aws_iam_instance_profile.tas-importer.name
    tas_importer_key_pair_name             = aws_instance.tas-importer.key_name
    tas_importer_bucket                    = aws_s3_bucket.hydration-bucket
    tas_importer_security_group_id         = aws_security_group.tas-importer.id
    tas_importer_security_group_name       = aws_security_group.tas-importer.name

  }
}

output "stable_config_tas_importer" {
  value     = local.stable_config_tas_importer
  sensitive = true
}

