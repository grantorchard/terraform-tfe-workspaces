# Environment variables for the TFE provider:
# TFE_TOKEN
# TFE_HOSTNAME

resource "tfe_agent_pool" "this" {
	count        = lower(var.execution_mode) == "agent" ? 1 : 0
  name         = var.project_name
  organization = var.tfe_org_name
}

resource "tfe_workspace" "this" {
  name         = var.project_name
  organization = var.tfe_org_name
  auto_apply   = var.tfe_auto_apply
	description  = var.workspace_description

	execution_mode = var.execution_mode
	agent_pool_id  = lower(var.execution_mode) == "agent" ? tfe_agent_pool.this[0].id : null
	queue_all_runs  = "false"

  vcs_repo {
    identifier = var.github_repository_full_name
    branch     = var.github_repository_branch
    oauth_token_id = lookup(var.oauth_token_id, var.github_connection_name)
  }
}

resource "tfe_variable" "env" {
  for_each     = { for v in var.env_var: v.name => v }
  key          = each.value.name
  value        = each.value.value
  sensitive    = each.value.sensitive
  category     = "env"
  workspace_id = tfe_workspace.this.id
}

resource "tfe_variable" "tf" {
  for_each     = { for v in var.tf_var: v.name => v }
  key          = each.value.name
  value        = each.value.value
  sensitive    = each.value.sensitive
  category     = "terraform"
  workspace_id = tfe_workspace.this.id
}
