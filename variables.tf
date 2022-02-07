variable "github_pat" {
  description = "(Required) A github personal access token to create the VCS connection."
  sensitive   = true
  type        = string
}

variable "tfe_token" {
  description = "(Required) A Terraform cloud API token."
  sensitive   = true
  type        = string
}