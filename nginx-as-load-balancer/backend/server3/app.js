const express = require('express');
const os = require('os');
const app = express();

app.use(express.static('/usr/src/app/frontend'));

app.get('/', (req, res) => {
  res.send(`
    <div style="font-family: Arial, sans-serif; text-align:center; padding:50px;">
      <h1 style="color:#4D96FF">Hello from SERVER 3 (${os.hostname()})</h1>
      <p>This is your backend server response.</p>
    </div>
  `);
});

app.get('/hello', (req, res) => {
  const colors = ["#FF6B6B", "#6BCB77", "#4D96FF"];
  const randomColor = colors[Math.floor(Math.random() * colors.length)];

  res.send(`
    <div style="font-family: Arial, sans-serif; text-align:center; padding:50px;">
      <h1 style="color:${randomColor}">Hello from SERVER 3 </h1>
      <p style="color:#555;">This is your backend server response.</p>
    </div>
  `);
});

app.listen(3000, () => console.log(`SERVER 3 running on port 3000`));
