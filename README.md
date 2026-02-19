# Morphergyx LLP - Waste-to-Value Biotechnology Platform

A production-ready B2B landing page with complete backend API for Morphergyx LLP, a pioneer in waste-to-value biotechnology.

## 🚀 Features

### Frontend
- **Premium Design**: Dark mode with bioluminescent green accents
- **Morphing Animations**: Organic-to-industrial transformation visuals
- **Product Showcase**: Interactive card slider for three product lines
- **Real-time Impact Counter**: Live carbon diversion metrics
- **Inquiry Form**: Professional contact form with validation
- **Responsive**: Mobile-first design

### Backend
- **RESTful API**: Built with Express.js
- **MongoDB Database**: Scalable data storage with Mongoose ODM
- **Email Notifications**: Automated emails to customers and admins
- **JWT Authentication**: Secure admin authentication
- **Rate Limiting**: Protection against abuse
- **Input Validation**: Comprehensive data validation
- **Error Handling**: Robust error handling and logging
- **Security**: Helmet.js, CORS, data sanitization

## 📋 Prerequisites

- Node.js >= 18.0.0
- MongoDB >= 5.0 (local or Atlas)
- npm >= 9.0.0

## 🛠️ Installation

### 1. Clone the repository
```bash
git clone <your-repo-url>
cd morphergyx
```

### 2. Install Backend Dependencies
```bash
cd backend
npm install
```

### 3. Configure Environment Variables

Copy `.env.example` to `.env`:
```bash
cp .env.example .env
```

Edit `.env` and configure the following:

```env
# Server Configuration
NODE_ENV=development
PORT=5000
API_VERSION=v1

# MongoDB - Choose one:
# Local MongoDB:
MONGODB_URI=mongodb://localhost:27017/morphergyx

# Or MongoDB Atlas (Production):
MONGODB_URI=mongodb+srv://<username>:<password>@cluster.mongodb.net/morphergyx?retryWrites=true&w=majority

# JWT Configuration
JWT_SECRET=your-super-secret-jwt-key-min-32-characters-long
JWT_EXPIRE=24h

# Email Configuration (Gmail example)
EMAIL_HOST=smtp.gmail.com
EMAIL_PORT=587
EMAIL_USER=your-email@gmail.com
EMAIL_PASSWORD=your-app-specific-password
EMAIL_FROM=noreply@morphergyx.com
EMAIL_FROM_NAME=Morphergyx LLP

# Admin Credentials
ADMIN_EMAIL=admin@morphergyx.com
ADMIN_PASSWORD=Change_This_Secure_Password_123!

# CORS Origins (comma-separated)
CORS_ORIGINS=http://localhost:3000,https://morphergyx.com

# Notifications
SEND_EMAIL_NOTIFICATIONS=true
SEND_ADMIN_NOTIFICATIONS=true
```

### 4. Start MongoDB (if using local)
```bash
# macOS
brew services start mongodb-community

# Linux
sudo systemctl start mongod

# Windows
net start MongoDB
```

### 5. Start the Backend Server
```bash
# Development mode with auto-reload
npm run dev

# Production mode
npm start
```

Server will start at `http://localhost:5000`

### 6. Open the Frontend

Open `frontend/index.html` in your browser, or serve it with a simple HTTP server:

```bash
cd ../frontend
# Using Python
python -m http.server 3000

# Or using Node.js http-server
npx http-server -p 3000
```

Visit `http://localhost:3000`

## 📧 Email Configuration

### Using Gmail (Recommended for testing)

1. Go to your Google Account settings
2. Enable 2-Factor Authentication
3. Generate an App Password:
   - Go to Security > 2-Step Verification > App passwords
   - Select "Mail" and your device
   - Copy the generated password
4. Use this password in `EMAIL_PASSWORD` in `.env`

### Using Other Email Providers

Update these in `.env`:
- **SendGrid**: `EMAIL_HOST=smtp.sendgrid.net`, `EMAIL_PORT=587`
- **Mailgun**: `EMAIL_HOST=smtp.mailgun.org`, `EMAIL_PORT=587`
- **AWS SES**: `EMAIL_HOST=email-smtp.region.amazonaws.com`, `EMAIL_PORT=587`

## 🗄️ MongoDB Setup

### Option 1: Local MongoDB
Install MongoDB locally and it will automatically create the database on first connection.

### Option 2: MongoDB Atlas (Cloud - Recommended for Production)

