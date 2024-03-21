##################################################################################
# VARIABLES
##################################################################################

variable "aws_access_key" {
  type        = string
  description = "AWS Access Key"
  sensitive   = true
}
variable "aws_secret_key" {
  type        = string
  description = "AWS Secret Key"
  sensitive   = true
}
variable "aws_session_token" {
  type        = string
  description = "AWS Session Token"
  sensitive   = true
}

variable "region" {
  type        = string
  description = "value for default region"
  default     = "us-east-1"
}

variable "enable_dns_hostnames" {
  type        = bool
  description = "Enable DNS hostnames in VPC"
  default     = true
}


variable "network_address_space" {
  type        = string
  description = "Base CIDR Block for VPC"
  default     = "10.0.0.0/16"
}

variable "subnet_address_space" {
  type = map(any)
  default = {
    subnet1 = {
      cidr_block  = "10.0.1.0/24"
      description = "Base CIDR Block for subnet 1"
    },
    subnet2 = {
      cidr_block  = "10.0.2.0/24"
      description = "Base CIDR Block for subnet 2"
    }
  }
}

variable "cName" {
  type        = string
  description = "Common name for tagging"
  default     = "itkmitl"
}

variable "itclass" {
  type        = string
  description = "Class name for tagging"
}

variable "itgroup" {
  type        = string
  description = "Group number for tagging"
}

variable "ec2tag" {
  description = "Map of ec2 configuration."
  type        = map(any)

  default = {
    server1 = {
      instance_type = "t2.micro",
      server_name   = "server_1",
      subnet_id     = "Public1"
    },
    server2 = {
      instance_type = "t2.nano",
      server_name   = "server_2",
      subnet_id     = "Public2"
    }
  }
}

variable "subnettag" {
  description = "Map of subnet configuration."
  type        = map(any)

  default = {
    Public1 = {
      availability_zone = 0
      subnet_name       = "subnet1"
    },
    Public2 = {
      availability_zone = 1
      subnet_name       = "subnet2"
    }
  }
}