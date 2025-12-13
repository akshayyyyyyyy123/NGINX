# 🚀 NGINX as Reverse Proxy - A Docker Compose Project

A clean and beginner-friendly project demonstrating how **NGINX works as a Reverse Proxy** to route traffic to multiple backend services using **Docker & Docker Compose**.

This project exposes a **single gateway** that:
- Serves a **beautiful static landing page**
- Routes requests to **multiple backend Node.js services**
- Demonstrates real-world reverse proxy behavior

---

## 📌 Architecture Overview

```
└── 📁nginx-as-reverse-proxy
    └── 📁app
        ├── index.html
        ├── styles.css
    └── 📁backend-app1
        ├── server.js
    └── 📁backend-app2
        ├── server.js
    ├── app.Dockerfile
    ├── docker-compose.yaml
    ├── load_test.sh
    ├── nginx.conf
    └── reverseProxy.Dockerfile
```


---

## ✨ Features

- ✅ NGINX as a **single entry point**
- ✅ Multiple backend services (Node.js + Express)
- ✅ Static landing page served by NGINX
- ✅ Path-based routing (`/app1`, `/app2`)
- ✅ Dockerized setup using **Docker Compose**
- ✅ Easy to extend with more services

---

## 📂 Project Structure
<img width="851" height="756" alt="Screenshot 2025-12-13 at 9 35 48 PM" src="https://github.com/user-attachments/assets/301f76f1-6cff-4db2-bfdf-5f451a8f4245" />


---

## 🧠 How It Works

### 1️⃣ NGINX Reverse Proxy
- Listens on **port 80** inside the container
- Exposed to host on **port 1111**
- Routes traffic based on URL paths

| Path | Routed To |
|----|----|
| `/` | Static `index.html` |
| `/app1` | Backend App 1 |
| `/app2` | Backend App 2 |

---

### 2️⃣ Static Landing Page
- Served directly by NGINX
- Provides buttons to access backend services
- Uses modern HTML + CSS for a clean UI

---

### 3️⃣ Backend Services
Each backend:
- Runs on **Node.js + Express**
- Listens on its own port
- Returns JSON response

Example:
```json
{
  "message": "Hello from App 1!"
}
```
---

## 🛠️ Dockerfiles

1) nginx reverse proxy dockerfile
```dockerfile
# pull the nginx alpine base image
FROM nginx:alpine

# remove the default nginx log files as they base image has default symlink which directs the output logs to /dev/stdout and /dev/stderr
RUN rm -f /var/log/nginx/*.log && \
    mkdir -p /var/log/nginx/ && \
    touch /var/log/nginx/access.log && \
    touch /var/log/nginx/error.log

# copy the custom nginx.conf file to the nginx conf directory
COPY nginx.conf /etc/nginx/nginx.conf

# copy the application code to the nginx html directory
COPY app/ /usr/share/nginx/html/

# expose port 80
EXPOSE 80

# start the nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]
```

2) Application dockerfile
```
FROM node:alpine

ARG APP_PATH
WORKDIR /app

# copy backend application code
COPY ${APP_PATH}/ .

# install dependencies
RUN npm init -y && npm install express

# start the backend server
CMD ["node", "server.js"]
```

## 🛠️ Docker Compose

```dockerfile
version: "3.9"

# define the list of services
services:
  # reverse-proxy service
  reverse-proxy:
    build:
      context: .
      dockerfile: reverseProxy.Dockerfile
    ports:
      - "1111:80"  
    depends_on:
      - app1
      - app2
    container_name: reverse-proxy 


  # backend app1 service
  app1:
    build:
      context: .
      dockerfile: app.Dockerfile
      args:
        APP_PATH: backend-app1  
    ports:
      - "3001"    
    container_name: app1

  # backend app2 service
  app2:
    build:
      context: .
      dockerfile: app.Dockerfile
      args:
        APP_PATH: backend-app2
    ports:
      - "3002"    
    container_name: app2
```<img width="367" height="150" alt="Screenshot 2025-12-13 at 10 04 07 PM" src="https://github.com/user-attachments/assets/3b8725a6-1511-4476-a696-139f1a91420a" />

---

## 🛠️ Run the application

```bash
docker-compose up
```

<img width="1165" height="1038" alt="Screenshot 2025-12-13 at 9 51 29 PM" src="https://github.com/user-attachments/assets/14b88efc-b1bb-4f42-a016-e35643843363" />

<img width="1615" height="161" alt="Screenshot 2025-12-13 at 9 53 54 PM" src="https://github.com/user-attachments/assets/fdbf2aa0-ab73-4a98-a954-097d88132887" />
<br> <br>
<h4> Reverse Proxy Application </h4>
<img width="1231" height="811" alt="Screenshot 2025-12-13 at 9 57 30 PM" src="https://github.com/user-attachments/assets/2a7baa4d-d80d-4d6c-a6d2-bf7a608be002" />

<h4> Responses when clicked on Go to App1 and Go to App2 respectively </h4>

<img width="410" height="133" alt="Screenshot 2025-12-13 at 10 05 59 PM" src="https://github.com/user-attachments/assets/ca6553fe-9e11-453c-a8f0-23927aa2f25f" />  

<img width="412" height="144" alt="Screenshot 2025-12-13 at 10 07 22 PM" src="https://github.com/user-attachments/assets/08b321b6-cfdc-41e0-940f-80eda82f4a6d" />

--- 

## 🧪 Logs / Monitoring / Load Testing

<img width="1707" height="531" alt="Screenshot 2025-12-13 at 10 12 23 PM" src="https://github.com/user-attachments/assets/b4d729bc-6ec3-4041-9605-29de0f91474d" />

<h4> Load testing is performed by executing load_test.sh script which is responsible for sending 1000 requests to the reverse-proxy server </h4>

```bash
#!/bin/sh

echo "Hitting /app1 and /app2 in parallel..."

for i in $(seq 1 1000); do
  curl -s http://localhost:1111/app1 > /dev/null &
  curl -s http://localhost:1111/app2 > /dev/null &
done

wait
echo "Done...."
```

<h4> Commands to run the script </h4>

```bash
chmod +x load_test.sh
./load_test.sh
```

<h4> Observing CPU and Memory Behavior During Load Tests </h4>

<img width="1219" height="155" alt="Screenshot 2025-12-13 at 10 23 22 PM" src="https://github.com/user-attachments/assets/513ea8df-581c-46c5-a32d-a336c7eb1fb9" />

