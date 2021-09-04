variable "ami_filter_name" {
  type        = string
  description = "The AMI name filter"
  default     = "fedora-coreos-*-x86_64"
}

variable "ami_filter_owners" {
  type        = list(string)
  description = "The AMI owners filter"
  default     = ["125523088429"]
}

variable "instance_type" {
  type        = string
  description = "The instance type to use for Squid"
  default     = "t3.micro"
}

variable "vpc_id" {
  type = string
  description = "The VPC to launch Squid instances in."
}

variable "squid_subnet_ids" {
  type        = list(string)
  description = "The subnet IDs where a Squid instance can be launched. This should be your 'Public' subnets."
}

variable "additional_squid_security_group_ids" {
  type        = list(string)
  description = "The additional security group ids to attach to squid instances."
  default     = []
}

variable "squid_ingress_cidr_blocks" {
  type        = list(string)
  description = "The IPv4 CIDR blocks allowed to access the squid instance. This should only be private ranges."

  default = [
    "10.0.0.0/8",     # RFC 1918
    "172.16.0.0/12",  # RFC 1918
    "192.168.0.0/16", # RFC 1918
  ]
}

variable "squid_ingress_ipv6_cidr_blocks" {
  type        = list(string)
  description = "The IPv6 CIDR blocks allowed to access the squid instance. This should only be private ranges."

  default = [
    "fd00::/8", # RFC 4193 
  ]
}

variable "squid_ingress_security_group_ids" {
  type        = list(string)
  description = "The security group IDs allowed to access the squid instance."

  default = []
}

variable "route_table_ids_to_transparently_proxy" {
  type        = list(string)
  description = "The route table IDs to transparently proxy with Squid. This should be your non-public subnets which require Internet access."

  default = []
}

variable "domain_whitelist" {
  type = list(string)
  description = "The domains to allow internet access to."

  default = []
}

variable "squid_container_image" {
  type = string
  description = "The container image repository to use for Squid."

  default = "ghcr.io/vjftw/egress-proxy:main"
}

variable "core_authorized_keys" {
  type = list(string)
  description = "SSH authorized keys to authenticate as the core@ Fedora CoreOS user."

  default = []
}
