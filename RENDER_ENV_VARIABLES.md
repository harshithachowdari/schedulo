# 🔐 Render Environment Variables

Copy these environment variables to your Render dashboard when deploying the backend.

## Environment Variables for Render

```
NODE_ENV=production

MONGODB_URI=mongodb+srv://InvigilatorAllocationSystem:Harshitha@cluster0.glq0uxp.mongodb.net/schedulo?retryWrites=true&w=majority

JWT_SECRET=schedulo_super_secret_jwt_key_2024_production_harshitha_invigilator

JWT_EXPIRE=7d

EMAIL_HOST=smtp.gmail.com

EMAIL_PORT=587

EMAIL_USER=thanujkrishna22@gmail.com

EMAIL_PASS=rnwjaaokushmetzq

FRONTEND_URL=https://your-netlify-site.netlify.app
```

## ⚠️ Important Notes

1. **MONGODB_URI**: I've added `/schedulo` database name and `?retryWrites=true&w=majority` parameters
2. **JWT_SECRET**: Generated a strong secret key for production
3. **FRONTEND_URL**: You'll need to update this with your actual Netlify URL after frontend deployment

## 📝 How to Use These in Render

### Method 1: Via Render Dashboard (Recommended)

1. Go to https://dashboard.render.com/
2. Click **New +** → **Web Service**
3. Connect your GitHub repository (or use manual deploy)
4. Configure:
   - **Name**: `schedulo-backend`
   - **Root Directory**: `backend`
   - **Environment**: `Node`
   - **Build Command**: `npm install`
   - **Start Command**: `npm start`
   - **Instance Type**: `Free`

5. In **Environment Variables** section, add each variable above (one by one):
   - Click **Add Environment Variable**
   - Enter **Key** and **Value**
   - Repeat for all variables

6. Click **Create Web Service**

### Method 2: Via render.yaml (Automatic)

The `backend/render.yaml` file is already configured. Just:
1. Push your code to GitHub
2. Connect the repo to Render
3. Render will auto-detect the configuration
4. Manually add the secret values in dashboard

---

## 🔄 Deployment Steps

### Step 1: Push to GitHub (if not done)

```powershell
cd c:\Users\kotap\OneDrive\Desktop\IN
git init
git add .
git commit -m "Ready for Render deployment"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/schedulo.git
git push -u origin main
```

### Step 2: Deploy on Render

1. **Go to Render**: https://dashboard.render.com/
2. **Sign up/Login** with GitHub
3. **New Web Service**: Click **New +** → **Web Service**
4. **Connect Repository**: 
   - Authorize GitHub
   - Select your `schedulo` repository
5. **Configure Service**:
   - **Name**: `schedulo-backend` (or your choice)
   - **Region**: Choose closest to you
   - **Branch**: `main`
   - **Root Directory**: `backend`
   - **Environment**: `Node`
   - **Build Command**: `npm install`
   - **Start Command**: `npm start`
   - **Instance Type**: `Free`

6. **Add Environment Variables**: Copy from above
7. **Create Web Service**: Click the button
8. **Wait for Deployment**: Takes 5-10 minutes

### Step 3: Get Your Backend URL

Once deployed, Render will give you a URL like:
```
https://schedulo-backend-xxxx.onrender.com
```

Copy this URL - you'll need it for the frontend!

---

## 🔧 After Backend Deployment

### 1. Create Admin Account

Use Render Shell:
1. Go to your service → **Shell** tab
2. Run: `npm run create-admin`

Or manually insert into MongoDB using MongoDB Compass.

### 2. Update Frontend

Update Netlify environment variable:
```powershell
cd c:\Users\kotap\OneDrive\Desktop\IN\frontend
netlify env:set REACT_APP_API_URL "https://your-backend-url.onrender.com"
netlify deploy --prod
```

### 3. Update Backend FRONTEND_URL

1. Go to Render dashboard
2. Navigate to your service → **Environment**
3. Update `FRONTEND_URL` to your Netlify URL
4. Save (will auto-redeploy)

---

## ✅ Verification Checklist

After deployment:
- [ ] Backend is running on Render
- [ ] All environment variables are set
- [ ] MongoDB connection is working (check logs)
- [ ] Admin account created
- [ ] Frontend can connect to backend
- [ ] Login works
- [ ] Email notifications work

---

## 🆘 Troubleshooting

### MongoDB Connection Error
- Check if password has special characters (URL encode them)
- Verify IP whitelist includes 0.0.0.0/0 in MongoDB Atlas
- Check database name is included in connection string

### Email Not Sending
- Verify Gmail App Password is correct
- Check if 2-Step Verification is enabled
- Try generating a new App Password

### Backend Not Starting
- Check Render logs for errors
- Verify all environment variables are set
- Check if `npm start` works locally

---

## 📞 Quick Links

- **Render Dashboard**: https://dashboard.render.com/
- **MongoDB Atlas**: https://cloud.mongodb.com/
- **Your Backend Logs**: Check in Render service → Logs tab

---

Good luck with your deployment! 🚀
