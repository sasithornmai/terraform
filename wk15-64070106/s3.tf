

resource "random_integer" "rand" {
  min = 100
  max = 99999
}

module "example_s3_bucket" {
  source      = "./module"
  bucket_name = "example-bucket-${random_integer.rand.result}"
  image_path =  "./example.png"
}