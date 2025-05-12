# === Stage 1: Build the React App ===
FROM node AS builder

WORKDIR /app

# Copy only required files
COPY package*.json ./
RUN npm install

COPY public ./public
COPY src ./src

RUN npm run build

# === Stage 2: Serve with Nginx ===
FROM nginx

# Remove default nginx index page
RUN rm -rf /usr/share/nginx/html/*

# Copy built React files from builder stage
COPY --from=builder /app/build /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
