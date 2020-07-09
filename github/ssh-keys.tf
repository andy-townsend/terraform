resource "github_user_ssh_key" "andy_townsend_ssh_key" {
  title = "Andy Townsend SSH Key"
  key   = "${file("~/.ssh/andy_townsend.pub")}"
}