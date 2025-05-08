
### Setup the Repository
resource "github_repository" "gh_repo" {
  name        = var.application_name
  visibility  = var.visibility
  auto_init   = true
}


### Add Readme file 
resource "github_repository_file" "readme" {
  repository = github_repository.gh_repo.name
  branch     = "main"
  file       = "README.md"
  content = templatefile("${path.module}/templates/README.md.tpl", {
    application_name  = var.application_name,
    description   = var.repo_description
  })
  commit_message      = "Added readme file."
  commit_author       = "plattform engineer"
  commit_email        = "terraform@example.com"
  overwrite_on_create = true
}


### Add secret in Repository
resource "github_actions_secret" "repo_secrets" {
  for_each = length(var.repository_secrets) > 0 ? var.repository_secrets : {}

  repository      = github_repository.gh_repo.name
  secret_name     = each.key
  plaintext_value = each.value
}


locals {
  flattened_env_secrets = merge([
    for env_name, secrets in var.environment_secrets : {
      for secret_name, secret_value in secrets :
      "${env_name}-${secret_name}" => {
        environment     = env_name
        secret_name     = secret_name
        plaintext_value = secret_value
      }
    }
  ]...)
}

resource "github_actions_environment_secret" "env_secrets" {
  for_each = local.flattened_env_secrets

  repository      = github_repository.gh_repo.name
  environment     = each.value.environment
  secret_name     = each.value.secret_name
  plaintext_value = each.value.plaintext_value
}