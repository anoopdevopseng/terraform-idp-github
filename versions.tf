provider "github" {
  owner = var.destination_org
  token = var.gh_token
}

terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }
  }
}

