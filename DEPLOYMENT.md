# Morphergyx LLP - Deployment Guide

## 🚀 Production Deployment Options

### Option 1: Deploy to Heroku (Easiest)

#### Prerequisites
- Heroku account
- Heroku CLI installed
- MongoDB Atlas account

#### Steps

1. **Setup MongoDB Atlas**
   ```bash
   # Create cluster at https://cloud.mongodb.com
   # Get connection string and update in Heroku config vars
   ```

2. **Login to Heroku**
   ```bash
   heroku login
   ```

3. **Create Heroku App**
   ```bash
   cd backend
   heroku create morphergyx-api
   ```

4. **Set Environment Variables**
   ```bash
   heroku config:set NODE_ENV=production
   heroku config:set MONGODB_URI="your-mongodb-atlas-uri"
   heroku config:set JWT_SECRET="your-secret-key"
   heroku config:set EMAIL_HOST="smtp.gmail.com"
   heroku config:set EMAIL_PORT=587
   heroku config:set EMAIL_USER="your-email@gmail.com"
   heroku config:set EMAIL_PASSWORD="your-app-password"
   heroku config:set ADMIN_EMAIL="admin@morphergyx.com"
   heroku config:set ADMIN_PASSWORD="secure-password"
   ```

5. **Deploy**
   ```bash
   git init
   git add .
   git commit -m "Initial deployment"
   git push heroku main
   ```

6. **Open Application**
   ```bash
   heroku open
   ```

---

### Option 2: Deploy to Railway (Modern & Fast)

#### Steps

