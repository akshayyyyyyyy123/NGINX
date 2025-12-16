const express = require('express');
const os = require('os');
const app = express();

// Serve frontend if needed
app.use(express.static('/usr/src/app/frontend'));

// Simulate response time
app.get('/', (req, res) => {
  const colors = ["#FF6B6B", "#6BCB77", "#4D96FF"];
  const randomColor = colors[Math.floor(Math.random() * colors.length)];

  res.send(`
    <div style="font-family: Arial, sans-serif; text-align:center; padding:50px;">
      <h1 style="color:${randomColor}">Hello from ${os.hostname()}</h1>
      <p style="color:#555;">This is your backend server response.</p>
    </div>
  `);
});

// 🔥 NEW route for NGINX (/api/hello → /hello)
app.get('/hello', (req, res) => {
  const colors = ["#FF6B6B", "#6BCB77", "#4D96FF"];
  const randomColor = colors[Math.floor(Math.random() * colors.length)];

  res.send(`
    <div style="font-family: Arial, sans-serif; text-align:center; padding:50px;">
      <h1 style="color:${randomColor}">Hello from Server1</h1>
      <p style="color:#555;">This is your backend server response.</p>
    </div>
  `);
});


app.listen(3000, () => console.log(`${os.hostname()} running on port 3000`));
