# N8N MCP Server - Ubuntu 22.04 Deployment

שרת N8N MCP להרצה על Ubuntu 22.04, מאפשר לכל חברי הצוות להתחבר דרך Claude Desktop.

## דרישות מוקדמות

- Ubuntu 22.04 Server
- גישה root/sudo
- דומיין (אופציונלי, להגדרת SSL)

## מבנה הפרויקט

- `docker-compose.yml` - הגדרת כל השירותים (n8n, PostgreSQL)
- `install.sh` - סקריפט התקנה אוטומטי ל-Ubuntu 22.04
- `env.example` - תבנית למשתני סביבה
- `TEAM_SETUP_GUIDE.md` - מדריך מפורט לחברי הצוות (עברית)
- `QUICKSTART.md` - מדריך התחלה מהירה
- `MCP_SERVER_OPTIONS.md` - אפשרויות תצורת שרת MCP

## ארכיטקטורה

הפרויקט כולל:
1. **n8n Server** - שרת אוטומציה (port 5678)
2. **PostgreSQL** - מסד נתונים ל-n8n
3. **Nginx** - Reverse proxy (אופציונלי)
4. **MCP Client** - כל חבר צוות מריץ מקומית דרך Claude Desktop

**חשוב:** כל חבר צוות מריץ את ה-MCP client על המחשב שלו (דרך Claude Desktop).
הוא מתחבר לשרת n8n המרכזי דרך API.

ראה `MCP_SERVER_OPTIONS.md` אם אתה רוצה שרת MCP מרכזי.

## התקנה מהירה

```bash
# שכפל את הפרויקט
git clone <repository-url>
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

### 2. הגדרת משתני סביבה

העתק את קובץ הדוגמה והגדר את הערכים שלך:

```bash
cp env.example .env
nano .env
```

עדכן את הערכים הבאים:
- `N8N_USER` - שם משתמש ל-n8n
- `N8N_PASSWORD` - סיסמה ל-n8n
- `N8N_HOST` - כתובת הדומיין שלך (או IP)
- `N8N_PROTOCOL` - http או https
- `N8N_API_KEY` - מפתח API מ-n8n (מתקבל לאחר התחברות)
- `PROJECT_ID` - מזהה פרויקט (אופציונלי)

### 3. הפעלת השירותים

```bash
docker compose up -d
```

### 4. קבלת מפתח API מ-n8n

1. גש ל-`http://your-server-ip:5678`
2. התחבר עם המשתמש והסיסמה מהקובץ `.env`
3. לך ל-Settings → API
4. צור מפתח API חדש
5. עדכן את `N8N_API_KEY` בקובץ `.env`
6. שתף את המפתח עם חברי הצוות (ראה `TEAM_SETUP_GUIDE.md`)

## הגדרת SSL (מומלץ)

```bash
sudo apt-get install -y certbot python3-certbot-nginx nginx

# הגדר את Nginx (כבר מוגדר בסקריפט ההתקנה)
# או עדכן ידנית את /etc/nginx/sites-available/n8n

# קבל תעודת SSL
sudo certbot --nginx -d your-domain.com
```

## חיבור Claude Desktop (לחברי הצוות)

### Windows/macOS

ערוך את קובץ ההגדרות של Claude Desktop:

**Windows:**
```
C:\Users\<USERNAME>\AppData\Roaming\Claude\claude_desktop_config.json
```

**macOS:**
```
~/Library/Application Support/Claude/claude_desktop_config.json
```

הוסף את ההגדרות הבאות:

```json
{
  "mcpServers": {
    "n8n": {
      "command": "npx",
      "args": [
        "-y",
        "@ahmad.soliman/mcp-n8n-server"
      ],
      "env": {
        "N8N_API_URL": "https://your-domain.com",
        "N8N_API_KEY": "your_api_key_here",
        "PROJECT_ID": "your_project_id_here"
      }
    }
  }
}
```

**או** אם השרת MCP רץ באופן מרכזי:

```json
{
  "mcpServers": {
    "n8n": {
      "url": "http://your-server-ip:3000"
    }
  }
}
```

### Linux

```bash
# מיקום קובץ ההגדרות
~/.config/Claude/claude_desktop_config.json
```

## ניהול השירותים

### בדיקת סטטוס
```bash
cd /opt/n8n-mcp
docker compose ps
```

### צפייה בלוגים
```bash
docker compose logs -f n8n
docker compose logs -f postgres
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

## גיבוי

### גיבוי workflows
```bash
docker compose exec n8n tar czf /tmp/n8n-backup.tar.gz -C /home/node/.n8n workflows
docker cp n8n:/tmp/n8n-backup.tar.gz ./n8n-backup-$(date +%Y%m%d).tar.gz
```

### גיבוי מסד נתונים
```bash
docker compose exec postgres pg_dump -U n8n n8n > backup-$(date +%Y%m%d).sql
```

## פתרון בעיות

### שירותים לא מתחילים
```bash
docker compose logs
```

### בעיות הרשאות
```bash
sudo chown -R $USER:$USER /opt/n8n-mcp
```

### איפוס סיסמה
```bash
# עצור את הקונטיינרים
docker compose down

# מחק את נתוני n8n
docker volume rm n8n-mcp_n8n_data

# הפעל מחדש
docker compose up -d
```

## תמיכה

לבעיות או שאלות, צור issue בפרויקט או פנה למנהל המערכת.

## רישיון

MIT