1. **Visit [railway.app](https://railway.app)**

2. **Create New Project from GitHub**
   - Connect your repository
   - Railway auto-detects Node.js

3. **Add MongoDB**
   - Click "New" > "Database" > "Add MongoDB"
   - Connection string automatically added to env vars

4. **Set Environment Variables**
   ```
   NODE_ENV=production
   JWT_SECRET=your-secret-key
   EMAIL_HOST=smtp.gmail.com
   EMAIL_PORT=587
   EMAIL_USER=your-email@gmail.com
   EMAIL_PASSWORD=your-app-password
   ADMIN_EMAIL=admin@morphergyx.com
   ADMIN_PASSWORD=secure-password
   SEND_EMAIL_NOTIFICATIONS=true
   SEND_ADMIN_NOTIFICATIONS=true
   ```

5. **Deploy**
   - Push to GitHub
   - Railway auto-deploys

---

### Option 3: Deploy to Render (Free Tier Available)

#### Steps

1. **Visit [render.com](https://render.com)**

2. **Create Web Service**
   - Connect GitHub repository
   - Select `backend` folder as root directory

3. **Configure Service**
   ```
   Name: morphergyx-api
   Environment: Node
   Build Command: npm install
   Start Command: npm start
   ```

4. **Add Environment Variables**
   - Go to Environment tab
   - Add all variables from `.env.example`

5. **Create MongoDB**
   - Go to Dashboard > New > MongoDB
   - Copy connection string to `MONGODB_URI`

---

### Option 4: DigitalOcean / AWS / VPS

#### Setup on Ubuntu Server

1. **Connect to Server**
   ```bash
   ssh root@your-server-ip
   ```

2. **Install Node.js**
   ```bash
   curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
   sudo apt-get install -y nodejs
   ```

3. **Install MongoDB**
   ```bash
   # Follow official guide
   wget -qO - https://www.mongodb.org/static/pgp/server-6.0.asc | sudo apt-key add -
   echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/6.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-6.0.list
   sudo apt-get update
   sudo apt-get install -y mongodb-org
   sudo systemctl start mongod
   sudo systemctl enable mongod
   ```

4. **Install PM2 (Process Manager)**
   ```bash
   sudo npm install -g pm2
   ```

5. **Clone Repository**
   ```bash
   cd /var/www
   git clone your-repo-url morphergyx
   cd morphergyx/backend
   npm install
   ```

6. **Setup Environment**
   ```bash
   nano .env
   # Add all environment variables
   ```

7. **Start with PM2**
   ```bash
   pm2 start src/server.js --name morphergyx-api
   pm2 save
   pm2 startup
   ```

8. **Setup Nginx (Reverse Proxy)**
   ```bash
   sudo apt install nginx
   sudo nano /etc/nginx/sites-available/morphergyx
   ```

   Add configuration:
   ```nginx
   server {
       listen 80;
       server_name api.morphergyx.com;

       location / {
           proxy_pass http://localhost:5000;
           proxy_http_version 1.1;
           proxy_set_header Upgrade $http_upgrade;
           proxy_set_header Connection 'upgrade';
           proxy_set_header Host $host;
           proxy_cache_bypass $http_upgrade;
       }
   }
   ```

   Enable site:
   ```bash
   sudo ln -s /etc/nginx/sites-available/morphergyx /etc/nginx/sites-enabled/
   sudo nginx -t
   sudo systemctl restart nginx
   ```

9. **Setup SSL with Let's Encrypt**
   ```bash
   sudo apt install certbot python3-certbot-nginx
   sudo certbot --nginx -d api.morphergyx.com
   ```

---

## 🌐 Frontend Deployment

### Option 1: Netlify (Recommended)

1. **Visit [netlify.com](https://netlify.com)**
2. **Drag and drop `frontend` folder**
3. **Update API URL in `frontend/scripts/main.js`**:
   ```javascript
   const API_BASE_URL = 'https://your-backend-url.com/api/v1';
   ```

### Option 2: Vercel

1. **Install Vercel CLI**
   ```bash
   npm i -g vercel
   ```

2. **Deploy**
   ```bash
   cd frontend
   vercel
   ```

### Option 3: GitHub Pages

1. **Create `frontend/.nojekyll` file**
2. **Push to GitHub**
3. **Go to Settings > Pages**
4. **Select branch and `/frontend` folder**

---

## 🔒 Security Checklist

Before going to production:

- [ ] Change all default passwords
- [ ] Use strong JWT secret (32+ characters)
- [ ] Enable HTTPS
- [ ] Set `NODE_ENV=production`
- [ ] Configure CORS with specific origins
- [ ] Use MongoDB Atlas with IP whitelist
- [ ] Enable rate limiting
- [ ] Add authentication to admin routes
- [ ] Set up monitoring (e.g., Sentry)
- [ ] Configure proper logging
- [ ] Set up automated backups
- [ ] Use app-specific passwords for email
- [ ] Hide error stack traces in production

---

## 📊 Monitoring & Logging

### Setup Application Monitoring

```bash
# Install Sentry
npm install @sentry/node

# Add to server.js
const Sentry = require("@sentry/node");

Sentry.init({
  dsn: "your-sentry-dsn",
  environment: process.env.NODE_ENV,
});
```

### Setup Log Management

Use PM2 logs for production:
```bash
pm2 logs morphergyx-api
pm2 logs --json > logs.json
```

Or use services like:
- Loggly
- Papertrail
- DataDog

---

## 🔄 CI/CD Pipeline

### GitHub Actions Example

Create `.github/workflows/deploy.yml`:

```yaml
name: Deploy to Production

on:
  push:
    branches: [ main ]

jobs:
  deploy:
    runs-on: ubuntu-latest
    
    steps:
    - uses: actions/checkout@v2
    
    - name: Setup Node.js
      uses: actions/setup-node@v2
      with:
        node-version: '18'
    
    - name: Install dependencies
      run: |
        cd backend
        npm install
    
    - name: Run tests
      run: |
        cd backend
        npm test
    
    - name: Deploy to Heroku
      uses: akhileshns/heroku-deploy@v3.12.12
      with:
        heroku_api_key: ${{secrets.HEROKU_API_KEY}}
        heroku_app_name: "morphergyx-api"
        heroku_email: "your-email@example.com"
```

---

## 📈 Scaling Considerations

As your application grows:

1. **Database**: Use MongoDB Atlas with auto-scaling
2. **Caching**: Implement Redis for frequently accessed data
3. **CDN**: Use Cloudflare for static assets
4. **Load Balancing**: Multiple server instances behind a load balancer
5. **Background Jobs**: Use Bull or Bee Queue for email sending
6. **API Gateway**: Kong or AWS API Gateway for rate limiting and routing

---

## 🆘 Troubleshooting

### Common Issues

**MongoDB Connection Failed**
```bash
# Check if MongoDB is running
sudo systemctl status mongod

# Check connection string format
# mongodb+srv://<username>:<password>@cluster.mongodb.net/dbname
```

**Email Not Sending**
```bash
# For Gmail, enable "Less secure app access" or use App Password
# Check EMAIL_HOST, EMAIL_PORT, EMAIL_USER, EMAIL_PASSWORD
```

**Port Already in Use**
```bash
# Find process using port 5000
lsof -i :5000
# Kill process
kill -9 <PID>
```

---

For more help, contact: info@morphergyx.com
