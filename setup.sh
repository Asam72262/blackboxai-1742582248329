#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}Starting AutoCare project setup...${NC}"

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo -e "${RED}Git is not installed. Please install Git first.${NC}"
    exit 1
fi

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo -e "${RED}Node.js is not installed. Please install Node.js first.${NC}"
    exit 1
fi

# Check if npm is installed
if ! command -v npm &> /dev/null; then
    echo -e "${RED}npm is not installed. Please install npm first.${NC}"
    exit 1
fi

# Clone the repository
echo -e "${YELLOW}Cloning the repository...${NC}"
git clone https://github.com/yourusername/autocare.git
cd autocare

# Create necessary directories
echo -e "${YELLOW}Creating necessary directories...${NC}"
mkdir -p server/logs
mkdir -p server/uploads
mkdir -p client/build

# Install dependencies
echo -e "${YELLOW}Installing dependencies...${NC}"
npm install

echo -e "${YELLOW}Installing client dependencies...${NC}"
cd client
npm install

echo -e "${YELLOW}Installing server dependencies...${NC}"
cd ../server
npm install

# Set up environment variables
echo -e "${YELLOW}Setting up environment variables...${NC}"
cd ..
cp .env.example .env
cp server/.env.example server/.env

# Set up Git hooks
echo -e "${YELLOW}Setting up Git hooks...${NC}"
npx husky install

# Build the client
echo -e "${YELLOW}Building the client...${NC}"
cd client
npm run build

# Start the development environment
echo -e "${GREEN}Setup complete! Here's how to start the application:${NC}"
echo -e "${YELLOW}1. Start with Docker:${NC}"
echo "   docker-compose up"
echo -e "${YELLOW}2. Start without Docker:${NC}"
echo "   Terminal 1: cd server && npm run dev"
echo "   Terminal 2: cd client && npm start"

echo -e "${GREEN}For more information, please read the README.md file.${NC}"

# Check if Docker is installed
if command -v docker &> /dev/null; then
    echo -e "${YELLOW}Would you like to start the application with Docker now? (y/n)${NC}"
    read -r response
    if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]; then
        docker-compose up
    fi
else
    echo -e "${YELLOW}Docker is not installed. To use Docker, please install Docker and Docker Compose first.${NC}"
fi