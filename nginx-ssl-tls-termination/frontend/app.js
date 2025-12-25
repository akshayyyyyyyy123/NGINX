const btn = document.getElementById("btn");
const responseDiv = document.getElementById("response");

btn.addEventListener("click", async () => {
  responseDiv.innerHTML = "⏳ Fetching backend response...";

  try {
    const res = await fetch("/api/hello");
    const text = await res.text();
    responseDiv.innerHTML = text;
  } catch (err) {
    responseDiv.innerHTML = "❌ Error contacting backend";
  }
});
