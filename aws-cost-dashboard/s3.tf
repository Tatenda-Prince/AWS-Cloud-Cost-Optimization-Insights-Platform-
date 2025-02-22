resource "aws_s3_bucket" "dashboard_bucket" {
  bucket = "tatenda-aws-cost-dashboard"  # Change this to a unique bucket name
}

resource "aws_s3_bucket_public_access_block" "dashboard_bucket_access" {
  bucket = aws_s3_bucket.dashboard_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# Configure S3 bucket as a static website
resource "aws_s3_bucket_website_configuration" "website_config" {
  bucket = aws_s3_bucket.dashboard_bucket.id

  index_document {
    suffix = "index.html"
  }
}

# Allow public read access to the website files
resource "aws_s3_bucket_policy" "public_read_policy" {
  bucket = aws_s3_bucket.dashboard_bucket.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = "*"
      Action    = "s3:GetObject"
      Resource  = "${aws_s3_bucket.dashboard_bucket.arn}/*"
    }]
  })
}

