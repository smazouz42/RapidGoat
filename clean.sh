#!/bin/bash
echo "Stopping and removing Docker Compose services..."

docker-compose down --volumes --remove-orphans

echo "Cleanup complete!"
