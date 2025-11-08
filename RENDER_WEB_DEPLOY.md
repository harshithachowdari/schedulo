# 🚀 Deploy Backend on Render (Web Interface)

## ℹ️ Why Web Interface?

Render doesn't have a CLI like Netlify. The web interface is:
- ✅ Official and recommended method
- ✅ Faster than manual configuration
- ✅ Auto-detects settings from `render.yaml`
- ✅ One-time setup, then auto-deploys on git push

---

## 🎯 Quick Deploy (5 Steps)

### Step 1: Open Render Dashboard

**Click here**: https://dashboard.render.com/

### Step 2: Sign In with GitHub

- Click **"Sign in with GitHub"**
- Authorize Render
- This connects your GitHub account

### Step 3: Create Web Service

1. Click **"New +"** (top right)
2. Select **"Web Service"**
3. Find **"schedulo"** in the list
4. Click **"Connect"**

### Step 4: Configure (Auto-filled from render.yaml)

Render will auto-detect most settings. Just verify:

```
Name: schedulo-backend
Region: Singapore (or closest)
Branch: main
Root Directory: backend
Build Command: npm install
Start Command: npm start
Instance Type: Free
```

### Step 5: Add Environment Variables

Click **"Advanced"** and add these 9 variables:

```
NODE_ENV=production
MONGODB_URI=mongodb+srv://InvigilatorAllocationSystem:Harshitha@cluster0.glq0uxp.mongodb.net/schedulo?retryWrites=true&w=majority
JWT_SECRET=schedulo_super_secret_jwt_key_2024_production_harshitha_invigilator
JWT_EXPIRE=7d
EMAIL_HOST=smtp.gmail.com
EMAIL_PORT=587
EMAIL_USER=thanujkrishna22@gmail.com
EMAIL_PASS=rnwjaaokushmetzq
FRONTEND_URL=http://localhost:3000
```

Click **"Create Web Service"** → Wait 5-10 minutes → Done! 🎉

---

## 🔄 Alternative: Use render.yaml (Infrastructure as Code)

I've already created `backend/render.yaml` for you. This file tells Render how to deploy your app.

### What's in render.yaml:

```yaml
services:
  - type: web
    name: schedulo-backend
    env: node
    buildCommand: npm install
    startCommand: npm start
```

### To use it:

1. Go to Render Dashboard
2. New + → Blueprint
3. Connect your repo
4. Render reads the yaml file automatically
5. You only need to add the secret environment variables

---

## 📋 Environment Variables (Copy-Paste Ready)

### For Render Dashboard:

**NODE_ENV**
```
production
```

**MONGODB_URI**
```
mongodb+srv://InvigilatorAllocationSystem:Harshitha@cluster0.glq0uxp.mongodb.net/schedulo?retryWrites=true&w=majority
```

**JWT_SECRET**
```
schedulo_super_secret_jwt_key_2024_production_harshitha_invigilator
```

**JWT_EXPIRE**
```
7d
```

**EMAIL_HOST**
```
smtp.gmail.com
```

**EMAIL_PORT**
```
587
```

**EMAIL_USER**
```
thanujkrishna22@gmail.com
```

**EMAIL_PASS**
```
rnwjaaokushmetzq
```

**FRONTEND_URL**
```
http://localhost:3000
```

---

## ✅ After Deployment

### 1. Get Your Backend URL

Look at the top of your Render service page:
```
https://schedulo-backend-xxxx.onrender.com
```

### 2. Test Backend

Open in browser:
```
https://your-backend-url.onrender.com/api/auth/me
```

Should see:
```json
{"success":false,"message":"Not authorized to access this route"}
```

This is correct! ✅

### 3. Create Admin Account

In Render dashboard:
1. Go to your service
2. Click **"Shell"** tab
3. Run: `npm run create-admin`
4. Wait for success message

### 4. Update Frontend

```powershell
cd c:\Users\kotap\OneDrive\Desktop\IN\frontend
netlify env:set REACT_APP_API_URL "https://your-backend-url.onrender.com"
netlify deploy --prod
```

### 5. Update Backend FRONTEND_URL

1. Render dashboard → Your service
2. Environment tab
3. Edit `FRONTEND_URL`
4. Set to your Netlify URL
5. Save (auto-redeploys)

---

## 🎯 Why This is Better Than CLI

1. **Visual feedback** - See logs in real-time
2. **Auto-deploy** - Push to GitHub = auto-deploy
3. **Easy management** - Change env vars, view logs, restart
4. **Official method** - Supported by Render
5. **One-time setup** - Configure once, deploy forever

---

## 🚀 Ready to Deploy?

**Click here to start**: https://dashboard.render.com/

Follow the 5 steps above and you'll be deployed in 10 minutes!

---

## 🆘 Need Help?

If you get stuck:
1. Check Render logs for errors
2. Verify all environment variables are set
3. Check MongoDB Atlas IP whitelist (0.0.0.0/0)
4. Tell me what error you see

---

**Your code is ready on GitHub. Just go to Render and click a few buttons!** 🎉
