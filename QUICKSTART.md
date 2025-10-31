# N8N MCP Server - Quick Start Guide

## התקנה מהירה על Ubuntu 22.04

```bash
# 1. שכפל את הפרויקט לשרת
git clone https://github.com/ZyrticX/ClaudeMCP.git
cd ClaudeMCP

# 2. הפעל את סקריפט ההתקנה
sudo chmod +x install.sh
sudo ./install.sh

# 3. קבל מפתח API מ-n8n שלך
#    גש ל-n8n → Settings → API → Create API Key

# 4. ערוך את קובץ ההגדרות
sudo nano /opt/n8n-mcp/.env

# 5. עדכן את הערכים הבאים:
#    - N8N_API_URL=https://your-n8n-instance.com
#    - N8N_API_KEY=your_api_key_here

# 6. הפעל מחדש את השירות
cd /opt/n8n-mcp
sudo docker compose restart
```

## הפצה לחברי הצוות

שלח לחברי הצוות את הקובץ `TEAM_SETUP_GUIDE.md` עם:
- כתובת שרת ה-MCP (http://your-server-ip:3000)
- הסבר כיצד להגדיר את Claude Desktop

## בדיקת תקינות

```bash
# בדוק את סטטוס השירות
cd /opt/n8n-mcp
sudo docker compose ps

# בדוק את הלוגים
sudo docker compose logs n8n-mcp

# בדוק חיבור API
curl http://localhost:3000/health
```

## הערות חשובות

- ודא שיש לך שרת n8n קיים לפני ההתקנה
- המפתח API חייב להיות תקף
- השרת צריך להיות נגיש מהמחשבים של הצוות

## תמיכה

לשאלות ובעיות, ראה את ה-README.md המלא.
