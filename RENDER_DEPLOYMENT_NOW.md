# 🚀 Deploy Backend on Render - Step by Step

## ✅ Code is on GitHub!

Your repository: https://github.com/harshithachowdari/schedulo

---

## 🎯 Step 1: Go to Render

**Click this link**: https://dashboard.render.com/

---

## 🔐 Step 2: Sign Up / Login

1. Click **"Get Started"** or **"Sign In"**
2. Choose **"Sign in with GitHub"** (EASIEST!)
3. Authorize Render to access your GitHub account
4. Grant access when prompted

---

## ➕ Step 3: Create New Web Service

1. Click the **"New +"** button (top right corner)
2. Select **"Web Service"**

---

## 🔗 Step 4: Connect Your Repository

1. You'll see a list of your GitHub repositories
2. Find **"schedulo"** in the list
3. Click **"Connect"** button next to it

**If you don't see it:**
- Click **"Configure account"** 
- Grant Render access to the repository
- Come back and refresh

---

## ⚙️ Step 5: Configure Your Service

Fill in these fields **EXACTLY**:

### Basic Settings:
```
Name: schedulo-backend
Region: Singapore (or closest to you: Oregon, Frankfurt, Ohio)
Branch: main
Root Directory: backend
Runtime: Node
Build Command: npm install
Start Command: npm start
```

### Instance Type:
```
Instance Type: Free
```

---

## 🔐 Step 6: Add Environment Variables

**IMPORTANT**: Scroll down or click **"Advanced"** to see Environment Variables section.

Click **"Add Environment Variable"** and add these **ONE BY ONE**:

### Variable 1:
```
Key: NODE_ENV
Value: production
```

### Variable 2:
```
Key: MONGODB_URI
Value: mongodb+srv://InvigilatorAllocationSystem:Harshitha@cluster0.glq0uxp.mongodb.net/schedulo?retryWrites=true&w=majority
```

### Variable 3:
```
Key: JWT_SECRET
Value: schedulo_super_secret_jwt_key_2024_production_harshitha_invigilator
```

### Variable 4:
```
Key: JWT_EXPIRE
Value: 7d
```

### Variable 5:
```
Key: EMAIL_HOST
Value: smtp.gmail.com
```

### Variable 6:
```
Key: EMAIL_PORT
Value: 587
```

### Variable 7:
```
Key: EMAIL_USER
Value: thanujkrishna22@gmail.com
```

### Variable 8:
```
Key: EMAIL_PASS
Value: rnwjaaokushmetzq
```

### Variable 9:
```
Key: FRONTEND_URL
Value: http://localhost:3000
```
*(We'll update this later with your Netlify URL)*

---

## 🚀 Step 7: Create Web Service

1. Scroll to the bottom
2. Click the big **"Create Web Service"** button
3. Wait for deployment (5-10 minutes)

---

## 👀 Step 8: Watch the Deployment

You'll see logs in real-time:
- Installing dependencies...
- Building...
- Starting server...
- Look for: **"Your service is live 🎉"**

### What to Look For in Logs:
```
MongoDB Connected ✅
Server running on port 10000 ✅
```

---

## 📋 Step 9: Copy Your Backend URL

Once deployed, you'll see your URL at the top:
```
https://schedulo-backend-xxxx.onrender.com
```

**SAVE THIS URL!** You need it for:
1. Frontend environment variable
2. Testing the backend
3. Creating admin account

---

## ✅ Step 10: Verify Backend is Running

1. Copy your backend URL
2. Open in browser: `https://your-backend-url.onrender.com/api/auth/me`
3. You should see:
   ```json
   {"success":false,"message":"Not authorized to access this route"}
   ```
4. **This is correct!** Backend is working!

---

## 👤 Step 11: Create Admin Account

### Option A: Using Render Shell (Recommended)

1. In Render dashboard, click your service name
2. Click **"Shell"** tab (top right, next to "Logs")
3. Wait for shell to connect (may take 30 seconds)
4. Type: `npm run create-admin`
5. Press Enter
6. Wait for: **"Admin user created successfully"**

### Option B: If Shell Doesn't Work

You can create admin manually in MongoDB Compass or wait and do it later.

---

## 🔗 Step 12: Update Frontend with Backend URL

Now that backend is deployed, update your frontend:

```powershell
cd c:\Users\kotap\OneDrive\Desktop\IN\frontend

# Replace with your actual backend URL
netlify env:set REACT_APP_API_URL "https://your-backend-url.onrender.com"

# Redeploy frontend
netlify deploy --prod
```

---

## 🔄 Step 13: Update Backend with Frontend URL

After frontend is deployed:

1. Go back to Render dashboard
2. Click your backend service
3. Click **"Environment"** in left sidebar
4. Find `FRONTEND_URL`
5. Click the **Edit** icon (pencil)
6. Update to your Netlify URL: `https://your-site.netlify.app`
7. Click **"Save Changes"**
8. Service will auto-redeploy (2-3 minutes)

---

## 🎉 Step 14: Test Everything!

1. Open your Netlify URL
2. Login with:
   - **Email**: `admin@schedulo.com`
   - **Password**: `admin123`
3. Test features:
   - Dashboard loads ✅
   - Upload files ✅
   - Generate allocations ✅
   - Notifications work ✅

---

## 🐛 Troubleshooting

### Backend Won't Start
- Check Render logs for errors
- Verify all environment variables are set
- Check MongoDB Atlas IP whitelist (must include 0.0.0.0/0)

### MongoDB Connection Error
1. Go to MongoDB Atlas: https://cloud.mongodb.com/
2. Click **Network Access** (left sidebar)
3. Make sure `0.0.0.0/0` is in IP Access List
4. If not, click **"Add IP Address"** → **"Allow Access from Anywhere"**

### CORS Errors
- Make sure `FRONTEND_URL` matches your Netlify URL exactly
- Include `https://` in the URL
- No trailing slash

### Shell Not Working
- Try refreshing the page
- Wait 30-60 seconds for shell to connect
- If still doesn't work, create admin manually in MongoDB

---

## 📊 Important Notes

### Render Free Tier:
- ✅ 750 hours/month free
- ⚠️ Spins down after 15 minutes of inactivity
- ⚠️ First request after spin-down takes 30-60 seconds (cold start)
- ✅ Perfect for testing and small projects

### To Avoid Cold Starts:
- Upgrade to paid tier ($7/month) for persistent instance
- Or use a service like UptimeRobot to ping your backend every 10 minutes

---

## ✅ Deployment Checklist

- [ ] Render account created
- [ ] GitHub repository connected
- [ ] Service configured correctly
- [ ] All 9 environment variables added
- [ ] Service deployed successfully
- [ ] Backend URL copied
- [ ] Backend verified (visited /api/auth/me)
- [ ] Admin account created
- [ ] Frontend environment variable updated
- [ ] Frontend redeployed
- [ ] Backend FRONTEND_URL updated
- [ ] Login tested successfully

---

## 📞 Quick Links

- **Your Repository**: https://github.com/harshithachowdari/schedulo
- **Render Dashboard**: https://dashboard.render.com/
- **MongoDB Atlas**: https://cloud.mongodb.com/
- **Netlify Dashboard**: https://app.netlify.com/

---

## 🎯 Current Status

✅ Code pushed to GitHub
⏳ Ready to deploy on Render

**Next**: Go to https://dashboard.render.com/ and follow Step 2!

---

**Need help? Check the logs in Render dashboard or tell me what error you see!**
