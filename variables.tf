variable "oauth_token_id" {
  type = map(string)
	default = {
		grantorchard = "ot-2ttJLCWKcm9ombTH"
		se-apj-demos = "ot-qggSvEnsXcykD2gm"
		lcrowther-snyk = "ot-ZCqWYNaFZibgC888"
	}
}

variable "github_connection_name" {
	type = string
}

variable "tfe_org_name" {
  type = string
  default = "grantorchard"
}

variable "tfe_workspace_name" {
  type = string
  default = ""
}

variable "tfe_auto_apply" {
  type = bool
  default = false
}

variable "env_var" {
	default = []
	type = list(object({
    name = string
    value = any
    sensitive = bool
  }))
}

variable "tf_var" {
	default = []
	type = list(object({
    name = string
    value = any
    sensitive = bool
  }))
}

variable "project_name" {
	default = ""
}

variable "execution_mode" {
	default = "remote"
	# validation {
  #   #there is a way to use /i here but I haven't managed to get it working. Using "lower" instead.
	# 	condition     = can(regex(lower(var.execution_mode)), "remote|local|agent")
  #   error_message = "The execution_mode variable must be one of remote, local, or agent."
  # }
}

variable "github_repository_full_name" {
	type = string
}

variable "github_repository_branch" {
	type = string
	default = "main"
}

variable "workspace_description" {
	type = string
	default = ""
}