#!/bin/bash

# Set variables
DOCKER_COMPOSE_FILE="docker-compose.yml"

# Start Docker Compose
echo "Starting Docker Compose..."
docker-compose -f $DOCKER_COMPOSE_FILE up -d

