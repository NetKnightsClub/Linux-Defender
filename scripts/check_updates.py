# This is currently broken, occasionly check Linux Defender for updates.
"""
def check_for_updates(repo):
    url = f"https://api.github.com/repos/{repo}/commits"
    response = requests.get(url)
    commits = response.json()

    latest_commit = commits[0]
    print(f"Latest commit: {latest_commit['sha']} - {latest_commit['commit']['message']}")

if __name__ == "__main__":
    repo = "VisAwesme/Linux-Defender"
    check_for_updates(repo)
  """
