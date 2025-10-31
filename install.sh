#!/bin/bash

set -e

echo "=========================================="
echo "N8N MCP Server Installation Script"
echo "For Ubuntu 22.04"
echo "=========================================="
echo ""

# Check if running as root
if [ "$EUID" -ne 0 ]; then 
    echo "Please run as root (use sudo)"
    exit 1
fi

# Update system
echo "📦 Updating system packages..."
apt-get update
apt-get upgrade -y

# Install required packages
echo "📦 Installing required packages..."
apt-get install -y \
    curl \
    git \
    docker.io \
    docker-compose-plugin \
    wget \
    ufw

# Start and enable Docker
echo "🐳 Starting Docker service..."
systemctl start docker
systemctl enable docker

# Add current user to docker group (if not root)
if [ "$SUDO_USER" ]; then
    usermod -aG docker $SUDO_USER
    echo "✅ Added $SUDO_USER to docker group"
fi

# Configure firewall
echo "🔥 Configuring firewall..."
ufw allow 22/tcp
ufw allow 3000/tcp
ufw --force enable

# Create project directory
PROJECT_DIR="/opt/n8n-mcp"
echo "📁 Creating project directory at $PROJECT_DIR..."
mkdir -p $PROJECT_DIR
cd $PROJECT_DIR

# Copy files (assuming script is run from project directory)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [ -f "$SCRIPT_DIR/docker-compose.yml" ]; then
    cp "$SCRIPT_DIR/docker-compose.yml" $PROJECT_DIR/
    cp "$SCRIPT_DIR/env.example" $PROJECT_DIR/.env.example
    echo "✅ Files copied to $PROJECT_DIR"
else
    echo "⚠️  Warning: docker-compose.yml not found"
    echo "Please copy all files to $PROJECT_DIR manually"
fi

# Setup environment file
if [ ! -f "$PROJECT_DIR/.env" ]; then
    cp $PROJECT_DIR/.env.example $PROJECT_DIR/.env
    echo "✅ Created .env file from template"
    echo ""
    echo "⚠️  IMPORTANT: Edit $PROJECT_DIR/.env with your configuration"
    echo "   You need to set:"
    echo "   - N8N_API_URL (your n8n instance URL)"
    echo "   - N8N_API_KEY (your n8n API key)"
    echo ""
fi

# Pull Docker image
echo "📥 Pulling n8n-mcp Docker image..."
docker compose pull

# Start services
echo "🚀 Starting MCP server..."
cd $PROJECT_DIR
docker compose up -d

# Wait for services to be ready
echo "⏳ Waiting for services to start..."
sleep 5

# Check service status
echo ""
echo "=========================================="
echo "Installation Complete!"
echo "=========================================="
echo ""
echo "Services status:"
docker compose ps
echo ""
echo "📝 Next steps:"
echo "1. Edit $PROJECT_DIR/.env with your n8n configuration:"
echo "   - N8N_API_URL: Your n8n instance URL"
echo "   - N8N_API_KEY: Your n8n API key"
echo ""
echo "2. Restart the service:"
echo "   cd $PROJECT_DIR"
echo "   docker compose restart"
echo ""
echo "3. Access MCP server at: http://$(hostname -I | awk '{print $1}'):3000"
echo ""
echo "4. Configure Claude Desktop (see TEAM_SETUP_GUIDE.md)"
echo ""
