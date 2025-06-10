plugin "aws" {
  enabled = true
  version = "0.23.1"
  source  = "github.com/terraform-linters/tflint-ruleset-aws"
}

plugin "azurerm" {
  enabled = true
  version = "0.23.0"
  source  = "github.com/terraform-linters/tflint-ruleset-azurerm"
}

plugin "google" {
  enabled = true
  version = "0.23.1"
  source  = "github.com/terraform-linters/tflint-ruleset-google"
}

config {
  module = true
  force = false
  disabled_by_default = false
}

rule "terraform_deprecated_interpolation" {
  enabled = true
}

rule "terraform_deprecated_index" {
  enabled = true
}

rule "terraform_unused_declarations" {
  enabled = true
}

rule "terraform_comment_syntax" {
  enabled = true
}

rule "terraform_documented_outputs" {
  enabled = true
}

rule "terraform_documented_variables" {
  enabled = true
}

rule "terraform_typed_variables" {
  enabled = true
}

rule "terraform_naming_convention" {
  enabled = true
}

rule "terraform_required_version" {
  enabled = true
}

rule "terraform_required_providers" {
  enabled = true
}

rule "terraform_standard_module_structure" {
  enabled = true
}
