# 📋 MORPHERGYX MANUAL CONFIGURATION CHECKLIST

This document lists everything you need to edit manually before deploying the application.

## ⚠️ CRITICAL: MUST EDIT BEFORE RUNNING

### 1. Email Configuration (`backend/.env`)

**Location:** `backend/.env`

**What to edit:**
```env
EMAIL_HOST=smtp.gmail.com              # Your email provider's SMTP host
EMAIL_PORT=587                         # SMTP port (587 for TLS, 465 for SSL)
EMAIL_USER=your-email@gmail.com        # ✏️ CHANGE THIS - Your email address
EMAIL_PASSWORD=your-app-password       # ✏️ CHANGE THIS - Your app-specific password
EMAIL_FROM=noreply@morphergyx.com      # Email address shown in "From" field
EMAIL_FROM_NAME=Morphergyx LLP         # Company name in emails
```

**How to get Gmail App Password:**
1. Go to https://myaccount.google.com/security
2. Enable 2-Step Verification
3. Go to "App passwords"
4. Generate new app password for "Mail"
5. Copy the 16-character password and paste it in `EMAIL_PASSWORD`

**Alternative Email Providers:**
- **SendGrid**: `EMAIL_HOST=smtp.sendgrid.net`, port 587
- **Mailgun**: `EMAIL_HOST=smtp.mailgun.org`, port 587
- **AWS SES**: `EMAIL_HOST=email-smtp.us-east-1.amazonaws.com`, port 587

---

### 2. Admin Credentials (`backend/.env`)

**Location:** `backend/.env`

**What to edit:**
```env
ADMIN_EMAIL=admin@morphergyx.com                    # ✏️ CHANGE THIS
ADMIN_PASSWORD=Change_This_Secure_Password_123!     # ✏️ CHANGE THIS - Min 8 chars, use strong password
```

**Important:**
- Use a STRONG password (min 8 characters, mix of letters, numbers, symbols)
- This is used to login to admin panel
- Don't share this password publicly

---

### 3. JWT Secret Key (`backend/.env`)

**Location:** `backend/.env`

**What to edit:**
```env
JWT_SECRET=your-super-secret-jwt-key-change-this-in-production-min-32-chars
# ✏️ CHANGE THIS - Must be 32+ characters
```

**How to generate a secure JWT secret:**

Option 1 - Using Node.js:
```bash
node -e "console.log(require('crypto').randomBytes(32).toString('hex'))"
```

Option 2 - Using OpenSSL:
```bash
openssl rand -base64 32
```

Option 3 - Online generator:
Visit: https://randomkeygen.com/ (Use CodeIgniter Encryption Keys)

**Copy the generated value and paste it as `JWT_SECRET`**

---

### 4. MongoDB Configuration (`backend/.env`)

**Location:** `backend/.env`

**For Development (Local MongoDB):**
```env
MONGODB_URI=mongodb://localhost:27017/morphergyx
```

**For Production (MongoDB Atlas):**
```env
MONGODB_URI=mongodb+srv://<username>:<password>@cluster0.xxxxx.mongodb.net/morphergyx?retryWrites=true&w=majority
# ✏️ CHANGE THIS
```

**How to get MongoDB Atlas URI:**
1. Sign up at https://www.mongodb.com/cloud/atlas
2. Create a new cluster (free tier available)
3. Create a database user (username & password)
4. Whitelist your IP address (or use 0.0.0.0/0 for development)
5. Click "Connect" > "Connect your application"
6. Copy the connection string
7. Replace `<username>` and `<password>` with your actual credentials
8. Replace `<cluster>` with your cluster name

---

### 5. CORS Configuration (`backend/.env`)

**Location:** `backend/.env`

**What to edit:**
```env
CORS_ORIGINS=http://localhost:3000,https://morphergyx.com,https://www.morphergyx.com
# ✏️ ADD YOUR PRODUCTION DOMAIN(S)
```

**Important:**
- Add ALL domains where your frontend will be hosted
- Separate multiple domains with commas (no spaces)
- Include both `http://` and `https://` versions if needed
- Include both `www` and non-`www` versions

