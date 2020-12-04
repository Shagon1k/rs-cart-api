# Base setup
FROM node:12-alpine AS base
WORKDIR /app

# Dependencies
COPY package*.json ./
RUN npm install

# Build
WORKDIR /app
COPY . .
RUN npm run build

# Start app
FROM node:12-alpine AS application

COPY --from=base /app/package*.json ./
RUN npm install --only=production && npm cache clean --force
COPY --from=base /app/dist ./dist

USER node
EXPOSE 8080

ENTRYPOINT ["npm", "run", "start"]