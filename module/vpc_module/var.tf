variable "environment" {
    description = "Deployment Environment"
    type = string
}

variable "vpc_cidr" {
    type = string
    description = "CIDR block of the vpc"

  
}

variable "public_subnets_cidr" {
  type        = list
  description = "CIDR block for Public Subnet"
}

variable "availability_zone" {
    type = list
    description = "AZ in which all the resources will be deployed"
  
}

variable "private_subnets_cidr" {
  type        = list
  description = "CIDR block for Private Subnet"
}