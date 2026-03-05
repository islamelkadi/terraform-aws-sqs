# SQS Queue Module Outputs

output "queue_id" {
  description = "URL of the SQS queue"
  value       = aws_sqs_queue.this.id
}

output "queue_arn" {
  description = "ARN of the SQS queue"
  value       = aws_sqs_queue.this.arn
}

output "queue_name" {
  description = "Name of the SQS queue"
  value       = aws_sqs_queue.this.name
}

output "queue_url" {
  description = "URL of the SQS queue"
  value       = aws_sqs_queue.this.url
}

output "tags" {
  description = "Tags applied to the SQS queue"
  value       = aws_sqs_queue.this.tags
}
