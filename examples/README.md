# SQS Queue Example

This example demonstrates how to create SQS queues with encryption, dead letter queues, and FIFO configuration.

## Features

- Standard SQS queue with encryption
- Dead letter queue (DLQ) for failed messages
- FIFO queue with content-based deduplication
- KMS encryption for all queues
- Long polling enabled

## Usage

```bash
# Initialize Terraform
terraform init

# Review the plan
terraform plan -var-file=params/input.tfvars

# Apply the configuration
terraform apply -var-file=params/input.tfvars

# Clean up
terraform destroy -var-file=params/input.tfvars
```

## What This Creates

1. **KMS Key**: Customer-managed key for queue encryption
2. **Standard Queue**: Main event queue with DLQ configuration
3. **Dead Letter Queue**: Captures failed messages after 3 retries
4. **FIFO Queue**: Ordered queue with message deduplication

## Queue Configuration

### Standard Queue
- Message retention: 4 days
- Visibility timeout: 30 seconds
- Long polling: 10 seconds
- Max receive count: 3 (before DLQ)

### FIFO Queue
- Content-based deduplication enabled
- Per-message-group throughput limit
- Message group-level deduplication

## Security

- All queues encrypted with KMS customer-managed key
- Key rotation enabled
- Security controls enforced via metadata module
