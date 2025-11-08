# 🚀 Deploy Backend to Render - Step by Step

## ✅ Your Credentials Are Ready

I've prepared everything for you. Your environment variables are in `RENDER_ENV_VARIABLES.md`.

---

## 🎯 Two Deployment Options

### Option 1: Deploy via GitHub (Recommended - Easier)

This is the easiest method and enables auto-deployment on code changes.

#### Step 1: Create GitHub Repository

1. Go to https://github.com/new
2. Repository name: `schedulo` (or your choice)
3. Keep it **Private** (recommended)
4. **Don't** initialize with README
5. Click **Create repository**

#### Step 2: Push Your Code to GitHub

Run these commands in PowerShell:

```powershell
cd c:\Users\kotap\OneDrive\Desktop\IN

# Initialize Git
git init

# Add all files
git add .

# Commit
git commit -m "Initial commit - Ready for deployment"

# Set main branch
git branch -M main

# Add remote (replace YOUR_USERNAME with your GitHub username)
git remote add origin https://github.com/YOUR_USERNAME/schedulo.git

# Push to GitHub
git push -u origin main
```

**Note**: You may need to login to GitHub. Use your GitHub username and Personal Access Token (not password).

#### Step 3: Deploy on Render

1. **Go to Render**: https://dashboard.render.com/
2. **Sign up/Login**: Use GitHub to login (easiest)
3. **New Web Service**: Click **New +** → **Web Service**
4. **Connect Repository**: 
   - Click **Connect account** if needed
   - Find and select your `schedulo` repository
   - Click **Connect**

5. **Configure Service**:
   ```
   Name: schedulo-backend
   Region: Singapore (or closest to you)
   Branch: main
   Root Directory: backend
   Environment: Node
   Build Command: npm install
   Start Command: npm start
   Instance Type: Free
   ```

6. **Add Environment Variables** (Click "Advanced" or scroll down):
   
   Copy these one by one from `RENDER_ENV_VARIABLES.md`:
   
   | Key | Value |
   |-----|-------|
   | `NODE_ENV` | `production` |
   | `MONGODB_URI` | `mongodb+srv://InvigilatorAllocationSystem:Harshitha@cluster0.glq0uxp.mongodb.net/schedulo?retryWrites=true&w=majority` |
   | `JWT_SECRET` | `schedulo_super_secret_jwt_key_2024_production_harshitha_invigilator` |
   | `JWT_EXPIRE` | `7d` |
   | `EMAIL_HOST` | `smtp.gmail.com` |
   | `EMAIL_PORT` | `587` |
   | `EMAIL_USER` | `thanujkrishna22@gmail.com` |
   | `EMAIL_PASS` | `rnwjaaokushmetzq` |
   | `FRONTEND_URL` | `http://localhost:3000` (update later with Netlify URL) |

7. **Create Web Service**: Click the button at the bottom

8. **Wait for Deployment**: Takes 5-10 minutes
   - Watch the logs in real-time
   - Look for "Your service is live 🎉"

9. **Copy Your Backend URL**: 
   - Will be something like: `https://schedulo-backend-xxxx.onrender.com`
   - **Save this URL** - you need it for frontend!

---

### Option 2: Manual Deploy (No GitHub Required)

If you don't want to use GitHub:

1. **Zip your backend folder**:
   - Right-click `backend` folder
   - Send to → Compressed (zipped) folder

2. **Go to Render**: https://dashboard.render.com/
3. **New Web Service**: Click **New +** → **Web Service**
4. **Deploy from Git**: Unfortunately, Render requires Git/GitHub

**Recommendation**: Use Option 1 (GitHub) - it's the standard way and enables auto-deployment.

---

## 🔧 After Backend Deployment

### 1. Verify Backend is Running

Check the logs in Render dashboard. Look for:
```
MongoDB Connected
Server running on port 10000
```

### 2. Create Admin Account

**Option A: Using Render Shell**
1. In Render dashboard, go to your service
2. Click **Shell** tab (top right)
3. Run: `npm run create-admin`
4. Wait for "Admin user created successfully"

**Option B: Using MongoDB Compass**
1. Download MongoDB Compass
2. Connect using your MongoDB URI
3. Go to `schedulo` database → `users` collection
4. Insert document manually (see DEPLOYMENT_GUIDE.md for format)

### 3. Test Backend

Open in browser: `https://your-backend-url.onrender.com/api/auth/me`

