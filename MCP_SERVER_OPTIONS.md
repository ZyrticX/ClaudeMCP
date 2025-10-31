# N8N MCP Server - תצורת שרת מרכזי (אופציונלי)

אם אתה רוצה להריץ שרת MCP מרכזי שהצוות מתחבר אליו (במקום שכל אחד יריץ מקומית),
השתמש בתצורה זו.

## Option 1: שרת MCP מקומי לכל חבר צוות (מומלץ)

כל חבר צוות מריץ את ה-MCP client על המחשב שלו ומתחבר לשרת n8n המשותף.
זה הפתרון המומלץ כי הוא פשוט יותר ואבטחה טובה יותר.

ראה: `TEAM_SETUP_GUIDE.md`

## Option 2: שרת MCP מרכזי

אם אתה רוצה שרת MCP אחד מרכזי שכולם מתחברים אליו:

### עדכון docker-compose.yml

הוסף שירות MCP server שמשתמש ב-`n8n-mcp`:

```yaml
  n8n-mcp-centralized:
    image: node:20-alpine
    container_name: n8n_mcp_centralized
    restart: unless-stopped
    ports:
      - "3001:3000"
    environment:
      - N8N_API_URL=http://n8n:5678
      - N8N_API_KEY=${N8N_API_KEY}
      - PROJECT_ID=${PROJECT_ID}
      - MCP_MODE=http
      - PORT=3000
    working_dir: /app
    command: >
      sh -c "npm install -g n8n-mcp && 
             n8n-mcp"
    depends_on:
      - n8n
    networks:
      - n8n_network
```

### חיבור מהצוות

בקובץ `claude_desktop_config.json`:

```json
{
  "mcpServers": {
    "n8n": {
      "url": "http://your-server-ip:3001"
    }
  }
}
```

**הערה:** גישה זו דורשת שהשרת יהיה נגיש מכל המחשבים של הצוות.
ייתכן שתצטרך להגדיר VPN או firewall rules.

## המלצה

**השתמש ב-Option 1** - זה פשוט יותר, בטוח יותר, וכל חבר צוות שולט על החיבור שלו.

Option 2 מועיל רק אם:
- יש לך VPN או רשת פרטית מאובטחת
- אתה רוצה ניהול מרכזי של החיבורים
- הצוות לא יכול להתקין תוכנות על המחשבים שלהם

