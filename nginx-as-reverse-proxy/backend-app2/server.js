const express = require("express");
const app = express();

app.get("/app2", (req, res) => {
  res.json({ message: "Hello from App 2!" });
});

app.listen(3002, () => {
  console.log("App2 running on port 3002");
});
