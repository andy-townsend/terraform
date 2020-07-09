

resource "github_team" "team-engineers" {
  name        = "engineers"
  description = "team for engineers"
  privacy     = "closed"
}

resource "github_team_membership" "team-engineers-mem-andy-townsend" {
  team_id  = github_team.team-engineers.id
  username = "andy-townsend"
  role     = "member"
}
