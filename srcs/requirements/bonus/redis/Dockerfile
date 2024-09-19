# Use Debian 11 as the base image
FROM debian:11

# Update package lists and upgrade installed packages
# Install required packages: lsb-release, curl, and gpg
# Add the Redis GPG key
# Add the Redis APT repository to the sources list
# Update package lists again to include the new Redis repository
# Install Redis
# Modify Redis configuration to allow connections from any IP address
# Set the maximum memory usage for Redis to 20MB
# Set teh memory eviction policy to allkeys-lru (Least Recently Used)
RUN apt update -y && apt upgrade -y && \
    apt install lsb-release curl gpg -y && \
    curl -fsSL https://packages.redis.io/gpg | gpg --dearmor -o /usr/share/keyrings/redis-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/redis-archive-keyring.gpg] https://packages.redis.io/deb $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/redis.list && \
    apt update -y && \
    apt install redis -y && \
    sed -i "s|bind 127.0.0.1|#bind 127.0.0.1|g" /etc/redis/redis.conf && \
    sed -i "s|# maxmemory <bytes>|maxmemory 20mb|g" /etc/redis/redis.conf && \
    echo "maxmemory-policy allkeys-lru" >> /etc/redis/redis.conf

# Start the Redis server with protected mode disabled to allow external conenctions
CMD [ "redis-server", "--protected-mode", "no" ]
