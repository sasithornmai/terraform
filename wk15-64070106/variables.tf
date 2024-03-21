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

variable "key_name" {
    type        = string
    description = "Private key path"
    sensitive   = false
}
variable "region" {
    type        = string
    description = "value for default region"
    default = "us-east-1"
}

  
variable "cName" {
    type        = string
    description = "Common name for tagging"
    default = "ITKMITL"    
}
  
variable "itclass" {
    type        = string
    description = "Class name for tagging"
}

variable "itgroup" {
    type        = string
    description = "Group number for tagging"
}