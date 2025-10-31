# סיכום הפרויקט - N8N MCP Server

## מה נוצר?

פרויקט מוכן להרצה על Ubuntu 22.04 שמאפשר לכל הצוות להשתמש ב-n8n דרך Claude Desktop.

**חשוב:** זהו שרת MCP בלבד - הוא דורש שרת n8n קיים להתחבר אליו.

## קבצים עיקריים:

1. **docker-compose.yml** - הגדרת שרת n8n-mcp (מבוסס על [czlonkowski/n8n-mcp](https://github.com/czlonkowski/n8n-mcp))
2. **install.sh** - סקריפט התקנה אוטומטי מלא
3. **env.example** - תבנית להגדרות (N8N_API_URL, N8N_API_KEY)
4. **README.md** - מדריך מפורט בעברית
5. **QUICKSTART.md** - מדריך התחלה מהירה
6. **TEAM_SETUP_GUIDE.md** - מדריך לחברי הצוות

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

# 4. קבל מפתח API מ-n8n שלך
#    גש ל-n8n → Settings → API → Create API Key

# 5. ערוך את ההגדרות
sudo nano /opt/n8n-mcp/.env
# עדכן:
#   - N8N_API_URL=https://your-n8n-instance.com
#   - N8N_API_KEY=your_api_key_here

# 6. הפעל מחדש
cd /opt/n8n-mcp
sudo docker compose restart
```

### לחברי הצוות:

שלח להם את `TEAM_SETUP_GUIDE.md` עם:
- כתובת שרת ה-MCP (http://your-server-ip:3000)

## איך זה עובד?

1. **שרת n8n MCP** רץ על Ubuntu 22.04 (Docker)
2. **שרת ה-MCP** מתחבר לשרת n8n הקיים שלך דרך API
3. **כל חבר צוות** מתקין את Claude Desktop
4. **כל חבר צוות** מוסיף הגדרה ב-Claude Desktop שמתחברת לשרת MCP המרכזי
5. **Claude יכול** ליצור ולנהל workflows ב-n8n דרך MCP

## יתרונות:

✅ התקנה פשוטה ומהירה
✅ כל הצוות יכול להתחבר לשרת n8n המרכזי
✅ אין צורך במפתח API לכל משתמש (מנהל מרכזי)
✅ תיעוד מלא בעברית
✅ מבוסס על [n8n-mcp הרשמי](https://github.com/czlonkowski/n8n-mcp)

## הערות חשובות:

- ודא שיש לך שרת n8n קיים לפני ההתקנה
- המפתח API חייב להיות תקף
- השרת צריך להיות נגיש מהמחשבים של הצוות
- חברי הצוות לא צריכים מפתח API משלהם (השרת משתמש במפתח מרכזי)

## תמיכה:

ראה README.md לפרטים מלאים ופתרון בעיות.
למידע נוסף על n8n-mcp: https://github.com/czlonkowski/n8n-mcp
