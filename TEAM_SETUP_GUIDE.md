# מדריך חיבור Claude Desktop לשרת N8N MCP

## שלב 1: קבלת פרטי החיבור

פנה למנהל המערכת כדי לקבל:
- כתובת השרת (URL או IP)
- מפתח API (API Key)
- מזהה פרויקט (Project ID) - אופציונלי

## שלב 2: הגדרת Claude Desktop

### Windows:

1. פתח את Explorer וגש לנתיב:
   ```
   C:\Users\<שם_המשתמש>\AppData\Roaming\Claude\
   ```

2. אם הקובץ `claude_desktop_config.json` לא קיים, צור אותו.

3. פתח את הקובץ בעורך טקסט (Notepad++ או VS Code) והוסף:

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
        "N8N_API_URL": "https://your-server-domain.com",
        "N8N_API_KEY": "your_api_key_here",
        "PROJECT_ID": "your_project_id_here"
      }
    }
  }
}
```

4. החלף את הערכים:
   - `your-server-domain.com` - בכתובת השרת שקיבלת
   - `your_api_key_here` - במפתח API שקיבלת
   - `your_project_id_here` - במזהה הפרויקט (אם יש)

5. שמור את הקובץ וסגור את Claude Desktop.

6. פתח מחדש את Claude Desktop.

### macOS:

1. פתח את Terminal והרץ:
   ```bash
   open ~/Library/Application\ Support/Claude/
   ```

2. צור או ערוך את הקובץ `claude_desktop_config.json`

3. הוסף את אותה תוכן כמו ב-Windows (ראה למעלה)

4. שמור וסגור את Claude Desktop

5. פתח מחדש את Claude Desktop

### Linux:

1. פתח את Terminal והרץ:
   ```bash
   nano ~/.config/Claude/claude_desktop_config.json
   ```

2. הוסף את אותה תוכן כמו ב-Windows (ראה למעלה)

3. שמור (Ctrl+O, Enter) וצא (Ctrl+X)

4. פתח מחדש את Claude Desktop

## שלב 3: בדיקת החיבור

לאחר פתיחה מחדש של Claude Desktop:

1. בדוק אם יש הודעת שגיאה בחלון Claude
2. נסה לשאול את Claude: "האם אתה יכול לגשת ל-n8n?"
3. אם הכל תקין, תוכל לבקש מ-Claude ליצור workflows, לנהל nodes, וכו'

## פתרון בעיות

### Claude לא מזהה את ה-MCP Server

- ודא שהקובץ `claude_desktop_config.json` נמצא במיקום הנכון
- ודא שהפורמט JSON תקין (יש פסיקים במקומות הנכונים)
- בדוק שהכתובת והמפתח נכונים

### שגיאת חיבור

- ודא שיש לך חיבור לאינטרנט
- ודא שהשרת זמין (פנה למנהל המערכת)
- בדוק שהמפתח API תקף

### Claude Desktop לא נפתח מחדש

- בדוק את הלוגים של Claude Desktop
- נסה למחוק את הקובץ ולהתחיל מחדש
- ודא שיש לך הרשאות כתיבה למיקום הקובץ

## עזרה נוספת

אם אתה נתקל בבעיות, פנה למנהל המערכת עם:
- מערכת הפעלה (Windows/macOS/Linux)
- הודעת השגיאה המדויקת
- צילום מסך של קובץ ההגדרות (ללא המפתח!)

