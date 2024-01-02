variable "gcp_svc_key" {
  description = "The name of the key file"
  type        = string
}

variable "gcp_project" {
  description = "The name of the project in GCP"
  type        = string
}

variable "gcp_region" {
  description = "The region to deploy resources into"
  type        = string
}

variable "website_name" {
  description = "Name of the website"
  type        = string
}

variable "website_location" {
  description = "Location of the website"
  type        = string
}

variable "dns_managed_zone" {
  description = "The name of the managed zone"
  type        = string
}