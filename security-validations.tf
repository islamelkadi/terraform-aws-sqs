# Security Controls Validations
# Enforces security standards based on metadata module security controls
# Supports selective overrides with documented justification

locals {
  # Use security controls if provided, otherwise use permissive defaults
  security_controls = var.security_controls != null ? var.security_controls : {
    encryption = {
      require_kms_customer_managed  = false
      require_encryption_at_rest    = false
      require_encryption_in_transit = false
      enable_kms_key_rotation       = false
    }
  }

  # Apply overrides to security controls
  kms_encryption_required = local.security_controls.encryption.require_kms_customer_managed && !var.security_control_overrides.disable_kms_requirement

  # Validation results
  kms_validation_passed = !local.kms_encryption_required || var.kms_key_arn != null

  # Audit trail for overrides
  has_overrides          = var.security_control_overrides.disable_kms_requirement
  justification_provided = var.security_control_overrides.justification != ""
  override_audit_passed  = !local.has_overrides || local.justification_provided
}

# Security Controls Check Block
check "security_controls_compliance" {
  assert {
    condition     = local.kms_validation_passed
    error_message = "Security control violation: KMS customer-managed key is required but kms_key_arn is not provided. Set security_control_overrides.disable_kms_requirement=true with justification if this is intentional."
  }

  assert {
    condition     = local.override_audit_passed
    error_message = "Security control overrides detected but no justification provided. Please document the business reason in security_control_overrides.justification for audit compliance."
  }
}
