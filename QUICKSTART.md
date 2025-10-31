# N8N MCP Server - Quick Start Guide

## התקנה מהירה על Ubuntu 22.04

```bash
# 1. שכפל את הפרויקט לשרת
git clone <repository-url>
cd ClaudeMCP

# 2. הפעל את סקריפט ההתקנה
sudo chmod +x install.sh
sudo ./install.sh

# 3. ערוך את קובץ ההגדרות
sudo nano /opt/n8n-mcp/.env

# 4. עדכן את הערכים הבאים:
#    - N8N_USER והסיסמה
#    - N8N_HOST (כתובת הדומיין או IP)
#    - סיסמת מסד הנתונים

# 5. הפעל מחדש את השירותים
cd /opt/n8n-mcp
sudo docker compose down
sudo docker compose up -d

# 6. גש ל-n8n וקבל API Key
#    http://your-server-ip:5678
#    Settings → API → Create API Key

# 7. עדכן את N8N_API_KEY ב-.env
sudo nano /opt/n8n-mcp/.env

# 8. הפעל מחדש
sudo docker compose restart n8n-mcp
```

## הגדרת SSL (מומלץ)

```bash
# התקן certbot
sudo apt-get install -y certbot python3-certbot-nginx

# קבל תעודת SSL
sudo certbot --nginx -d your-domain.com

# עדכן את .env:
# N8N_PROTOCOL=https
# N8N_HOST=your-domain.com
# WEBHOOK_URL=https://your-domain.com

# הפעל מחדש
cd /opt/n8n-mcp
sudo docker compose restart
```

## הפצה לחברי הצוות

שלח לחברי הצוות את הקובץ `TEAM_SETUP_GUIDE.md` עם:
- כתובת השרת
- מפתח API שלהם (או מפתח משותף)
- Project ID (אם רלוונטי)

## בדיקת תקינות

```bash
# בדוק את סטטוס השירותים
cd /opt/n8n-mcp
sudo docker compose ps

# בדוק את הלוגים
sudo docker compose logs n8n
sudo docker compose logs n8n-mcp

# בדוק חיבור API
curl http://localhost:5678/healthz
```

## תמיכה

לשאלות ובעיות, ראה את ה-README.md המלא.

