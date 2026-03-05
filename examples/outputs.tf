# SQS Example Outputs

# Standard Queue Outputs
output "standard_queue_url" {
  description = "URL of the standard SQS queue"
  value       = module.standard_queue.queue_url
}

output "standard_queue_arn" {
  description = "ARN of the standard SQS queue"
  value       = module.standard_queue.queue_arn
}

output "standard_queue_name" {
  description = "Name of the standard SQS queue"
  value       = module.standard_queue.queue_name
}

# Dead Letter Queue Outputs
output "dlq_url" {
  description = "URL of the dead letter queue"
  value       = module.dlq.queue_url
}

output "dlq_arn" {
  description = "ARN of the dead letter queue"
  value       = module.dlq.queue_arn
}

output "dlq_name" {
  description = "Name of the dead letter queue"
  value       = module.dlq.queue_name
}

# FIFO Queue Outputs
output "fifo_queue_url" {
  description = "URL of the FIFO queue"
  value       = module.fifo_queue.queue_url
}

output "fifo_queue_arn" {
  description = "ARN of the FIFO queue"
  value       = module.fifo_queue.queue_arn
}

output "fifo_queue_name" {
  description = "Name of the FIFO queue"
  value       = module.fifo_queue.queue_name
}

# High Throughput Queue Outputs
output "high_throughput_queue_url" {
  description = "URL of the high throughput queue"
  value       = module.high_throughput_queue.queue_url
}

output "high_throughput_queue_arn" {
  description = "ARN of the high throughput queue"
  value       = module.high_throughput_queue.queue_arn
}

output "high_throughput_queue_name" {
  description = "Name of the high throughput queue"
  value       = module.high_throughput_queue.queue_name
}

