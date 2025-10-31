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
    ufw \
    certbot \
    python3-certbot-nginx \
    nginx

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
ufw allow 80/tcp
ufw allow 443/tcp
ufw allow 5678/tcp
# Port 3000 only needed if using centralized MCP server
# ufw allow 3000/tcp
ufw --force enable

# Create project directory
PROJECT_DIR="/opt/n8n-mcp"
echo "📁 Creating project directory at $PROJECT_DIR..."
mkdir -p $PROJECT_DIR
cd $PROJECT_DIR

# Copy files (assuming script is run from project directory)
if [ -f "docker-compose.yml" ]; then
    cp docker-compose.yml $PROJECT_DIR/
    cp -r mcp-server $PROJECT_DIR/
    cp env.example $PROJECT_DIR/.env.example
    echo "✅ Files copied to $PROJECT_DIR"
else
    echo "⚠️  Warning: docker-compose.yml not found in current directory"
    echo "Please copy all files to $PROJECT_DIR manually"
fi

# Setup environment file
if [ ! -f "$PROJECT_DIR/.env" ]; then
    cp $PROJECT_DIR/.env.example $PROJECT_DIR/.env
    echo "✅ Created .env file from template"
    echo "⚠️  IMPORTANT: Edit $PROJECT_DIR/.env with your configuration"
fi

# Create nginx configuration
echo "🌐 Creating Nginx configuration..."
cat > /etc/nginx/sites-available/n8n <<EOF
server {
    listen 80;
    server_name _;

    location / {
        proxy_pass http://localhost:5678;
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
        proxy_cache_bypass \$http_upgrade;
    }
}
EOF

ln -sf /etc/nginx/sites-available/n8n /etc/nginx/sites-enabled/
rm -f /etc/nginx/sites-enabled/default

# Test nginx configuration
nginx -t

# Start services
echo "🚀 Starting services..."
cd $PROJECT_DIR
docker compose up -d

# Wait for services to be ready
echo "⏳ Waiting for services to start..."
sleep 10

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
echo "1. Edit $PROJECT_DIR/.env with your configuration"
echo "2. Run: docker compose down && docker compose up -d"
echo "3. Access n8n at: http://$(hostname -I | awk '{print $1}'):5678"
echo "4. Get your API key from n8n settings"
echo "5. Update N8N_API_KEY in .env file"
echo ""
echo "For SSL certificate (Let's Encrypt):"
echo "certbot --nginx -d your-domain.com"
echo ""

