#!/bin/bash
# Vikunja Setup Script for Raspberry Pi 5
# Run this before docker-compose up

set -e

echo "🚀 Vikunja Setup Script"
echo "======================"
echo ""

# Check if docker is installed
if ! command -v docker &> /dev/null; then
    echo "❌ Docker is not installed. Please install Docker first."
    exit 1
fi

# Check if docker-compose is installed
if ! command -v docker-compose &> /dev/null; then
    echo "❌ Docker Compose is not installed. Please install Docker Compose first."
    exit 1
fi

echo "📁 Creating data directories..."

# Create db and files directories if they don't exist
mkdir -p db
mkdir -p files

echo "✅ Directories created"
echo ""

echo "🔧 Setting permissions..."

# Ensure proper permissions for database directory
chmod 700 db
chmod 755 files

echo "✅ Permissions set"
echo ""

echo "🔐 Security Reminder"
echo "Make sure you've updated the passwords in docker-compose.yml:"
echo "   - POSTGRES_PASSWORD"
echo "   - VIKUNJA_DATABASE_PASSWORD (must match POSTGRES_PASSWORD)"
echo "   - VIKUNJA_SERVICE_JWTSECRET"
echo ""

echo "🎉 Setup complete!"
echo ""
echo "Next steps:"
echo "1. Verify passwords are set in docker-compose.yml"
echo "2. Run: docker-compose up -d"
echo "3. Access Vikunja at http://$(hostname -I | awk '{print $1}'):8080"
echo "4. Create your first user account"
echo ""
echo "Useful commands:"
echo "  Check status:  docker-compose ps"
echo "  View logs:     docker-compose logs -f"
echo "  Stop services: docker-compose down"

