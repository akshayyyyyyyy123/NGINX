const express = require("express");
const app = express();

app.get("/app1", (req, res) => {
  res.json({ message: "Hello from App 1!" });
});

app.listen(3001, () => {
  console.log("App1 running on port 3001");
});
