# === Stage 1: Build the React App ===
FROM node AS builder

WORKDIR /app

# Copy source files and build
COPY . .
RUN npm install
RUN npm run build

# === Stage 2: Serve with Nginx ===
FROM nginx

# Remove default nginx index page
RUN rm -rf /usr/share/nginx/html/*

# Copy built React files from builder stage
COPY --from=builder /app/build/. /usr/share/nginx/html

# Copy custom nginx config if needed (optional)
# COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