Should see: `{"success":false,"message":"Not authorized to access this route"}`

This is correct! It means backend is running.

### 4. Update Frontend

Now that you have the backend URL, update your frontend:

```powershell
cd c:\Users\kotap\OneDrive\Desktop\IN\frontend

# Set the backend URL
netlify env:set REACT_APP_API_URL "https://your-backend-url.onrender.com"

# Deploy again
netlify deploy --prod
```

### 5. Update Backend FRONTEND_URL

1. Go to Render dashboard
2. Click your service
3. Go to **Environment** tab
4. Find `FRONTEND_URL`
5. Update to your Netlify URL: `https://your-site.netlify.app`
6. Click **Save Changes** (will auto-redeploy)

---

## ⚠️ Important: MongoDB Atlas Configuration

Make sure your MongoDB Atlas is configured correctly:

1. **Go to MongoDB Atlas**: https://cloud.mongodb.com/
2. **Network Access**: 
   - Click **Network Access** in left sidebar
   - Make sure `0.0.0.0/0` is in the IP Access List
   - If not, click **Add IP Address** → **Allow Access from Anywhere**
3. **Database Access**:
   - Click **Database Access**
   - Verify user `InvigilatorAllocationSystem` exists
   - Password should be `Harshitha`

---

## 🎉 Final Steps - Connect Everything

### 1. Get Your URLs

- **Frontend URL**: `https://your-site.netlify.app` (from Netlify)
- **Backend URL**: `https://schedulo-backend-xxxx.onrender.com` (from Render)

### 2. Cross-Update

**Update Frontend**:
```powershell
cd c:\Users\kotap\OneDrive\Desktop\IN\frontend
netlify env:set REACT_APP_API_URL "https://your-backend-url.onrender.com"
netlify deploy --prod
```

**Update Backend**:
- Go to Render → Environment → Update `FRONTEND_URL` → Save

### 3. Test Everything

1. Open your Netlify URL
2. Login with:
   - Email: `admin@schedulo.com`
   - Password: `admin123`
3. Test features:
   - Dashboard loads
   - File uploads work
   - Notifications work

---

## 🐛 Troubleshooting

### Backend Won't Start

**Check Render Logs**:
- Look for error messages
- Common issues:
  - MongoDB connection failed → Check Atlas IP whitelist
  - Missing environment variables → Verify all are set

### MongoDB Connection Error

1. Check MongoDB Atlas IP whitelist includes `0.0.0.0/0`
2. Verify connection string is correct
3. Check if password has special characters (URL encode them)
4. Ensure database name `/schedulo` is in the connection string

### CORS Errors

- Make sure `FRONTEND_URL` in Render matches your Netlify URL exactly
- Include `https://` in the URL
- No trailing slash

### Email Not Working

- Verify Gmail App Password is correct: `rnwjaaokushmetzq`
- Check if 2-Step Verification is enabled on Google Account
- Try sending a test email from Render Shell

---

## 📊 Render Free Tier Limitations

- **Spins down after 15 minutes** of inactivity
- **First request takes 30-60 seconds** after spin-down (cold start)
- **750 hours/month** free (enough for 1 service)
- **512 MB RAM**

This is normal! For production, upgrade to paid tier ($7/month) for persistent instance.

---

## ✅ Deployment Checklist

- [ ] GitHub repository created
- [ ] Code pushed to GitHub
- [ ] Render account created
- [ ] Web Service created on Render
- [ ] All environment variables added
- [ ] Backend deployed successfully
- [ ] Backend URL copied
- [ ] MongoDB Atlas IP whitelist configured
- [ ] Admin account created
- [ ] Frontend environment variable updated
- [ ] Backend FRONTEND_URL updated
- [ ] Login tested successfully

---

## 🎯 Quick Commands Reference

```powershell
# Push to GitHub
git init
git add .
git commit -m "Ready for deployment"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/schedulo.git
git push -u origin main

# Update Frontend with Backend URL
cd frontend
netlify env:set REACT_APP_API_URL "https://your-backend.onrender.com"
netlify deploy --prod
```

---

## 📞 Need Help?

- **Render Docs**: https://render.com/docs
- **Render Support**: https://render.com/support
- **MongoDB Atlas Docs**: https://docs.atlas.mongodb.com/

---

**Ready to deploy? Follow Option 1 step by step!** 🚀
