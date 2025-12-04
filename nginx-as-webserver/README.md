# 🚀 NGINX as a Web Server

This project demonstrates how to use **NGINX as a simple static web server** running inside a Docker container.  
Your custom HTML/CSS files are packaged into the Docker image and served automatically through NGINX.

---

## 📁 Project Structure

nginx-as-webserver/

```bash
│── Dockerfile

│── docker-compose.yaml

│── site/

      ├── index.html
   
      └── styles.css

      └── nginx-card.png
```

---

## 📌 Features

- Lightweight **nginx:alpine** base image  
- Custom static website served from `/usr/share/nginx/html`
- Supports both **Docker build/run** and **docker-compose**
- Clean separation of code inside `site/` directory
- Auto-starts NGINX in foreground (`daemon off` mode)

---

## 📌 Architecture
<img width="846" height="282" alt="Screenshot 2025-12-04 at 8 49 01 PM" src="https://github.com/user-attachments/assets/5733ac6e-aa39-4eb2-a6ec-7744bf11cb93" />

---

## 🛠️ Dockerfile

```dockerfile
# Pull the lightweight alpine nginx image
FROM nginx:alpine

# copy the site directory to the nginx html directory
COPY ./site /usr/share/nginx/html/

# start nginx
CMD ["nginx", "-g", "daemon off;"]
```

## 🛠️ Docker Compose

```dockerfile
version: '3.8'

# define the services to be built
services:
  nginx-as-webserver:
    build:
      context: .
      dockerfile: Dockerfile
    ports:
      - "3002:80"
```

## 🏗️ Build the Docker Image
```bash
docker build -t nginx-as-ws .
```
<img width="1425" height="774" alt="Screenshot 2025-12-04 at 8 09 35 PM" src="https://github.com/user-attachments/assets/13bdd7f4-2b5a-4150-8a12-a15c495532ea" />

## ▶️ Run the Container
```bash
docker run -d -p 1111:80 nginx-as-ws:latest 
```
<img width="1670" height="209" alt="Screenshot 2025-12-04 at 8 11 33 PM" src="https://github.com/user-attachments/assets/4585328e-a4a0-4712-94c9-a94b430b66e3" />

<br><br>

Visit the site: ```http://localhost:1111/```

<img width="1531" height="829" alt="Screenshot 2025-12-04 at 8 15 48 PM" src="https://github.com/user-attachments/assets/a6bc6ed9-9d03-4fcb-824c-81750dee5c7a" />

---

## 📜 View Container Logs

```bash
docker logs -f 10c4775e162e
```

<img width="1703" height="973" alt="Screenshot 2025-12-04 at 8 25 07 PM" src="https://github.com/user-attachments/assets/36afbe2f-cb39-443c-88ad-2fbae35e53ef" />

- NGINX first launches the master process, which is responsible for Loading and validating the nginx.conf configuration
- Binding to ports (e.g., 80/443) and it decides how many workers need to run.
- Managing the lifecycle of worker processes
- Handling graceful reloads and restarts
- The master process does not handle client traffic. Its primary role is process orchestration and configuration management
- Master process creates worker processes
- They actually handle requests from users
- One worker can handle thousands of connections using event-based I/O
- The number of workers = value of worker_processes in nginx.conf (/etc/nginx/nginx.conf)

<img width="694" height="99" alt="Screenshot 2025-12-04 at 8 41 15 PM" src="https://github.com/user-attachments/assets/f82d6fab-6a3c-45f7-aa64-834aa7b7b496" />

✔ Meaning of worker_processes auto;
If your NGINX config has:
```bash
worker_processes auto;
```

- Then NGINX automatically detects how many CPU cores your machine has.
- If your host has 10 CPU cores → NGINX will start 10 worker processes
- If your host has 4 cores → NGINX will start 4 workers
- Why it works this way???.... Because each worker process is single-threaded and can fully utilize one CPU core.
So matching workers = CPU cores = maximum parallel performance.

---

## 📜 NOTE

- By default, NGINX writes all logs to stdout (console).
- If you want to save logs to specific files, you need to update the log paths in nginx.conf file.
- By default, worker_processes is set to auto, which means NGINX creates one worker process per CPU core.
- Run ```nginx -t``` to test if the nginx.conf syntax and configuration is correct.
