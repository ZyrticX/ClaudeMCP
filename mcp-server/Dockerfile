FROM node:20-alpine

WORKDIR /app

# Install MCP server dependencies
RUN npm install -g @ahmad.soliman/mcp-n8n-server

# Create a wrapper script
RUN echo '#!/bin/sh' > /app/start.sh && \
    echo 'exec mcp-n8n-server' >> /app/start.sh && \
    chmod +x /app/start.sh

EXPOSE 3000

CMD ["/app/start.sh"]

