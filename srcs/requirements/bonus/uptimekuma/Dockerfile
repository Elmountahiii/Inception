# Base image
FROM debian:bullseye-slim

# Set working directory
WORKDIR /app

# Install dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    gnupg \
    ca-certificates \
    python3 \
    make \
    g++ \
    tzdata \
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*

# Clone the repository
RUN git clone https://github.com/louislam/uptime-kuma.git .

# Set timezone (optional, customize as needed)
ENV TZ=Etc/UTC

# Install dependencies and build the app
RUN npm ci
RUN npm run build

# Expose the default port
EXPOSE 3001

# Set volume for data persistence
VOLUME ["/app/data"]

# Start the application
CMD ["node", "server/server.js"]