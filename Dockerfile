# Stage 1: Build Node.js app
FROM node:18 AS node-app

WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm install pm2 -g

# Stage 2: Configure Nginx with Node.js app
FROM nginx:alpine

# Install Node.js and PM2 in the final stage
RUN apk add --no-cache nodejs npm
RUN npm install pm2 -g

# Copy app and configuration from the first stage
COPY --from=node-app /app /usr/src/app
COPY ./nginx.conf /etc/nginx/conf.d/default.conf

WORKDIR /usr/src/app
EXPOSE 80

# Use PM2 to run the app
ENV PORT=80
CMD ["pm2-runtime", "start", "server.js"]

