# BUILD phase: install dependencies and build the application
FROM node:alpine as builder

EXPOSE 80

WORKDIR '/app'

COPY package.json .
RUN npm install

COPY . .

# Will produce artifacts in /app/build
RUN npm run build


# -----------------------------------------
# INSTALL phase: copy the result of the previous build into the
# nginx served folder and start nginx
FROM nginx

COPY --from=builder /app/build /usr/share/nginx/html

# Default CMD of nginx image is fine