resource "github_repository" "repo-example" {
  name          = "example"
  description   = "This is an example repo created via Terraform"
  has_issues    = false
  has_projects  = false
  has_wiki      = false
  auto_init     = true
  has_downloads = false
  private       = true
}

resource "github_team_repository" "team-repo-example-engineers" {
  team_id    = data.github_team.team-engineers.id
  repository = github_repository.repo-example.name
  permission = "push"
}

output "repo-example-url" {
  value = github_repository.repo-example.ssh_clone_url
  description = "SSH Clone URL for repo"
}