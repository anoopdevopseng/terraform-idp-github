variable "template_org" {
  description = "The name of the organization in Github that will contain the example app repo."
  default     = ""
}

variable "template_repo" {
  description = "The name of the repository in Github that contains the example app code."
  default     = ""
}

variable "destination_org" {
  description = "The name of the organization in Github that will contain the templated repo."
  default = ""
}

variable "repo_description" {
  description = "Readme file content."
  default     = ""
}

variable "gh_token" {
  description = "Github token with permissions to create and delete repos."
  sensitive   = true
}

variable "repository_secrets" {
  type = map(string)
  default = {}
}

variable "environment_secrets" {
  description = "Map of environment names to their secrets"
  type = map(map(string))
  default = {}
}

variable "application_name" {
  type        = string
  description = "Name of the application."

  validation {
    condition     = !contains(["-", "_"], var.application_name)
    error_message = "application must not contain dashes or underscores."
  }
}

variable "visibility" {
  type = string
  default = "private"
}