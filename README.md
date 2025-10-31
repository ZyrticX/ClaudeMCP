# N8N MCP Server - Ubuntu 22.04 Deployment

שרת N8N MCP להרצה על Ubuntu 22.04, מאפשר לכל חברי הצוות להתחבר דרך Claude Desktop לשרת n8n קיים.

**חשוב:** זהו שרת MCP בלבד - הוא דורש שרת n8n קיים להתחבר אליו.

## דרישות מוקדמות

- Ubuntu 22.04 Server
- גישה root/sudo
- שרת n8n קיים (מקומי או מרוחק)
- מפתח API מ-n8n

## מבנה הפרויקט

- `docker-compose.yml` - הגדרת שרת MCP
- `install.sh` - סקריפט התקנה אוטומטי ל-Ubuntu 22.04
- `env.example` - תבנית למשתני סביבה
- `TEAM_SETUP_GUIDE.md` - מדריך מפורט לחברי הצוות (עברית)
- `QUICKSTART.md` - מדריך התחלה מהירה

## ארכיטקטורה

הפרויקט כולל:
1. **n8n MCP Server** - שרת MCP שמתחבר ל-n8n קיים (port 3000)
2. **חברי הצוות** - מתחברים דרך Claude Desktop לשרת MCP

**חשוב:** 
- שרת ה-MCP מתחבר לשרת n8n שלך דרך API
- כל חבר צוות מתחבר לשרת MCP דרך Claude Desktop
- אתה צריך שרת n8n קיים עם מפתח API

## התקנה מהירה

```bash
# שכפל את הפרויקט
git clone https://github.com/ZyrticX/ClaudeMCP.git
cd ClaudeMCP

# הפעל את סקריפט ההתקנה
sudo chmod +x install.sh
sudo ./install.sh
```

## הגדרה ידנית

### 1. התקנת Docker ו-Docker Compose

```bash
sudo apt-get update
sudo apt-get install -y docker.io docker-compose-plugin
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker $USER
```

### 2. קבלת מפתח API מ-n8n

1. התחבר לשרת n8n שלך
2. לך ל-Settings → API
3. לחץ על "Create API Key"
4. העתק את המפתח (תזדקק לו בהמשך)

### 3. הגדרת משתני סביבה

העתק את קובץ הדוגמה והגדר את הערכים שלך:

```bash
cp env.example .env
nano .env
```

עדכן את הערכים הבאים:
- `N8N_API_URL` - כתובת שרת n8n שלך (לדוגמה: `https://n8n.yourdomain.com`)
- `N8N_API_KEY` - מפתח API שקיבלת מ-n8n
- `PROJECT_ID` - מזהה פרויקט (רק אם אתה משתמש ב-n8n Cloud/Enterprise)

### 4. הפעלת השירותים

```bash
docker compose up -d
```

### 5. בדיקת תקינות

```bash
# בדוק את סטטוס השירות
docker compose ps

# בדוק את הלוגים
docker compose logs -f n8n-mcp

# בדוק חיבור API
curl http://localhost:3000/health
```

## חיבור Claude Desktop (לחברי הצוות)

ראה את הקובץ `TEAM_SETUP_GUIDE.md` להנחיות מפורטות.

**בקצרה:**
ערוך את `claude_desktop_config.json` והוסף:

```json
{
  "mcpServers": {
    "n8n": {
      "url": "http://your-server-ip:3000"
    }
  }
}
```

## ניהול השירותים

### בדיקת סטטוס
```bash
cd /opt/n8n-mcp
docker compose ps
```

### צפייה בלוגים
```bash
docker compose logs -f n8n-mcp
```

### הפעלה מחדש
```bash
docker compose restart
```

### עצירה
```bash
docker compose down
```

### הפעלה
```bash
docker compose up -d
```

### עדכון
```bash
docker compose pull
docker compose up -d
```

## פתרון בעיות

### שירות לא מתחיל
```bash
docker compose logs
```

### בעיית חיבור ל-n8n
- ודא ש-`N8N_API_URL` נכון
- ודא ש-`N8N_API_KEY` תקף
- בדוק שהשרת n8n נגיש מהשרת הזה

### בעיות הרשאות
```bash
sudo chown -R $USER:$USER /opt/n8n-mcp
```

## תמיכה

לבעיות או שאלות:
- ראה את [n8n-mcp repository](https://github.com/czlonkowski/n8n-mcp)
- צור issue בפרויקט זה
- פנה למנהל המערכת

## רישיון

MIT
