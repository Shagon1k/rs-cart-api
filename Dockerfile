# Base node image
FROM node:12-alpine AS base
WORKDIR /app

# Dependencies
FROM base AS dependencies
COPY package*.json ./
RUN npm install && npm cache clean --force

# Copy filed and build
FROM dependencies AS build
WORKDIR /app
COPY . .
RUN npm run build

WORKDIR /app

USER node
EXPOSE 8080

ENTRYPOINT ["npm", "run", "start"]