resource "random_pet" "instance" {}

module "organization" {
  source = "github.com/jamesrcounts/terraform-tfe-organization.git"

  email      = "nobody@example.com"
  github_pat = var.github_pat
  name       = random_pet.instance.id
}

module "registry" {
  source = "github.com/jamesrcounts/terraform-tfe-registry.git"

  oauth_token_id = module.organization.github_token_id


  modules = {
    organization = "jamesrcounts/terraform-tfe-organization"
    workspace    = "jamesrcounts/terraform-tfe-workspace"
    registry     = "jamesrcounts/terraform-tfe-registry"
  }
}

module "workspace" {
  source = "github.com/jamesrcounts/terraform-tfe-workspace.git"

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