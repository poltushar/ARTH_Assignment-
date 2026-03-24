... DevOps Assignment Submission

1. Steps Followed

 1. Created EC2 Ubuntu instance
 2. Installed required packages (git, curl, nginx, docker)
 3. Created Docker containers for:
   . Backend (Node.js)
   . Frontend
   . MongoDB
 4. Configured Docker network for communication
 5. Ran application containers
 6. Configured Nginx reverse proxy
 7. Tested application in browser
 8. Performed troubleshooting and fixed issues

2. Commands Used

  . User & Package Setup

``
sudo adduser devopsuser
sudo usermod -aG sudo devopsuser

sudo apt update
sudo apt install git
sudo apt install curl
sudo apt install 
sudo apt install htop 
suod apt install nginx
suod apt install  docker.io

``

  . Docker Setup

``
docker network create my-network
docker build -t  chatappbackend:latest .
docker build -t chatapp:latest .
docker pull mongo:latest
docker run -d   --name mongo   --network my-network   -e MONGO_INITDB_ROOT_USERNAME=root   -e MONGO_INITDB_ROOT_PASSWORD=admin   mongo
docker run -d   --name backend   --network my-network   -p 5001:5001 -e NODE_ENV="production" -e JWT_SECRET="your_jwt_secret_key"  -e MONGODB_URI="mongodb://root:admin@mongo:27017/chatApp?authSource=admin" -e PORT=5001    chatappbackend:latest
``

 . Nginx Commands

``
sudo nano /etc/nginx/sites-available/default
sudo systemctl reload nginx

``
 
 . Debug Commands

``
docker ps
docker ps -a
docker logs <container_id>
systemctl status nginx

``

3. Screenshots

EC2 instance running
Docker containers (docker ps)
Nginx status
Browser output (Frontend working)
API response (/api)


4. Configuration Files

 . Nginx Config

``
 server {
    listen 80;

    # Frontend
    location / {
        proxy_pass http://localhost:8080;
    }

    # Backend API
    location /api {
        proxy_pass http://localhost:5001;
    }
}
``

  .Dockerfile (Frontend)

``
# Build stage
FROM node:18-alpine as build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Production stage
FROM nginx:alpine

# Create necessary directories and set permissions
RUN mkdir -p /var/cache/nginx /var/run /var/log/nginx && \
    chown -R nginx:nginx /var/cache/nginx /var/run /var/log/nginx

# Copy built files and configuration
COPY --from=build /app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Set proper ownership for web files
RUN chown -R nginx:nginx /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
``

 .Shell Script

#!/bin/bash

echo "Disk Usage Command"
df -h

echo "Memory Usage Command"
free -h

echo "Nginx Status Command"
systemctl status nginx

echo "Port Check 5001"
lsof -i :5001

5.Troubleshooting


Nginx not starting due to: host not found in upstream "backend"

Diagnosis:
Checked using systemctl status nginx

Fix:
Replaced backend with localhost

Verification:
Nginx started successfully
Application accessible in browser

6. Answers to Questions


1. Difference between Docker image and container 

 Ans: Docker image is like a blueprint or template. It contains the application code and all dependencies.
And container is the running version of that image.

For example, if I have a Node.js image, when I run it, it becomes a container where my app is actually running.

2. Difference between systemctl start and systemctl enable

Ans: systemctl start is used to start a service immediately.
And systemctl enable is used to make sure the service starts automatically when the system boots.

3. What is nginx reverse proxy used for?

Ans: Nginx reverse proxy is used to forward user requests to backend servers.
It helps in managing traffic, improving security, and sometimes load balancing.

For example, user hits Nginx, and Nginx sends the request to backend API.

4. How do you check which process is using a port in Linux?

Ans: We can use the lsof command to check which process is using a port.

For example, lsof -i :5001 will show the process running on port 5001.

5. What is AWS EC2 used for?

Ans: AWS EC2 is a virtual server in the cloud.
We use it to host applications, run backend services, and deploy projects.

6. What is Jenkins used for?

Ans: Jenkins is a CI/CD tool.
It is used to automate build, testing, and deployment of applications.

7. What is CodePipeline?

Ans: AWS CodePipeline is also a CI/CD service.
It helps to automate the complete pipeline like build, test, and deploy in AWS environment

