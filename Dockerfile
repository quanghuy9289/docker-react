# Setup builder image that build react web to production
# The output of builder is build folder of production web
FROM node:alpine AS builder

WORKDIR "/app"

COPY package.json .

RUN npm install

COPY . .

CMD ["npm", "run", "build"]

# Set up nginx web server image for run web page
# This image copy the build folder in the builder image to nginx web server
# Just copy build folder and don't need any thing else
FROM nginx

COPY --from=builder /app/build /usr/share/nginx/html
