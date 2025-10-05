# Use Node.js official LTS version
FROM node:18-alpine

# Set working directory inside container
WORKDIR /usr/src/server

# Copy package files to install dependencies
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy server source code
COPY . .

# Expose port your app runs on
EXPOSE 3000

# Start the app
CMD ["node", "src/server.js"]
