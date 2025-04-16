resource "aws_s3_bucket" "s3_bucket" {
  bucket = var.s3_bucket
}

resource "aws_s3_object" "model" {
  bucket = aws_s3_bucket.s3_bucket.id
  key    = basename(var.model_path)
  source = var.model_path
  acl    = "private"
}