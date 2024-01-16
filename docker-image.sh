#!/bin/bash

REPO_NAME="mobydock"
GIT_WORK_TREE="/var/git/${REPO_NAME}"

# Check out the newest version of the code
export GIT_WORK_TREE="${GIT_WORK_TREE}"
git checkout -f

# Get the latest Git commit tag
TAG="$(git log --pretty=format:'%h' -n 1)"

# Set full commit and latest tags
FULL_COMMIT_TAG="${REPO_NAME}:${TAG}"
FULL_LATEST_TAG="${REPO_NAME}:latest"

# Build Docker image
docker build -t "${FULL_LATEST_TAG}" "${GIT_WORK_TREE}"

# Get Docker ID of the last built image
DOCKER_ID="$(docker images -q ${REPO_NAME} | head -1)"

# Tag the latest version based on commit tag
# Note: The following line is commented out due to changes in Docker tag syntax
# docker tag -f "${DOCKER_ID}" "${FULL_LATEST_TAG}"

# Restart Docker container
echo "Restarting ${REPO_NAME}"
docker stop "${REPO_NAME}"

# Remove untagged Docker images
echo "Removing untagged Docker images (may take a while)"
docker rmi $(docker images --quiet --filter "dangling=true")
