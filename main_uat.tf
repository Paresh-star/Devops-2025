provider "aws" {
  region = "us-east-1"  # Change as needed
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-unique-bucket-paresh-123456"  # Ensure it's globally unique
  force_destroy = true  # Destroys even if not empty (optional)
}

# Block public access
resource "aws_s3_bucket_public_access_block" "my_bucket_public_block" {
  bucket                  = aws_s3_bucket.my_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Bucket policy example - Allow GetObject from a specific IAM user or service
resource "aws_s3_bucket_policy" "my_bucket_policy" {
  bucket = aws_s3_bucket.my_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AllowGetObjectToSpecificUser"
        Effect    = "Allow"
        Principal = {
          AWS = "arn:aws:iam::123456789012:user/MyIAMUser"  # Replace with actual IAM user ARN
        }
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.my_bucket.arn}/*"
      }
    ]
  })
}