---

### 6. Frontend API Configuration

**Location:** `frontend/scripts/main.js`

**What to edit (Line 2-4):**
```javascript
const API_BASE_URL = window.location.hostname === 'localhost' 
    ? 'http://localhost:5000/api/v1' 
    : 'https://api.morphergyx.com/api/v1';  // ✏️ CHANGE THIS to your production API URL
```

**Examples:**
- Heroku: `https://morphergyx-api.herokuapp.com/api/v1`
- Railway: `https://morphergyx-production.up.railway.app/api/v1`
- Custom domain: `https://api.morphergyx.com/api/v1`

---

### 7. Notification Settings (`backend/.env`)

**Location:** `backend/.env`

**What to edit:**
```env
SEND_EMAIL_NOTIFICATIONS=true     # Send confirmation emails to customers
SEND_ADMIN_NOTIFICATIONS=true     # Send notifications to admin email
```

Set to `false` if you don't want to send emails (useful for testing)

---

## 📝 OPTIONAL CONFIGURATIONS

### Rate Limiting

**Location:** `backend/.env`

```env
RATE_LIMIT_WINDOW_MS=900000        # 15 minutes in milliseconds
RATE_LIMIT_MAX_REQUESTS=100        # Max requests per window
```

Adjust based on your traffic expectations.

---

### Environment Mode

**Location:** `backend/.env`

```env
NODE_ENV=development    # Change to 'production' when deploying
```

**Important:** Set to `production` before deploying to live server

---

## ✅ VERIFICATION CHECKLIST

Before running the application, verify:

- [ ] Email credentials configured (tested)
- [ ] Admin email and password set
- [ ] JWT secret generated (32+ characters)
- [ ] MongoDB URI configured
- [ ] CORS origins include your domain(s)
- [ ] Frontend API URL points to your backend
- [ ] NODE_ENV set correctly (development/production)
- [ ] All passwords are STRONG and UNIQUE
- [ ] `.env` file is in `.gitignore` (don't commit secrets!)

---

## 🚀 QUICK START AFTER CONFIGURATION

1. **Install dependencies:**
   ```bash
   cd backend
   npm install
   ```

2. **Start the server:**
   ```bash
   npm run dev        # Development mode with auto-reload
   # OR
   npm start          # Production mode
   ```

3. **Test the server:**
   - Health check: http://localhost:5000/health
   - Should see: `{"success": true, "message": "Server is running"}`

4. **Open frontend:**
   - Open `frontend/index.html` in browser
   - Or serve with: `npx http-server frontend -p 3000`

5. **Test inquiry submission:**
   - Fill out the inquiry form
   - Check if confirmation email arrives
   - Check if admin notification arrives

---

## 🆘 TROUBLESHOOTING

### Email not sending?
- Check EMAIL_USER and EMAIL_PASSWORD are correct
- For Gmail, ensure you're using App Password, not regular password
- Check if 2FA is enabled on your email account
- Verify EMAIL_HOST and EMAIL_PORT are correct

### Can't connect to MongoDB?
- If using local MongoDB, ensure it's running: `sudo systemctl status mongod`
- If using MongoDB Atlas, check:
  - Username and password are correct
  - IP address is whitelisted
  - Connection string format is correct

### Server not starting?
- Check if port 5000 is already in use
- Verify all required environment variables are set
- Check for syntax errors in .env file (no extra spaces, quotes)

### CORS errors in browser?
- Add your frontend domain to CORS_ORIGINS
- Ensure no extra spaces in CORS_ORIGINS
- Include http:// or https:// prefix

---

## 📞 SUPPORT

If you encounter issues:
1. Check the main README.md for detailed documentation
2. Check DEPLOYMENT.md for production deployment guide
3. Review the error logs in the terminal
4. Verify all environment variables are correctly set

---

**Remember:** NEVER commit your `.env` file to Git! It contains sensitive information.

The `.gitignore` file is already configured to exclude it.
