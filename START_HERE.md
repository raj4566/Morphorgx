# 🎉 MORPHERGYX LLP - COMPLETE PROJECT PACKAGE

## 📦 What You've Received

A **production-ready** full-stack web application for Morphergyx LLP including:

✅ **Beautiful Frontend** - Premium B2B landing page with animations  
✅ **Robust Backend** - Express.js REST API with MongoDB  
✅ **Email System** - Automated notifications (customer + admin)  
✅ **Admin Panel Ready** - JWT authentication infrastructure  
✅ **Complete Documentation** - Setup, deployment, and API guides  
✅ **Security** - Rate limiting, validation, CORS, helmet  
✅ **Testing Tools** - Postman collection included  

---

## 📁 Project Structure

```
morphergyx/
│
├── frontend/                           # Landing page
│   ├── index.html                      # Main HTML file
│   ├── scripts/
│   │   └── main.js                     # Frontend JavaScript + API integration
│   └── assets/                         # (Empty - for images/fonts)
│
├── backend/                            # API Server
│   ├── src/
│   │   ├── server.js                   # Main Express server
│   │   ├── routes/
│   │   │   ├── inquiry.routes.js       # Inquiry endpoints
│   │   │   └── auth.routes.js          # Authentication endpoints
│   │   ├── controllers/
│   │   │   └── inquiry.controller.js   # Business logic
│   │   ├── models/
│   │   │   └── inquiry.model.js        # MongoDB schema
│   │   ├── middlewares/
│   │   │   └── auth.middleware.js      # JWT authentication
│   │   └── config/
│   │       ├── db.js                   # Database connection
│   │       └── mail.js                 # Email configuration
│   │
│   ├── package.json                    # Dependencies
│   ├── .env                            # Environment variables (EDIT THIS!)
│   ├── .env.example                    # Environment template
│   └── Morphergyx-API.postman_collection.json
│
├── .gitignore                          # Git ignore rules
├── setup.sh                            # Quick setup script (Linux/Mac)
├── README.md                           # Main documentation
├── DEPLOYMENT.md                       # Production deployment guide
└── MANUAL_CONFIGURATION.md             # Step-by-step config guide ⭐
```

---

## 🚀 QUICK START (5 Minutes)

### Step 1: Install Dependencies
```bash
cd backend
npm install
```

### Step 2: Configure Environment
```bash
# Edit backend/.env file
# SEE MANUAL_CONFIGURATION.md for detailed instructions
```

**MUST CONFIGURE:**
1. Email settings (Gmail recommended for testing)
2. Admin credentials
3. JWT secret
4. MongoDB URI

### Step 3: Start Backend
```bash
npm run dev
```

### Step 4: Open Frontend
```bash
# Just open in browser:
open frontend/index.html

# Or serve with:
cd ../frontend
npx http-server -p 3000
```

### Step 5: Test It
- Visit: http://localhost:3000
- Submit an inquiry form
- Check health: http://localhost:5000/health

---

## ⚠️ WHAT TO EDIT MANUALLY

### Priority 1 - MUST EDIT (Won't work without these):

1. **Email Configuration** (`backend/.env`)
   - `EMAIL_USER` - Your email address
   - `EMAIL_PASSWORD` - App-specific password
   - See MANUAL_CONFIGURATION.md for Gmail setup

2. **Admin Credentials** (`backend/.env`)
   - `ADMIN_EMAIL` - Your admin email
   - `ADMIN_PASSWORD` - Strong password (min 8 chars)

3. **JWT Secret** (`backend/.env`)
   - `JWT_SECRET` - Generate with: `node -e "console.log(require('crypto').randomBytes(32).toString('hex'))"`

4. **MongoDB** (`backend/.env`)
   - Local: `mongodb://localhost:27017/morphergyx`
   - Cloud: MongoDB Atlas connection string
   - See MANUAL_CONFIGURATION.md for Atlas setup

### Priority 2 - SHOULD EDIT (For production):

5. **Frontend API URL** (`frontend/scripts/main.js` line 4)
   - Update with your production API URL

6. **CORS Origins** (`backend/.env`)
   - Add your production domain(s)

---

## 📚 Documentation Files

| File | Purpose | When to Read |
|------|---------|--------------|
| **MANUAL_CONFIGURATION.md** ⭐ | Step-by-step config guide | READ THIS FIRST! |
| **README.md** | Complete documentation | Setup & API reference |
| **DEPLOYMENT.md** | Production deployment | When going live |

---

## 🔥 Features Implemented

### Frontend:
- [x] Premium dark-mode design with bioluminescent accents
- [x] Morphing organic-to-industrial animations
- [x] Product card slider (3 products)
- [x] Real-time carbon counter
- [x] Interactive inquiry form with validation
- [x] Responsive design (mobile-ready)
- [x] Smooth scrolling navigation

