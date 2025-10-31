# סיכום הפרויקט - N8N MCP Server

## מה נוצר?

פרויקט מוכן להרצה על Ubuntu 22.04 שמאפשר לכל הצוות להשתמש ב-N8N דרך Claude Desktop.

## קבצים עיקריים:

1. **docker-compose.yml** - הגדרת שרת n8n + PostgreSQL
2. **install.sh** - סקריפט התקנה אוטומטי מלא
3. **env.example** - תבנית להגדרות
4. **README.md** - מדריך מפורט בעברית
5. **QUICKSTART.md** - מדריך התחלה מהירה
6. **TEAM_SETUP_GUIDE.md** - מדריך לחברי הצוות
7. **MCP_SERVER_OPTIONS.md** - אפשרויות תצורה מתקדמות

## שלבי התקנה:

### על השרת (Ubuntu 22.04):

```bash
# 1. העתק את הקבצים לשרת
scp -r ClaudeMCP user@server:/opt/

# 2. התחבר לשרת
ssh user@server

# 3. הפעל את סקריפט ההתקנה
cd /opt/ClaudeMCP
sudo chmod +x install.sh
sudo ./install.sh

# 4. ערוך את ההגדרות
sudo nano /opt/n8n-mcp/.env
# עדכן: N8N_USER, N8N_PASSWORD, N8N_HOST

# 5. הפעל מחדש
cd /opt/n8n-mcp
sudo docker compose restart

# 6. גש ל-n8n וקבל API Key
# http://your-server-ip:5678
# Settings → API → Create API Key
```

### לחברי הצוות:

שלח להם את `TEAM_SETUP_GUIDE.md` עם:
- כתובת השרת
- מפתח API
- Project ID (אם רלוונטי)

## איך זה עובד?

1. **שרת n8n** רץ על Ubuntu 22.04 (Docker)
2. **כל חבר צוות** מתקין את Claude Desktop
3. **כל חבר צוות** מוסיף הגדרה ב-Claude Desktop שמתחברת לשרת n8n
4. **Claude יכול** ליצור ולנהל workflows ב-n8n דרך MCP

## יתרונות:

✅ התקנה פשוטה ומהירה
✅ כל הצוות יכול להתחבר
✅ אבטחה טובה (כל אחד עם מפתח API שלו)
✅ תיעוד מלא בעברית
✅ תמיכה ב-SSL
✅ גיבויים אוטומטיים

## הערות חשובות:

- ודא שהשרת נגיש מהאינטרנט (או VPN)
- שנה את הסיסמאות ב-.env לפני ההפעלה
- הגדר SSL אם יש לך דומיין
- כל חבר צוות צריך מפתח API נפרד (אופציונלי)

## תמיכה:

ראה README.md לפרטים מלאים ופתרון בעיות.

