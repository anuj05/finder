# Step1: Build the React APP
FROM node:22.19.0-alpine3.21 as build
WORKDIR /app
COPY package.json ./
RUN npm install
COPY . .
RUN npm run build

# Step2: Serve the React app with Nginx
FROM nginx:1.25.2-alpine
WORKDIR /usr/share/nginx/html
RUN rm -rf *
COPY --from=build /app/build .
EXPOSE 80
ENTRYPOINT [ "nginx", "-g", "daemon off;" ]
