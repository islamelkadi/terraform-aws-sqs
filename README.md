# Terraform AWS SQS Module

Creates AWS SQS queues with encryption, dead letter queue support, and FIFO capabilities.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Security](#security)
- [Features](#features)
- [Usage](#usage)
- [Requirements](#requirements)
- [MCP Servers](#mcp-servers)

## Prerequisites

This module is designed for macOS. The following must already be installed on your machine:
- Python 3 and pip
- [Kiro](https://kiro.dev) and Kiro CLI
- [Homebrew](https://brew.sh)

To install the remaining development tools, run:

```bash
make bootstrap
```

This will install/upgrade: tfenv, Terraform (via tfenv), tflint, terraform-docs, checkov, and pre-commit.

## Security

### Security Controls

This module implements security controls to comply with:
- AWS Foundational Security Best Practices (FSBP)
- CIS AWS Foundations Benchmark
- NIST 800-53 Rev 5
- NIST 800-171 Rev 2
- PCI DSS v4.0

### Implemented Controls

- [x] **Encryption**: KMS encryption at rest with customer-managed keys
- [x] **Encryption in Transit**: TLS 1.2+ for all message operations
- [x] **Dead Letter Queue**: Support for failed message handling
- [x] **Message Retention**: Configurable retention periods
- [x] **Access Control**: IAM policies for queue access management
- [x] **Security Control Overrides**: Extensible override system with audit justification

### Security Best Practices

**Production Queues:**
- Use KMS customer-managed keys for encryption
- Configure dead letter queues for error handling
- Set appropriate message retention periods
- Use IAM policies to restrict queue access
- Monitor queue metrics in CloudWatch

**Development Queues:**
- KMS encryption still recommended
- Shorter retention periods acceptable

For complete security standards and implementation details, see [AWS Security Standards](../../../.kiro/steering/aws/aws-security-standards.md).

### Environment-Based Security Controls

Security controls are automatically applied based on the environment through the [terraform-aws-metadata](https://github.com/islamelkadi/terraform-aws-metadata?tab=readme-ov-file#security-profiles) module's security profiles:

| Control | Dev | Staging | Prod |
|---------|-----|---------|------|
| KMS encryption | Optional | Required | Required |
| Encryption in transit (TLS 1.2+) | Required | Required | Required |
| Dead letter queue | Optional | Recommended | Required |
| Access control (IAM) | Enforced | Enforced | Enforced |

For full details on security profiles and how controls vary by environment, see the [Security Profiles](https://github.com/islamelkadi/terraform-aws-metadata?tab=readme-ov-file#security-profiles) documentation.

### Security Best Practices

**Production Queues:**
- Use KMS customer-managed keys for encryption
- Configure dead letter queues for error handling
- Set appropriate message retention periods
- Use IAM policies to restrict queue access
- Monitor queue metrics in CloudWatch

**Development Queues:**
- KMS encryption still recommended
- Shorter retention periods acceptable

For complete security standards and implementation details, see [AWS Security Standards](../../../.kiro/steering/aws/aws-security-standards.md).
## Usage

### Basic Example
```hcl
module "queue" {
  source = "github.com/islamelkadi/terraform-aws-sqs"
  
  namespace   = "example"
  environment = "prod"
  name        = "corporate-actions-dlq"
  region      = "us-east-1"
  
  # KMS encryption
  kms_key_arn = module.kms.key_arn
  
  # Message retention (4 days)
  message_retention_seconds = 345600
}
```

### With Dead Letter Queue
```hcl
module "dlq" {
  source = "github.com/islamelkadi/terraform-aws-sqs"
  
  namespace   = "example"
  environment = "prod"
  name        = "corporate-actions-dlq"
  region      = "us-east-1"
  
  kms_key_arn = module.kms.key_arn
}

module "main_queue" {
  source = "github.com/islamelkadi/terraform-aws-sqs"
  
  namespace   = "example"
  environment = "prod"
  name        = "corporate-actions"
  region      = "us-east-1"
  
  kms_key_arn = module.kms.key_arn
  
  # DLQ configuration
  dead_letter_target_arn = module.dlq.queue_arn
  max_receive_count      = 3
}
```

## MCP Servers

This module includes two [Model Context Protocol (MCP)](https://modelcontextprotocol.io/) servers configured in `.kiro/settings/mcp.json` for use with Kiro:

| Server | Package | Description |
|--------|---------|-------------|
| `aws-docs` | `awslabs.aws-documentation-mcp-server@latest` | Provides access to AWS documentation for contextual lookups of service features, API references, and best practices. |
| `terraform` | `awslabs.terraform-mcp-server@latest` | Enables Terraform operations (init, validate, plan, fmt, tflint) directly from the IDE with auto-approved commands for common workflows. |

Both servers run via `uvx` and require no additional installation beyond the [bootstrap](#prerequisites) step.

<!-- BEGIN_TF_DOCS -->

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.14.3 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 6.34 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 6.34 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_metadata"></a> [metadata](#module\_metadata) | github.com/islamelkadi/terraform-aws-metadata | v1.1.0 |

## Resources

| Name | Type |
|------|------|
| [aws_sqs_queue.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue) | resource |
| [aws_sqs_queue_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_attributes"></a> [attributes](#input\_attributes) | Additional attributes for naming | `list(string)` | `[]` | no |
| <a name="input_content_based_deduplication"></a> [content\_based\_deduplication](#input\_content\_based\_deduplication) | Enable content-based deduplication for FIFO queues | `bool` | `false` | no |
| <a name="input_dead_letter_target_arn"></a> [dead\_letter\_target\_arn](#input\_dead\_letter\_target\_arn) | ARN of the dead-letter queue to which Amazon SQS moves messages after maxReceiveCount | `string` | `null` | no |
| <a name="input_deduplication_scope"></a> [deduplication\_scope](#input\_deduplication\_scope) | Specifies whether message deduplication occurs at the message group or queue level | `string` | `"queue"` | no |
| <a name="input_delimiter"></a> [delimiter](#input\_delimiter) | Delimiter to use between name components | `string` | `"-"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment name (dev, staging, prod) | `string` | n/a | yes |
| <a name="input_fifo_queue"></a> [fifo\_queue](#input\_fifo\_queue) | Whether this queue is a FIFO queue | `bool` | `false` | no |
| <a name="input_fifo_throughput_limit"></a> [fifo\_throughput\_limit](#input\_fifo\_throughput\_limit) | Specifies whether the FIFO queue throughput quota applies to the entire queue or per message group | `string` | `"perQueue"` | no |
| <a name="input_kms_data_key_reuse_period_seconds"></a> [kms\_data\_key\_reuse\_period\_seconds](#input\_kms\_data\_key\_reuse\_period\_seconds) | Length of time in seconds for which Amazon SQS can reuse a data key | `number` | `300` | no |
| <a name="input_kms_key_arn"></a> [kms\_key\_arn](#input\_kms\_key\_arn) | ARN of KMS key for encryption at rest | `string` | `null` | no |
| <a name="input_max_receive_count"></a> [max\_receive\_count](#input\_max\_receive\_count) | Maximum number of times a message can be received before being sent to DLQ | `number` | `3` | no |
| <a name="input_message_retention_seconds"></a> [message\_retention\_seconds](#input\_message\_retention\_seconds) | Number of seconds Amazon SQS retains a message (60-1209600) | `number` | `345600` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the SQS queue | `string` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace (organization/team name) | `string` | n/a | yes |
| <a name="input_queue_policy"></a> [queue\_policy](#input\_queue\_policy) | JSON policy document for the queue | `string` | `null` | no |
| <a name="input_receive_wait_time_seconds"></a> [receive\_wait\_time\_seconds](#input\_receive\_wait\_time\_seconds) | Time for which a ReceiveMessage call will wait for a message to arrive (long polling) | `number` | `0` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS region where resources will be created | `string` | n/a | yes |
| <a name="input_security_control_overrides"></a> [security\_control\_overrides](#input\_security\_control\_overrides) | Override specific security controls with documented justification | <pre>object({<br/>    disable_kms_requirement = optional(bool, false)<br/>    justification           = optional(string, "")<br/>  })</pre> | <pre>{<br/>  "disable_kms_requirement": false,<br/>  "justification": ""<br/>}</pre> | no |
| <a name="input_security_controls"></a> [security\_controls](#input\_security\_controls) | Security controls configuration from metadata module | <pre>object({<br/>    encryption = object({<br/>      require_kms_customer_managed  = bool<br/>      require_encryption_at_rest    = bool<br/>      require_encryption_in_transit = bool<br/>      enable_kms_key_rotation       = bool<br/>    })<br/>  })</pre> | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags to apply to resources | `map(string)` | `{}` | no |
| <a name="input_visibility_timeout_seconds"></a> [visibility\_timeout\_seconds](#input\_visibility\_timeout\_seconds) | Visibility timeout for the queue in seconds | `number` | `30` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_queue_arn"></a> [queue\_arn](#output\_queue\_arn) | ARN of the SQS queue |
| <a name="output_queue_id"></a> [queue\_id](#output\_queue\_id) | URL of the SQS queue |
| <a name="output_queue_name"></a> [queue\_name](#output\_queue\_name) | Name of the SQS queue |
| <a name="output_queue_url"></a> [queue\_url](#output\_queue\_url) | URL of the SQS queue |
| <a name="output_tags"></a> [tags](#output\_tags) | Tags applied to the SQS queue |

