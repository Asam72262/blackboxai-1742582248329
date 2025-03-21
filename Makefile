# Development commands
.PHONY: install start dev test build clean docker-up docker-down docker-build lint format

# Install dependencies
install:
	npm install
	cd client && npm install
	cd server && npm install

# Start production
start:
	npm start

# Start development
dev:
	npm run dev

# Run tests
test:
	npm test

# Build application
build:
	cd client && npm run build

# Clean up
clean:
	rm -rf node_modules
	rm -rf client/node_modules
	rm -rf server/node_modules
	rm -rf client/build
	rm -rf server/dist
	rm -rf logs/*
	rm -rf uploads/*

# Docker commands
docker-up:
	docker-compose up -d

docker-down:
	docker-compose down

docker-build:
	docker-compose build

# Code quality
lint:
	npm run lint

format:
	npm run format

# Database commands
db-seed:
	cd server && npm run seed

db-migrate:
	cd server && npm run migrate

db-backup:
	cd server && npm run backup

# Deployment commands
deploy-prod:
	git checkout main
	git pull
	npm run build
	pm2 restart all

deploy-staging:
	git checkout staging
	git pull
	npm run build
	pm2 restart all

# Monitoring
logs:
	pm2 logs

monitor:
	pm2 monit

# Security
security-check:
	npm audit
	cd client && npm audit
	cd server && npm audit

# Documentation
docs:
	cd docs && mkdocs serve

# Help
help:
	@echo "Available commands:"
	@echo "  make install      - Install all dependencies"
	@echo "  make start       - Start production server"
	@echo "  make dev         - Start development server"
	@echo "  make test        - Run tests"
	@echo "  make build       - Build the application"
	@echo "  make clean       - Clean up build files"
	@echo "  make docker-up   - Start Docker containers"
	@echo "  make docker-down - Stop Docker containers"
	@echo "  make lint        - Run linter"
	@echo "  make format      - Format code"
	@echo "  make db-seed     - Seed database"
	@echo "  make db-migrate  - Run database migrations"
	@echo "  make db-backup   - Backup database"
	@echo "  make deploy-prod - Deploy to production"
	@echo "  make logs        - View logs"
	@echo "  make monitor     - Monitor application"

# Default
.DEFAULT_GOAL := help