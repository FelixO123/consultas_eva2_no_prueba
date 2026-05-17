# Stage 1: Build
FROM node:18-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Stage 2: Production (Nginx)
FROM nginx:alpine
# Limpieza de archivos por defecto de nginx
RUN rm -rf /usr/share/nginx/html/*
# Copiar archivos construidos
COPY --from=build /app/dist /usr/share/nginx/html
# Configurar usuario no root (opcional en nginx, pero recomendado)
RUN touch /var/run/nginx.pid && \
    chown -R nginx:nginx /var/run/nginx.pid /var/cache/nginx /var/log/nginx /usr/share/nginx/html
USER nginx

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
