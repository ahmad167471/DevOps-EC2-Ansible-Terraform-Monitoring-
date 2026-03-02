variable "project_name" { type = string }
variable "region" { type = string }
variable "instance_type" { type = string }
variable "public_key_path" { type = string }
variable "allowed_cidr" { type = string }
variable "environment" {
  description = "Environment name (dev or prod)"
  type        = string
}
