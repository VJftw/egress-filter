variable "project" {
  type = string
}

variable "image_family" {
  type        = string
  description = "The AMI name filter"
  default     = "fedora-coreos-stable"
}

variable "image_project" {
  type = string
  default = "fedora-coreos-cloud"
}

variable "network_id" {
  type = string
}

variable "public_subnetwork_id" {
  type = string
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

variable "include_tags" {
  type = list(string)
  description = "The tags to apply this route to."

  default = ["internet-egress"]
}
