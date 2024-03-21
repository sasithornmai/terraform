

resource "aws_s3_bucket" "example_bucket" {
  bucket = var.bucket_name
  acl    = var.bucket_acl
}

resource "aws_s3_bucket_object" "example_object" {
  bucket = aws_s3_bucket.example_bucket.bucket
  key    = "example.jpg"  # กำหนดชื่อไฟล์ที่ต้องการให้รูป
  source = var.image_path  # กำหนด path ของรูปที่ต้องการอัปโหลด
}