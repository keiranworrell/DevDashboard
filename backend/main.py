from fastapi import FastAPI
import yaml
import requests
import os

app = FastAPI()

CONFIG_PATH = "/mnt/config.yaml"
GITHUB_API = "https://api.github.com"

# Load config at startup
with open(CONFIG_PATH, "r") as f:
    config = yaml.safe_load(f)

GITHUB_TOKEN = os.getenv("GITHUB_TOKEN")
HEADERS = {"Authorization": f"Bearer {GITHUB_TOKEN}"}

workflows = []
dev_dash = config.get("devDash", {})
for org, repos in dev_dash.items():
    for repo, repo_data in repos.items():
        actions = repo_data.get("actions", {})
        if isinstance(actions, dict):
            for workflow_file, display_name in actions.items():
                workflows.append({"org": org, "repo": repo, "workflow": workflow_file, "display_name": display_name})
        elif isinstance(actions, list):
            for item in actions:
                if item:
                    workflows.append({"org": org, "repo": repo, "workflow": item, "display_name": item})

def get_github_status(org, repo, workflow):
    url = f"{GITHUB_API}/repos/{org}/{repo}/actions/workflows/{workflow}/runs?per_page=1"
    r = requests.get(url, headers=HEADERS)
    if r.status_code != 200:
        return {"error": f"GitHub API error: {r.status_code}"}
    data = r.json()
    if not data.get("workflow_runs"):
        return {"status": "no runs found"}
    latest_run = data["workflow_runs"][0]
    print(latest_run)
    return {
        "name": workflow,
        "display_name": latest_run["name"],
        "status": latest_run["conclusion"] or "running",
        "url": latest_run["html_url"],
        "commit": latest_run["head_commit"]["message"],
        "run_number": latest_run["run_number"],
        "timestamp": latest_run["created_at"].split('T')[0] + '  ' + latest_run["created_at"].split('T')[1].split('Z')[0]
    }

# Dynamically create endpoints based on config
for wf in workflows:
    org = wf["org"]
    repo = wf["repo"]
    workflow = wf["workflow"]
    route_path = f"/status/{org}-{repo}-{workflow.replace('.yaml','').replace('.yml','')}"


    def create_route(o, r, w):
        @app.get(route_path)
        def status():
            return get_github_status(o, r, w)
    create_route(org, repo, workflow)
