
###
# NOTE: this file is used by Terraform to tell it what variables it will need.
# To define variables, define them in the file terraform.tfvars.
###
variable "access_key" {
  type = string
}

variable "secret_key" {
  type = string
}

variable "environment_name" {
  type = string
}

variable "region" {
  type = string
}

variable "tas_importer_keypair" {
  type = string
}

variable "s3_bucket_name" {
  type = string
}

variable "availability_zones" {
  description = "The list of availability zones to use. Must belong to the provided region and equal the number of CIDRs provided for each subnet."
  type        = list
}

variable "public_subnet_cidrs" {
  default     = ["10.0.0.0/24"]
  description = "The list of CIDRs for the Public subnet. Number of CIDRs MUST match the number of AZs."
  type        = list
}

###variable "pks_subnet_cidrs" {
###  default     = ["10.0.12.0/24", "10.0.13.0/24"]
###  description = "The list of CIDRs for the PKS subnet. Number of CIDRs MUST match the number of AZs."
###  type        = list
###}

variable "ops_manager_allowed_ips" {
  description = "IPs allowed to communicate with Ops Manager."
  default     = ["0.0.0.0/0"]
  type        = list
}

variable "tags" {
  description = "Key/value tags to assign to all resources."
  default     = {}
  type        = map(string)
}

variable "k8s_clusters" {
  description = "Names of k8s clusters. Used for creation of load balancers"
  default = []
  type = set(string)

}

variable "k8s_uuids" {
  description = "UUIDs of each workload k8s cluster created via PKS. Required if creating k8s services and you want EBLs created for you. "
  default = {}
  type = map(string)
}
