# 🚀 Setting Up Node.js with PM2 and Nginx in Docker

This guide provides step-by-step instructions to configure a **Node.js application** with **PM2** as the process manager and **Nginx** as a reverse proxy, all running inside a Docker container.

---

## 📌 Prerequisites
- **Docker** installed on your system.
- Basic understanding of **Node.js, PM2, and Nginx**.
- A **GitHub repository** to store your project (optional).

---

## 📝 Project Structure
```
/project-root
│── Dockerfile
│── nginx.conf
│── package.json
│── server.js
│── docker-entrypoint.sh (optional)
│── .dockerignore
```

---

## 📌 Step 1: Create a `Dockerfile`
This `Dockerfile` sets up the Node.js application with PM2 and configures Nginx.
```dockerfile
# Use Node.js as the base image
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Copy package.json and install dependencies
COPY package.json .
RUN npm install -g pm2 && npm install

# Copy the application files
COPY . .

# Expose application port
EXPOSE 3000

# Start application using PM2
CMD ["pm2-runtime", "start", "server.js"]
```

---

## 📌 Step 2: Create `server.js` (Node.js App)
```javascript
const express = require('express');
const app = express();
const PORT = process.env.PORT || 3000;

app.get('/', (req, res) => {
    res.send('Hello from Node.js with PM2 and Nginx!');
});

app.listen(PORT, () => {
    console.log(`Server listening on port ${PORT}`);
});
```

---

## 📌 Step 3: Configure `nginx.conf`
This file sets up Nginx as a reverse proxy to forward requests to Node.js.
```nginx
server {
    listen 80;

    location / {
        proxy_pass http://localhost:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }
}
```

---

## 📌 Step 4: Build and Run the Docker Container
### **1️⃣ Build the Docker Image**
```sh
docker build -t nodepm2-nginx .
```

### **2️⃣ Run the Docker Container**
```sh
docker run -p 4000:80 nodepm2-nginx
```
✅ Now, your application should be accessible at **http://localhost:4000**.

---

## 🎉 Conclusion
You have successfully set up **Node.js with PM2 and Nginx in Docker**! This configuration ensures that:
- The **Node.js app** runs using **PM2** for process management.
- **Nginx** acts as a reverse proxy to handle incoming requests.
- Everything runs inside a **Docker container**, making deployment easier.

🚀 Happy coding! Let me know if you have any questions. 😃

