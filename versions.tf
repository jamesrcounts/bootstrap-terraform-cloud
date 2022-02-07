terraform {
  required_version = ">= 1"

  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~>3.1.0"
    }
    tfe = {
      source  = "hashicorp/tfe"
      version = "~> 0.28.1"
    }
  }
}