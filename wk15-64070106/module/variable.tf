variable "bucket_acl" {
  description = "The ACL for the S3 bucket"
  default     = "private"
}

variable "bucket_name" {
  description = "The name of the S3 bucket"
}

variable "image_path" {
  description = "The path to the image file to upload."
  type        = string
}