# Stage 1: Build backend
FROM node:20 AS builder

WORKDIR /app

# Copy only package files and install
COPY backend/node-server/package*.json ./
RUN npm install

# Copy backend source code
COPY backend/node-server ./

# Stage 2: Production image
FROM node:20-slim

WORKDIR /app

# Copy built backend from builder
COPY --from=builder /app ./

EXPOSE 3000
CMD ["node", "src/app.js"]
