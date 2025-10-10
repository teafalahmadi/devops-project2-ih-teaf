FROM node:20-alpine AS build
WORKDIR /app

# Copy package files first
COPY package*.json ./
RUN npm install

# Copy the rest of the app, including the .env file
COPY . .

# Ensure the build uses VITE_API_BASE_URL=/api
ARG VITE_API_BASE_URL=
ENV VITE_API_BASE_URL=$VITE_API_BASE_URL
RUN npm run build

# Production stage
FROM nginx:alpine
COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
