# ✅ Checklist התקנה - N8N MCP Server

## לפני התחלה

- [ ] יש לך שרת Ubuntu 22.04 עם גישה root/sudo
- [ ] יש לך דומיין (אופציונלי, אבל מומלץ ל-SSL)
- [ ] השרת נגיש מהאינטרנט (או VPN)

## התקנה

- [ ] העתקת את כל הקבצים לשרת
- [ ] הפעלת `sudo ./install.sh`
- [ ] סקריפט ההתקנה הושלם בהצלחה
- [ ] ערכת את `/opt/n8n-mcp/.env` עם ההגדרות שלך

## הגדרות בסיסיות

- [ ] שינית את `N8N_USER` מ-"admin"
- [ ] שינית את `N8N_PASSWORD` מ-"changeme"
- [ ] שינית את `POSTGRES_PASSWORD` מ-"changeme"
- [ ] עדכנת את `N8N_HOST` לכתובת השרת שלך
- [ ] הפעלת מחדש: `docker compose restart`

## קבלת API Key

- [ ] נכנסת ל-`http://your-server-ip:5678`
- [ ] התחברת עם המשתמש והסיסמה
- [ ] יצרת מפתח API חדש ב-Settings → API
- [ ] העתקת את המפתח

## הגדרת SSL (מומלץ)

- [ ] התקנת certbot: `sudo apt-get install certbot python3-certbot-nginx`
- [ ] קבלת תעודה: `sudo certbot --nginx -d your-domain.com`
- [ ] עדכנת את `.env`: `N8N_PROTOCOL=https`
- [ ] עדכנת את `.env`: `N8N_HOST=your-domain.com`
- [ ] הפעלת מחדש: `docker compose restart`

## בדיקת תקינות

- [ ] שירותים רצים: `docker compose ps` (כל השירותים "Up")
- [ ] n8n נגיש: `curl http://localhost:5678/healthz`
- [ ] מסד נתונים עובד: `docker compose logs postgres` (ללא שגיאות)
- [ ] Nginx עובד: `sudo systemctl status nginx`

## הפצה לחברי הצוות

- [ ] יצרת מפתחות API לכל חבר צוות (או מפתח משותף)
- [ ] שלחת את `TEAM_SETUP_GUIDE.md` לחברי הצוות
- [ ] סיפקת:
  - [ ] כתובת השרת (URL)
  - [ ] מפתח API
  - [ ] Project ID (אם רלוונטי)

## אבטחה

- [ ] שינית את כל הסיסמאות ברירת המחדל
- [ ] הגדרת firewall (ufw)
- [ ] הגדרת SSL (HTTPS)
- [ ] בדקת שהפורטים הנכונים פתוחים (80, 443, 5678)
- [ ] יצרת גיבוי ראשוני

## גיבויים

- [ ] יצרת גיבוי workflows: `docker compose exec n8n tar czf /tmp/backup.tar.gz -C /home/node/.n8n workflows`
- [ ] יצרת גיבוי מסד נתונים: `docker compose exec postgres pg_dump -U n8n n8n > backup.sql`
- [ ] הגדרת גיבוי אוטומטי (cronjob) - אופציונלי

## בדיקת חיבור מצוות

- [ ] חבר צוות 1 התחבר בהצלחה
- [ ] חבר צוות 2 התחבר בהצלחה
- [ ] כל חברי הצוות יכולים לגשת ל-n8n דרך Claude

## ניטור ותחזוקה

- [ ] הגדרת ניטור (אופציונלי)
- [ ] תיעדת את פרטי ההתקנה
- [ ] יצרת תיעוד לגיבויים ושחזור

## סיום

כל הסעיפים מסומנים? ✅

**הפרויקט מוכן לשימוש!**

לשאלות או בעיות, ראה README.md או QUICKSTART.md

