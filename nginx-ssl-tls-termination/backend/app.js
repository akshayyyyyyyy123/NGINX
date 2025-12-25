const express = require('express');
const os = require('os');

const app = express();

app.get('/hello/', (req, res) => {
  res.send(`
    <div style="text-align:center; font-family:Segoe UI;">
      <h2>✅ Response from Backend</h2>
      <p><strong>Hostname:</strong> ${os.hostname()}</p>
      <p>Served over <b>HTTP</b> (TLS terminated at NGINX)</p>
    </div>
  `);
});

app.listen(3000, () => {
  console.log('Backend running on port 3000');
});
