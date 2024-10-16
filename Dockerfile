# # ------------------ build -------------------
FROM node:20.15.1-alpine AS build
RUN npm install -g pnpm@8.12.1

WORKDIR /app

COPY . .
RUN pnpm install

RUN pnpm web:build


# # # ------------------ deploy -------------------
FROM nginx:alpine AS prod

# Copy your custom Nginx configuration file
COPY ./.nginx/nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 80 for incoming HTTP traffic
EXPOSE 80

COPY --from=build /app/dist ./usr/share/nginx/html