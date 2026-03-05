# SQS Queue Module
# Creates AWS SQS queue with encryption and dead letter queue support

# SQS Queue
resource "aws_sqs_queue" "this" {
  name = local.queue_name

  # Message retention (1 minute to 14 days)
  message_retention_seconds = var.message_retention_seconds

  # Visibility timeout
  visibility_timeout_seconds = var.visibility_timeout_seconds

  # Receive wait time for long polling
  receive_wait_time_seconds = var.receive_wait_time_seconds

  # Encryption at rest with KMS
  kms_master_key_id                 = var.kms_key_arn
  kms_data_key_reuse_period_seconds = var.kms_data_key_reuse_period_seconds

  # Dead letter queue configuration
  redrive_policy = var.dead_letter_target_arn != null ? jsonencode({
    deadLetterTargetArn = var.dead_letter_target_arn
    maxReceiveCount     = var.max_receive_count
  }) : null

  # FIFO queue configuration
  fifo_queue                  = var.fifo_queue
  content_based_deduplication = var.fifo_queue ? var.content_based_deduplication : null
  deduplication_scope         = var.fifo_queue ? var.deduplication_scope : null
  fifo_throughput_limit       = var.fifo_queue ? var.fifo_throughput_limit : null

  tags = local.tags
}

# SQS Queue Policy (optional)
resource "aws_sqs_queue_policy" "this" {
  count = var.queue_policy != null ? 1 : 0

  queue_url = aws_sqs_queue.this.id
  policy    = var.queue_policy
}
