// JavaScript

actions=[]
async function updateStatus() {
    for (let action of actions) {
        try {
            console.log("Calling API...");
            const res = await fetch('/status/'.concat(action)); // Backend proxy endpoint
            const data = await res.json();
            const statusDiv = document.getElementById('gh-status-'.concat(action));

            // Determine display title (fallback to file name)
            const title = data.name;

            // Determine border color based on status
            let borderColor;
            switch (data.status) {
            case 'success':
                borderColor = 'green';
                break;
            case 'failed':
                borderColor = 'red';
                break;
            case 'running':
                borderColor = 'white';
                break;
            default:
                borderColor = 'blue'; // No history
                break;
            }

            // // Create a container div
            // const container = document.createElement('div');
            // container.className = 'action-box';
            statusDiv.style.borderColor = borderColor;

            // Fill in content
            statusDiv.innerHTML = `
            <h3>${title}</h3>
            <p>Status: <span class="status-text">${data.status}</span></p>
            <p>Last run: ${data.timestamp || 'N/A'}</p>
            <p><a href="${data.html_url}" target="_blank">View on GitHub</a></p>
            `;
        } catch (err) {
            console.error(err);
        }
    }
}
  
updateStatus();
setInterval(updateStatus, 15000); // Refresh every 15 seconds