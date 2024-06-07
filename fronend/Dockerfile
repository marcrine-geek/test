# Use a more recent Node.js 14 image as a base image
FROM node:14

# Create and change to the app directory
WORKDIR /usr/src/app

# Copy the package.json and package-lock.json files
COPY package*.json ./

# Install the dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the React app for production
RUN npm run build

# Install serve package globally
RUN npm install -g serve

# Expose the port the app runs on
EXPOSE 5000

# Define the command to run the app
CMD ["serve", "-s", "build"]