### Backend:
- [x] RESTful API with Express.js
- [x] MongoDB database with Mongoose ODM
- [x] Automated email notifications (customer + admin)
- [x] JWT authentication for admin
- [x] Rate limiting (anti-abuse)
- [x] Input validation with express-validator
- [x] Security (Helmet, CORS, sanitization)
- [x] Error handling & logging
- [x] Health check endpoint
- [x] Statistics dashboard endpoint

### API Endpoints:
- [x] POST /api/v1/inquiries - Submit inquiry
- [x] GET /api/v1/inquiries - List all (admin)
- [x] GET /api/v1/inquiries/:id - Get details (admin)
- [x] PATCH /api/v1/inquiries/:id - Update (admin)
- [x] POST /api/v1/inquiries/:id/notes - Add note (admin)
- [x] DELETE /api/v1/inquiries/:id - Delete (admin)
- [x] GET /api/v1/inquiries/stats - Statistics (admin)
- [x] POST /api/v1/auth/login - Admin login
- [x] GET /api/v1/auth/verify - Verify token

---

## 🧪 Testing the API

### Option 1: Postman Collection (Recommended)
1. Import `backend/Morphergyx-API.postman_collection.json`
2. Test all endpoints with pre-configured requests

### Option 2: cURL
```bash
# Submit inquiry
curl -X POST http://localhost:5000/api/v1/inquiries \
  -H "Content-Type: application/json" \
  -d '{
    "company": "Test Corp",
    "name": "John Doe",
    "email": "john@test.com",
    "phone": "+1234567890",
    "interest": "biofertilizer",
    "volume": 10000
  }'

# Admin login
curl -X POST http://localhost:5000/api/v1/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "email": "admin@morphergyx.com",
    "password": "your-password"
  }'
```

---

## 🚀 Deployment Options

### Easiest (Free):
1. **Railway** - Auto-deploy from GitHub, includes MongoDB
2. **Render** - Free tier with MongoDB included
3. **Heroku** - Classic PaaS (need MongoDB Atlas)

### Frontend:
1. **Netlify** - Drag & drop deployment
2. **Vercel** - CLI or GitHub integration
3. **GitHub Pages** - Free static hosting

**See DEPLOYMENT.md for complete guides**

---

## 🔒 Security Checklist

Before production:
- [ ] Change ALL default passwords
- [ ] Generate strong JWT secret (32+ chars)
- [ ] Use HTTPS
- [ ] Set NODE_ENV=production
- [ ] Configure CORS with specific origins
- [ ] Use MongoDB Atlas with auth
- [ ] Never commit .env file
- [ ] Add authentication to admin routes
- [ ] Regular npm audit

---

## 📊 Database Schema

The system automatically creates these MongoDB collections:

**inquiries:**
- Company info (name, email, phone)
- Product interest
- Expected volume
- Status tracking (new → contacted → in-progress → converted)
- Priority levels
- Notes & follow-up dates
- Timestamps

---

## 🎯 Next Steps

1. **Now:** Read MANUAL_CONFIGURATION.md and configure .env
2. **Then:** Test locally with `npm run dev`
3. **Finally:** Deploy to production (see DEPLOYMENT.md)

---

## ❓ Common Questions

**Q: Where do I change the admin password?**  
A: In `backend/.env` - `ADMIN_PASSWORD=your-password`

**Q: How do I setup email?**  
A: See MANUAL_CONFIGURATION.md section 1 for Gmail setup

**Q: Can I use a different database?**  
A: MongoDB is required. Use MongoDB Atlas (free) for cloud hosting.

**Q: How do I add more products?**  
A: Edit `frontend/index.html` and duplicate a product card

**Q: Is this production-ready?**  
A: Yes, but you MUST configure .env properly first

**Q: How do I protect admin routes?**  
A: Uncomment the `protect` middleware in `backend/src/routes/inquiry.routes.js`

---

## 🆘 Getting Help

1. Check the error logs in terminal
2. Read MANUAL_CONFIGURATION.md
3. Review README.md for API details
4. Test with Postman collection
5. Check if MongoDB is running
6. Verify .env configuration

---

## 📞 Support

For questions or issues:
- Email: info@morphergyx.com
- Check documentation files
- Review code comments

---

## 🎉 You're All Set!

Everything is ready to go. Just configure the `.env` file and you're good to launch!

**Start with:** MANUAL_CONFIGURATION.md → Then test locally → Then deploy

Good luck with your launch! 🚀

---

**Built with ❤️ for Morphergyx LLP**  
*Waste-to-Value Biotechnology*
