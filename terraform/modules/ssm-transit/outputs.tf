output "bucket_arn" {
  description = "The ARN of the SSM transit bucket to pass to IAM policies"
  value       = aws_s3_bucket.transit.arn
}
