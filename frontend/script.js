// JavaScript

actions=[]
async function updateStatus() {
    for (let action of actions) {
        try {
            console.log("Calling API...");
            const res = await fetch('/status/'.concat(action)); // Backend proxy endpoint
            const data = await res.json();
            const statusDiv = document.getElementById('gh-status-'.concat(action) + org);
            statusDiv.innerHTML = `
                Workflow: ${data.name} <br>
                Status: <span style="color:${data.status === 'success' ? 'green' : 'red'}">${data.status}</span>
                <br><a href="${data.html_url}" target="_blank">View on GitHub</a>
            `;
        } catch (err) {
            console.error(err);
        }
    }
}
  
updateStatus();
setInterval(updateStatus, 5000); // Refresh every 5 seconds