1. Create account at [mongodb.com/cloud/atlas](https://mongodb.com/cloud/atlas)
2. Create a new cluster (Free tier available)
3. Create a database user
4. Whitelist your IP address (or use 0.0.0.0/0 for development)
5. Get your connection string and update `MONGODB_URI` in `.env`

## 🔐 API Endpoints

### Public Endpoints

#### Submit Inquiry
```http
POST /api/v1/inquiries
Content-Type: application/json

{
  "company": "Tech Corp",
  "name": "John Doe",
  "email": "john@techcorp.com",
  "phone": "+1234567890",
  "interest": "biofertilizer",
  "volume": 10000,
  "message": "Interested in bulk purchase"
}
```

#### Health Check
```http
GET /health
```

### Admin Endpoints (Protected)

#### Login
```http
POST /api/v1/auth/login
Content-Type: application/json

{
  "email": "admin@morphergyx.com",
  "password": "your-password"
}
```

#### Get All Inquiries
```http
GET /api/v1/inquiries
Authorization: Bearer <jwt-token>

Query Parameters:
- page: number (default: 1)
- limit: number (default: 10)
- status: new|contacted|in-progress|converted|closed
- interest: biofertilizer|reactor|bioplastic|multiple|custom
- search: string (searches company, email, name)
```

#### Get Inquiry by ID
```http
GET /api/v1/inquiries/:id
Authorization: Bearer <jwt-token>
```

#### Update Inquiry
```http
PATCH /api/v1/inquiries/:id
Authorization: Bearer <jwt-token>
Content-Type: application/json

{
  "status": "contacted",
  "priority": "high",
  "followUpDate": "2024-02-15"
}
```

#### Add Note to Inquiry
```http
POST /api/v1/inquiries/:id/notes
Authorization: Bearer <jwt-token>
Content-Type: application/json

{
  "text": "Called customer, scheduled meeting for next week"
}
```

#### Get Statistics
```http
GET /api/v1/inquiries/stats
Authorization: Bearer <jwt-token>
```

#### Delete Inquiry
```http
DELETE /api/v1/inquiries/:id
Authorization: Bearer <jwt-token>
```

## 🧪 Testing the API

### Using cURL

```bash
# Submit inquiry
curl -X POST http://localhost:5000/api/v1/inquiries \
  -H "Content-Type: application/json" \
  -d '{
    "company": "Test Corp",
    "name": "Jane Smith",
    "email": "jane@test.com",
    "phone": "+1234567890",
    "interest": "reactor",
    "volume": 50000,
    "message": "Looking for dual reactor system"
  }'

# Login
curl -X POST http://localhost:5000/api/v1/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "email": "admin@morphergyx.com",
    "password": "your-password"
  }'

# Get inquiries (replace TOKEN with actual JWT)
curl http://localhost:5000/api/v1/inquiries \
  -H "Authorization: Bearer TOKEN"
```

### Using Postman

1. Import the following as a collection:
2. Create environment variables for `baseUrl` and `token`
3. Test each endpoint

## 🚀 Deployment

### Backend Deployment (Heroku, Railway, Render)

1. **Environment Variables**: Set all `.env` variables in your hosting platform
2. **MongoDB**: Use MongoDB Atlas for production
3. **Start Command**: `npm start`
4. **Build Command**: None needed for Node.js

### Frontend Deployment (Netlify, Vercel, GitHub Pages)

1. Upload the `frontend` folder
2. Update `API_BASE_URL` in `frontend/scripts/main.js` to your production API URL

### Full-Stack Deployment (Single Server)

The backend serves the frontend in production mode:

1. Copy frontend files to `backend/public/`
2. Set `NODE_ENV=production`
3. Backend will serve frontend automatically

## 📊 Database Schema

### Inquiry Model
```javascript
{
  company: String (required, 2-200 chars)
  name: String (required, 2-100 chars)
  email: String (required, validated)
  phone: String (required, validated)
  interest: Enum (biofertilizer|reactor|bioplastic|multiple|custom)
  volume: Number (optional, 0-100000000)
  message: String (optional, max 2000 chars)
  status: Enum (new|contacted|in-progress|converted|closed)
  priority: Enum (low|medium|high|urgent)
  source: String (default: 'website')
  ipAddress: String
  userAgent: String
  assignedTo: ObjectId (ref: User)
  notes: Array of {text, addedBy, addedAt}
  followUpDate: Date
  emailSent: Boolean
  adminNotified: Boolean
  createdAt: Date (auto)
  updatedAt: Date (auto)
}
```

## 🔧 Configuration Guide

### What You MUST Edit Manually:

1. **Email Configuration** (`.env`):
   - `EMAIL_USER`: Your email address
   - `EMAIL_PASSWORD`: Your app-specific password
   - `ADMIN_EMAIL`: Where to receive notifications

2. **Admin Credentials** (`.env`):
   - `ADMIN_EMAIL`: Admin login email
   - `ADMIN_PASSWORD`: Strong password (min 8 chars)

3. **JWT Secret** (`.env`):
   - `JWT_SECRET`: Generate a strong random string (min 32 chars)
   ```bash
   # Generate using Node.js
   node -e "console.log(require('crypto').randomBytes(32).toString('hex'))"
   ```

4. **MongoDB URI** (`.env`):
   - For production, use MongoDB Atlas connection string
   - Replace `<username>`, `<password>`, `cluster` with your values

5. **CORS Origins** (`.env`):
   - Add your production domain(s)
   - Example: `CORS_ORIGINS=https://morphergyx.com,https://www.morphergyx.com`

6. **Frontend API URL** (`frontend/scripts/main.js`, line 2):
   - Update production API URL
   ```javascript
   const API_BASE_URL = window.location.hostname === 'localhost' 
       ? 'http://localhost:5000/api/v1' 
       : 'https://api.morphergyx.com/api/v1'; // Change this
   ```

## 🛡️ Security Checklist

- [ ] Change all default passwords
- [ ] Use strong JWT secret (32+ characters)
- [ ] Enable HTTPS in production
- [ ] Set `NODE_ENV=production`
- [ ] Configure CORS properly (specific origins)
- [ ] Use environment variables for all secrets
- [ ] Enable rate limiting
- [ ] Implement authentication for admin routes
- [ ] Use MongoDB Atlas with authentication
- [ ] Regular security updates (`npm audit`)

## 📝 License

MIT License - feel free to use for your projects

## 🤝 Support

For issues or questions:
- Email: info@morphergyx.com
- Create an issue in the repository

---

**Built with ❤️ for Morphergyx LLP**
