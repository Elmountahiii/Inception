FROM debian:bullseye-slim

WORKDIR /app

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

RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/louislam/uptime-kuma.git .

ENV TZ=Etc/UTC

RUN npm ci
RUN npm run build

EXPOSE 3001

VOLUME ["/app/data"]

CMD ["node", "server/server.js"]