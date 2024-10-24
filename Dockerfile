# Stage 1
# Define a node image and tag `build` as the first stage 
FROM node:23.0.0 AS build

# Set the work directory
WORKDIR /dist/src/app

# Clean npm cache
RUN npm cache clean --force

# Copy all the app content
COPY . .

# Install all the dependencies
RUN npm install

# Build the angular app
RUN npm run build:prod

# Stage 2
# Defining nginx image to be usedc
FROM nginx:1.21.6-alpine

# Let's copy our nginx configuration
COPY default.conf /etc/nginx/conf.d/default.conf
COPY --from=build /dist/src/app/dist/angular-dockerized/browser /usr/share/nginx/html

EXPOSE 80