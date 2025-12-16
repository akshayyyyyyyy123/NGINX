# 🚀 NGINX as a Load Balancer

This project demonstrates how **NGINX works as a Layer-7 (HTTP) load balancer** using Docker and Docker Compose.

A single NGINX container sits in front of **multiple backend application servers** and distributes incoming requests across them.

---

## 📌 High-Level Architecture

```bash
└── 📁nginx-as-load-balancer
    └── 📁backend
        └── 📁server1
            ├── app.js
        └── 📁server2
            ├── app.js
        └── 📁server3
            ├── app.js
    └── 📁frontend
        ├── index.html
    ├── application.Dockerfile
    ├── docker-compose.yaml
    ├── load_test.sh
    ├── nginx.conf
    └── nginx.Dockerfile
```


- NGINX listens on one port
- Multiple backend servers run the **same code**
- Requests are load balanced using **round-robin**

---

## What This Project Shows

- What a **load balancer** is and why it’s needed
- How **NGINX acts as a reverse proxy**
- How NGINX distributes traffic to multiple backend servers
- How frontend and backend can be served together
- How Docker Compose helps spin up multiple services easily

---

## Key Components

### NGINX
- Acts as the **single entry point**
- Routes `/` to frontend
- Routes `/api/*` to backend servers
- Distributes traffic across backend containers

### Backend (Node.js + Express)
- Three backend servers (`app1`, `app2`, `app3`)
- All servers use **one common Dockerfile**
- Each server responds with its **hostname**, so load balancing is visible

### Frontend (HTML + CSS + JS)
- Simple UI
- Button triggers an API call
- Shows which backend server handled the request

---

## Why One Dockerfile for All Backends?

- Same application code
- Only server name changes
- Passed using **Docker build arguments**
- Clean, scalable, and production-style setup

---

## How Load Balancing Works Here

1. User opens the application in browser
2. Request hits NGINX
3. NGINX forwards the request to one backend server
4. Each request goes to a **different backend**
5. Response shows which server handled it

---

## Key Learning Takeaways

- Difference between **frontend routes** and **API routes**
- How `proxy_pass` works in NGINX
- Why `/api/*` is used for backend calls
- How load balancers improve scalability and reliability

---

## Run the Project

```bash
docker-compose up --build
```

---

## Open in browser
```bash
http://localhost:1111/
http://localhost:1111/api/hello
```
