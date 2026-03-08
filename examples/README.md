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

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.14.3 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 6.34 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_dlq"></a> [dlq](#module\_dlq) | ../ | n/a |
| <a name="module_fifo_queue"></a> [fifo\_queue](#module\_fifo\_queue) | ../ | n/a |
| <a name="module_high_throughput_queue"></a> [high\_throughput\_queue](#module\_high\_throughput\_queue) | ../ | n/a |
| <a name="module_kms_key"></a> [kms\_key](#module\_kms\_key) | git::https://github.com/islamelkadi/terraform-aws-kms.git | v1.0.0 |
| <a name="module_standard_queue"></a> [standard\_queue](#module\_standard\_queue) | ../ | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | Environment name (dev, staging, prod) | `string` | `"dev"` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace (organization/team name) | `string` | `"example"` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Project name for tagging | `string` | `"example-project"` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS region for resources | `string` | `"us-east-1"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dlq_arn"></a> [dlq\_arn](#output\_dlq\_arn) | ARN of the dead letter queue |
| <a name="output_dlq_name"></a> [dlq\_name](#output\_dlq\_name) | Name of the dead letter queue |
| <a name="output_dlq_url"></a> [dlq\_url](#output\_dlq\_url) | URL of the dead letter queue |
| <a name="output_fifo_queue_arn"></a> [fifo\_queue\_arn](#output\_fifo\_queue\_arn) | ARN of the FIFO queue |
| <a name="output_fifo_queue_name"></a> [fifo\_queue\_name](#output\_fifo\_queue\_name) | Name of the FIFO queue |
| <a name="output_fifo_queue_url"></a> [fifo\_queue\_url](#output\_fifo\_queue\_url) | URL of the FIFO queue |
| <a name="output_high_throughput_queue_arn"></a> [high\_throughput\_queue\_arn](#output\_high\_throughput\_queue\_arn) | ARN of the high throughput queue |
| <a name="output_high_throughput_queue_name"></a> [high\_throughput\_queue\_name](#output\_high\_throughput\_queue\_name) | Name of the high throughput queue |
| <a name="output_high_throughput_queue_url"></a> [high\_throughput\_queue\_url](#output\_high\_throughput\_queue\_url) | URL of the high throughput queue |
| <a name="output_standard_queue_arn"></a> [standard\_queue\_arn](#output\_standard\_queue\_arn) | ARN of the standard SQS queue |
| <a name="output_standard_queue_name"></a> [standard\_queue\_name](#output\_standard\_queue\_name) | Name of the standard SQS queue |
| <a name="output_standard_queue_url"></a> [standard\_queue\_url](#output\_standard\_queue\_url) | URL of the standard SQS queue |
<!-- END_TF_DOCS -->

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
