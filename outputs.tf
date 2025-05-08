output "repo_url" {
  value       = github_repository.gh_repo.html_url
  description = "The URL of the created repository."
}

output "repo_name" {
  value = github_repository.gh_repo.full_name
  description = "The Name of the created repository."
}