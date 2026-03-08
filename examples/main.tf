# Primary Module Example - This demonstrates the terraform-aws-sqs module
# Supporting infrastructure (KMS) is defined in separate files
# to keep this example focused on the module's core functionality.
#
# SQS Queue Examples
# Demonstrates standard and FIFO queue configurations with security control overrides

# ============================================================================
# Example 1: Standard SQS Queue with Dead Letter Queue
# Basic configuration with KMS encryption
# ============================================================================

module "standard_queue" {
  source = "../"

  namespace   = var.namespace
  environment = var.environment
  name        = "events"
  region      = var.region

  # Queue configuration
  message_retention_seconds  = 345600 # 4 days
  visibility_timeout_seconds = 30
  receive_wait_time_seconds  = 10 # Enable long polling

  # Direct reference to kms.tf module output
  kms_key_arn = module.kms_key.key_arn

  # Dead letter queue
  dead_letter_target_arn = module.dlq.queue_arn
  max_receive_count      = 3

  tags = {
    Project = var.project_name
    Example = "standard-queue"
  }
}

# Dead letter queue for failed messages
module "dlq" {
  source = "../"

  namespace   = var.namespace
  environment = var.environment
  name        = "events-dlq"
  region      = var.region

  message_retention_seconds = 1209600 # 14 days (maximum)

  # Direct reference to kms.tf module output
  kms_key_arn = module.kms_key.key_arn

  tags = {
    Project = var.project_name
    Purpose = "DeadLetterQueue"
    Example = "dlq"
  }
}

# ============================================================================
# Example 2: FIFO Queue (First-In-First-Out)
# Guarantees message ordering and exactly-once processing
# ============================================================================

module "fifo_queue" {
  source = "../"

  namespace   = var.namespace
  environment = var.environment
  name        = "orders"
  region      = var.region

  # FIFO configuration
  fifo_queue                  = true
  content_based_deduplication = true
  deduplication_scope         = "messageGroup"
  fifo_throughput_limit       = "perMessageGroupId"

  # Queue configuration
  message_retention_seconds  = 345600 # 4 days
  visibility_timeout_seconds = 60

  # Direct reference to kms.tf module output
  kms_key_arn = module.kms_key.key_arn

  tags = {
    Project   = var.project_name
    QueueType = "FIFO"
    Example   = "fifo-queue"
  }
}

# ============================================================================
# Example 3: High-Throughput Standard Queue
# Optimized for high message volume with long polling
# ============================================================================

module "high_throughput_queue" {
  source = "../"

  namespace   = var.namespace
  environment = var.environment
  name        = "notifications"
  region      = var.region

  # Queue configuration optimized for throughput
  message_retention_seconds  = 86400 # 1 day (faster cleanup)
  visibility_timeout_seconds = 30
  receive_wait_time_seconds  = 20 # Maximum long polling

  # Direct reference to kms.tf module output
  kms_key_arn = module.kms_key.key_arn

  tags = {
    Project = var.project_name
    Purpose = "HighThroughput"
    Example = "high-throughput"
  }
}
