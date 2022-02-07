resource "random_pet" "instance" {}

module "organization" {
  source  = "app.terraform.io/welcome-cow/organization/tfe"
  version = "0.0.3"

  email      = "nobody@example.com"
  github_pat = var.github_pat
  name       = random_pet.instance.id
}

module "registry" {
  source  = "app.terraform.io/welcome-cow/registry/tfe"
  version = "0.0.1"

  oauth_token_id = module.organization.github_token_id


  modules = {
    organization = "jamesrcounts/terraform-tfe-organization"
    workspace    = "jamesrcounts/terraform-tfe-workspace"
    registry     = "jamesrcounts/terraform-tfe-registry"
  }
}

module "workspace" {
  source  = "app.terraform.io/welcome-cow/workspace/tfe"
  version = "0.0.4"

  name              = "governance-root"
  organization_name = module.organization.name

  environment = {
    TFE_TOKEN = {
      description = "An admin token for Terraform Cloud"
      sensitive   = true
      value       = var.tfe_token
    }
  }
}