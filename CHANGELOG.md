## [1.0.2](https://github.com/islamelkadi/terraform-aws-sqs/compare/v1.0.1...v1.0.2) (2026-03-08)


### Bug Fixes

* add CKV_TF_1 suppression for external module metadata ([af979d7](https://github.com/islamelkadi/terraform-aws-sqs/commit/af979d79b9a5191977e365b1d03dfc7217ee2264))
* add skip-path for .external_modules in Checkov config ([7ccc5b5](https://github.com/islamelkadi/terraform-aws-sqs/commit/7ccc5b5a59090631e9cf8082f4ea9388f8feff0d))
* address Checkov security findings ([0b0b492](https://github.com/islamelkadi/terraform-aws-sqs/commit/0b0b4922bb3894ae1180e054da8537db63b495ab))
* correct .checkov.yaml format to use simple list instead of id/comment dict ([d45f642](https://github.com/islamelkadi/terraform-aws-sqs/commit/d45f642c01fff4cee12376f7945ff827020c4839))
* remove skip-path from .checkov.yaml, rely on workflow-level skip_path ([5badb04](https://github.com/islamelkadi/terraform-aws-sqs/commit/5badb0473f233250b9ed93f74fe850fd42d38cd8))
* update workflow path reference to terraform-security.yaml ([cea04c2](https://github.com/islamelkadi/terraform-aws-sqs/commit/cea04c20fee4a2169b9e75a9f753f0dcba232ad5))

## [1.0.1](https://github.com/islamelkadi/terraform-aws-sqs/compare/v1.0.0...v1.0.1) (2026-03-08)


### Code Refactoring

* enhance examples with real infrastructure and improve code quality ([9943544](https://github.com/islamelkadi/terraform-aws-sqs/commit/99435443b9340faf3c6de4e467a21117470a5831))

## 1.0.0 (2026-03-07)


### ⚠ BREAKING CHANGES

* First publish - SQS Terraform module

### Features

* First publish - SQS Terraform module ([d25893a](https://github.com/islamelkadi/terraform-aws-sqs/commit/d25893a28125ed4b58c43a136c5b2c85d6b423be))
