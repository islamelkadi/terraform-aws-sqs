# SQS Queue Module Locals

locals {
  # Use metadata module for standardized naming
  queue_name_base = module.metadata.resource_prefix

  # Construct queue name with optional attributes and FIFO suffix
  queue_name_with_attrs = length(var.attributes) > 0 ? "${local.queue_name_base}-${join(var.delimiter, var.attributes)}" : local.queue_name_base
  queue_name            = var.fifo_queue ? "${local.queue_name_with_attrs}.fifo" : local.queue_name_with_attrs

  # Merge tags with defaults
  tags = merge(
    var.tags,
    module.metadata.security_tags,
    {
      Name   = local.queue_name
      Module = "terraform-aws-sqs"
    }
  )
}
