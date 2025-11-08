# 🚀 Deployment Guide: Netlify + Render

This guide will help you deploy your Schedulo application with:
- **Frontend** on Netlify (React app)
- **Backend** on Render (Node.js + Express + MongoDB)

---

## 📋 Prerequisites

1. **GitHub Account** - Push your code to GitHub
2. **Netlify Account** - Sign up at [netlify.com](https://netlify.com)
3. **Render Account** - Sign up at [render.com](https://render.com)
4. **MongoDB Atlas** - Free cloud MongoDB at [mongodb.com/atlas](https://www.mongodb.com/atlas)

---

## Part 1: Setup MongoDB Atlas (Database)

### Step 1: Create MongoDB Cluster
1. Go to [MongoDB Atlas](https://www.mongodb.com/atlas)
2. Sign up/Login and create a **FREE** cluster
3. Choose **AWS** as provider and select a region close to you
4. Click **Create Cluster** (takes 3-5 minutes)

### Step 2: Configure Database Access
1. Go to **Database Access** → **Add New Database User**
2. Create a user with username and password (save these!)
3. Set privileges to **Read and write to any database**

### Step 3: Configure Network Access
1. Go to **Network Access** → **Add IP Address**
2. Click **Allow Access from Anywhere** (0.0.0.0/0)
3. Click **Confirm**

### Step 4: Get Connection String
1. Go to **Database** → Click **Connect** on your cluster
2. Choose **Connect your application**
3. Copy the connection string (looks like):
   ```
   mongodb+srv://username:<password>@cluster0.xxxxx.mongodb.net/?retryWrites=true&w=majority
   ```
4. Replace `<password>` with your actual password
5. Add database name before the `?`: 
   ```
   mongodb+srv://username:password@cluster0.xxxxx.mongodb.net/schedulo?retryWrites=true&w=majority
   ```

---

## Part 2: Deploy Backend to Render

### Step 1: Push Code to GitHub
```bash
cd c:\Users\kotap\OneDrive\Desktop\IN
git init
git add .
git commit -m "Initial commit for deployment"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/schedulo.git
git push -u origin main
```

### Step 2: Create Render Web Service
1. Go to [Render Dashboard](https://dashboard.render.com/)
2. Click **New +** → **Web Service**
3. Connect your GitHub repository
4. Configure the service:
   - **Name**: `schedulo-backend` (or your choice)
   - **Region**: Choose closest to you
   - **Branch**: `main`
   - **Root Directory**: `backend`
   - **Environment**: `Node`
   - **Build Command**: `npm install`
   - **Start Command**: `npm start`
   - **Instance Type**: `Free`

### Step 3: Add Environment Variables
In the **Environment** section, add these variables:

| Key | Value |
|-----|-------|
| `NODE_ENV` | `production` |
| `MONGODB_URI` | Your MongoDB Atlas connection string |
| `JWT_SECRET` | Generate a random string (e.g., `openssl rand -base64 32`) |
| `JWT_EXPIRE` | `7d` |
| `EMAIL_HOST` | `smtp.gmail.com` |
| `EMAIL_PORT` | `587` |
| `EMAIL_USER` | Your Gmail address |
| `EMAIL_PASS` | Your Gmail App Password (see below) |
| `FRONTEND_URL` | Leave empty for now (will update after Netlify deployment) |

### Step 4: Gmail App Password Setup
1. Go to [Google Account Security](https://myaccount.google.com/security)
2. Enable **2-Step Verification**
3. Go to **App Passwords**
4. Generate a new app password for "Mail"
5. Copy the 16-character password and use it as `EMAIL_PASS`

### Step 5: Deploy
1. Click **Create Web Service**
2. Wait for deployment (5-10 minutes)
3. Once deployed, copy your backend URL (e.g., `https://schedulo-backend.onrender.com`)

### Step 6: Create Admin Account
After deployment, you need to create an admin account:

**Option A: Using Render Shell**
1. Go to your Render service → **Shell** tab
2. Run: `npm run create-admin`

**Option B: Using MongoDB Compass**
1. Download [MongoDB Compass](https://www.mongodb.com/products/compass)
2. Connect using your MongoDB Atlas connection string
3. Create a document in the `users` collection manually

---

## Part 3: Deploy Frontend to Netlify

### Step 1: Update Frontend Environment
1. Create `.env.production` file in the `frontend` folder:
   ```env
   REACT_APP_API_URL=https://your-backend-name.onrender.com
   ```
   Replace with your actual Render backend URL

2. Commit and push:
   ```bash
   git add .
   git commit -m "Add production environment config"
   git push
   ```

### Step 2: Deploy to Netlify
1. Go to [Netlify Dashboard](https://app.netlify.com/)
2. Click **Add new site** → **Import an existing project**
3. Choose **GitHub** and select your repository
4. Configure build settings:
   - **Base directory**: `frontend`
   - **Build command**: `npm run build`
   - **Publish directory**: `frontend/build`
   - **Branch**: `main`

### Step 3: Add Environment Variables
1. Go to **Site settings** → **Environment variables**
2. Add:
   - **Key**: `REACT_APP_API_URL`
   - **Value**: Your Render backend URL (e.g., `https://schedulo-backend.onrender.com`)

### Step 4: Deploy
1. Click **Deploy site**
2. Wait for build to complete (3-5 minutes)
3. Your site will be live at: `https://random-name-12345.netlify.app`

### Step 5: Custom Domain (Optional)
1. Go to **Domain settings**
2. Click **Add custom domain** or **Change site name**
3. Choose a better subdomain: `schedulo-app.netlify.app`

---

## Part 4: Connect Frontend and Backend

### Step 1: Update Backend CORS
1. Go to your Render service → **Environment**
2. Update `FRONTEND_URL` to your Netlify URL:
   ```
   https://your-site-name.netlify.app
   ```
3. Save and redeploy

### Step 2: Test the Connection
1. Open your Netlify site
2. Try to login with admin credentials:
   - Email: `admin@schedulo.com`
   - Password: `admin123`
3. If login works, you're all set! 🎉

---

## 🔧 Troubleshooting

### Backend Issues

**Problem**: Backend not starting
- Check Render logs for errors
- Verify all environment variables are set correctly
- Ensure MongoDB connection string is correct

**Problem**: CORS errors
- Make sure `FRONTEND_URL` in Render matches your Netlify URL exactly
- Include `https://` in the URL

**Problem**: Email not sending
- Verify Gmail App Password is correct
- Check if 2-Step Verification is enabled
- Try using a different email service

### Frontend Issues

**Problem**: Can't connect to backend
- Check if `REACT_APP_API_URL` is set correctly in Netlify
- Verify backend is running on Render
- Check browser console for errors

**Problem**: Build fails on Netlify
- Check build logs for specific errors
- Ensure all dependencies are in `package.json`
- Try building locally first: `npm run build`

**Problem**: Socket.io not working
- Render free tier may have cold starts (first request takes time)
- Check if backend URL is accessible
- Verify WebSocket connections are allowed

---

## 📊 Monitoring & Maintenance

### Render (Backend)
- **Free Tier Limitations**:
  - Spins down after 15 minutes of inactivity
  - First request after spin-down takes 30-60 seconds
  - 750 hours/month free (enough for 1 service)

- **Logs**: Check Render dashboard → Logs tab
- **Metrics**: View CPU, memory usage in dashboard

### Netlify (Frontend)
- **Free Tier**: 100GB bandwidth/month
- **Logs**: Check Netlify dashboard → Deploys → Deploy log
- **Analytics**: Enable Netlify Analytics (paid) for detailed stats

### MongoDB Atlas
- **Free Tier**: 512MB storage
- **Monitoring**: Check Atlas dashboard for metrics
- **Backups**: Enable automated backups (paid feature)

---

## 🚀 Upgrade Options

### When to Upgrade

**Render Backend** ($7/month):
- Persistent instance (no cold starts)
- Better performance
- More memory and CPU

**Netlify Pro** ($19/month):
- More bandwidth
- Analytics included
- Better support

**MongoDB Atlas** ($9/month):
- More storage
- Automated backups
- Better performance

---

## 🔐 Security Checklist

- [ ] Change default admin password after first login
- [ ] Use strong JWT_SECRET (minimum 32 characters)
- [ ] Enable MongoDB IP whitelist (remove 0.0.0.0/0 after testing)
- [ ] Use Gmail App Password (never use actual password)
- [ ] Enable HTTPS (automatic on Netlify and Render)
- [ ] Regular security updates: `npm audit fix`

---

## 📝 Post-Deployment Tasks

1. **Test all features**:
   - Login/Logout
   - File uploads
   - Allocation generation
   - Email notifications
   - Real-time updates

2. **Create test data**:
   - Upload sample exam timetable
   - Upload faculty details
   - Generate allocations

3. **Document credentials**:
   - Admin login
   - MongoDB connection
   - Email credentials
   - Deployment URLs

4. **Share with users**:
   - Frontend URL
   - Admin credentials (change default!)
   - User guide

---

## 🎉 You're Done!

Your application is now live:
- **Frontend**: https://your-site.netlify.app
- **Backend**: https://your-backend.onrender.com
- **Database**: MongoDB Atlas

### Need Help?
- Check Render logs for backend issues
- Check Netlify deploy logs for frontend issues
- Check browser console for client-side errors

---

## 📞 Support

For issues:
1. Check this guide first
2. Review error logs (Render/Netlify/Browser console)
3. Check MongoDB Atlas connection
4. Verify environment variables

**Common URLs**:
- Render Dashboard: https://dashboard.render.com/
- Netlify Dashboard: https://app.netlify.com/
- MongoDB Atlas: https://cloud.mongodb.com/

---

Built with ❤️ | Deployed on Netlify + Render 🚀
