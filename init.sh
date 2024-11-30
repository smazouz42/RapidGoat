#!/bin/bash

# Set variables
DOCKER_COMPOSE_FILE="docker-compose.yml"
SERVICE_NAME="graphql-engine"
INIT_SCRIPT_PATH="/srv/console-assets/versioned/init-graphql.sh" # Adjust the path if incorrect

# Start Docker Compose
echo "Starting Docker Compose..."
docker-compose -f $DOCKER_COMPOSE_FILE up -d

# Wait for the service to start
echo "Waiting for $SERVICE_NAME to start..."
CONTAINER_ID=$(docker-compose -f $DOCKER_COMPOSE_FILE ps -q $SERVICE_NAME)

if [ -z "$CONTAINER_ID" ]; then
    echo "Error: Could not find container for service $SERVICE_NAME."
    exit 1
fi

while [[ "$(docker inspect --format='{{.State.Health.Status}}' $CONTAINER_ID)" != "healthy" ]]; do
    echo "Still waiting for $SERVICE_NAME to become healthy..."
    sleep 2
done

echo "$SERVICE_NAME is healthy and running!"

# Execute the initialization script inside the container
echo "Executing initialization script..."
docker exec $CONTAINER_ID bash -c "cd /srv/console-assets/versioned && yes | ./init-graphql.sh"

if [ $? -eq 0 ]; then
    echo "Initialization script executed successfully!"
else
    echo "Error: Initialization script failed."
    exit 1
fi
