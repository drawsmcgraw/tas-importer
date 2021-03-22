resource "aws_s3_bucket" "hydration-bucket" {
  bucket = var.s3_bucket_name
  acl = "private"
}