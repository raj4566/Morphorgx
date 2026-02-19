#!/bin/bash

# Morphergyx LLP - Quick Start Script
# This script helps you set up the project quickly

echo "╔════════════════════════════════════════════════════════╗"
echo "║                                                        ║"
echo "║          🧬 MORPHERGYX LLP SETUP WIZARD 🧬             ║"
echo "║                                                        ║"
echo "╚════════════════════════════════════════════════════════╝"
echo ""

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo "❌ Node.js is not installed. Please install Node.js >= 18.0.0"
    echo "   Visit: https://nodejs.org/"
    exit 1
fi

echo "✅ Node.js $(node --version) detected"

# Check if MongoDB is installed
if ! command -v mongod &> /dev/null; then
    echo "⚠️  MongoDB not found locally"
    echo "   You can either:"
    echo "   1. Install MongoDB locally: https://www.mongodb.com/try/download/community"
    echo "   2. Use MongoDB Atlas (cloud): https://www.mongodb.com/cloud/atlas"
    echo ""
else
    echo "✅ MongoDB detected"
fi

# Navigate to backend directory
cd backend || exit

# Install dependencies
echo ""
echo "📦 Installing backend dependencies..."
npm install

if [ $? -eq 0 ]; then
    echo "✅ Dependencies installed successfully"
else
    echo "❌ Failed to install dependencies"
    exit 1
fi

# Check if .env exists
if [ ! -f .env ]; then
    echo ""
    echo "📝 Creating .env file from template..."
    cp .env.example .env
    echo "✅ .env file created"
    echo ""
    echo "⚠️  IMPORTANT: Please edit backend/.env file and configure:"
    echo "   - MongoDB connection URI"
    echo "   - Email settings (Gmail, SendGrid, etc.)"
    echo "   - Admin credentials"
    echo "   - JWT secret"
    echo ""
    read -p "Press Enter to continue after editing .env file..."
else
    echo "✅ .env file already exists"
fi

# Generate JWT secret if needed
echo ""
echo "🔐 Security Setup"
read -p "Do you want to generate a random JWT secret? (y/n): " generate_jwt

if [ "$generate_jwt" = "y" ] || [ "$generate_jwt" = "Y" ]; then
    JWT_SECRET=$(node -e "console.log(require('crypto').randomBytes(32).toString('hex'))")
    echo ""
    echo "🔑 Generated JWT Secret:"
    echo "   $JWT_SECRET"
    echo ""
    echo "⚠️  Copy this and add it to your .env file as JWT_SECRET"
    echo ""
fi

# Test MongoDB connection
echo ""
read -p "Test MongoDB connection now? (y/n): " test_mongo

if [ "$test_mongo" = "y" ] || [ "$test_mongo" = "Y" ]; then
    echo "🔌 Testing MongoDB connection..."
    node -e "
        require('dotenv').config();
        const mongoose = require('mongoose');
        mongoose.connect(process.env.MONGODB_URI)
            .then(() => {
                console.log('✅ MongoDB connection successful!');
                process.exit(0);
            })
            .catch(err => {
                console.log('❌ MongoDB connection failed:', err.message);
                process.exit(1);
            });
    "
fi

echo ""
echo "╔════════════════════════════════════════════════════════╗"
echo "║                                                        ║"
echo "║                 🎉 SETUP COMPLETE! 🎉                  ║"
echo "║                                                        ║"
echo "╚════════════════════════════════════════════════════════╝"
echo ""
echo "Next steps:"
echo ""
echo "1. Start the backend server:"
echo "   cd backend"
echo "   npm run dev"
echo ""
echo "2. Open the frontend:"
echo "   Open frontend/index.html in your browser"
echo "   Or serve it with: npx http-server frontend -p 3000"
echo ""
echo "3. Test the API:"
echo "   Visit: http://localhost:5000/health"
echo ""
echo "4. Access admin features:"
echo "   Login at: POST http://localhost:5000/api/v1/auth/login"
echo ""
echo "📚 Read README.md for complete documentation"
echo ""
