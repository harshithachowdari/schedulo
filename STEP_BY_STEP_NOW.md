# 🚀 Deploy Backend - Follow These Steps NOW

## ✅ Step 1: Git Ready (DONE ✓)

Your code is committed and ready to push!

---

## 📝 Step 2: Create GitHub Repository

### Do This Now:

1. **Open this link in your browser**: https://github.com/new

2. **Fill in the form**:
   - **Repository name**: `schedulo` (or any name you like)
   - **Description**: `Invigilator Allocation System`
   - **Visibility**: Choose **Private** (recommended) or Public
   - **DO NOT** check "Add a README file"
   - **DO NOT** check "Add .gitignore"
   - **DO NOT** choose a license

3. **Click**: "Create repository" (green button at bottom)

4. **Copy your repository URL** - it will look like:
   ```
   https://github.com/YOUR_USERNAME/schedulo.git
   ```

---

## 📤 Step 3: Push Code to GitHub

After creating the repository, **come back here** and tell me your GitHub username, then I'll push the code for you.

Or run these commands yourself:

```powershell
# Replace YOUR_USERNAME with your actual GitHub username
git remote add origin https://github.com/YOUR_USERNAME/schedulo.git
git push -u origin main
```

**Note**: You may be asked to login. Use your GitHub username and **Personal Access Token** (not password).

### How to Create Personal Access Token (if needed):
1. Go to: https://github.com/settings/tokens
2. Click "Generate new token" → "Generate new token (classic)"
3. Give it a name: "Schedulo Deploy"
4. Select scopes: Check **repo** (all sub-options)
5. Click "Generate token"
6. **Copy the token** (you won't see it again!)
7. Use this token as password when pushing

---

## 🌐 Step 4: Deploy on Render

### Do This After Pushing to GitHub:

1. **Go to Render**: https://dashboard.render.com/

2. **Sign Up/Login**:
   - Click "Get Started" or "Sign In"
   - Choose "Sign in with GitHub" (easiest!)
   - Authorize Render to access your GitHub

3. **Create New Web Service**:
   - Click **"New +"** button (top right)
   - Select **"Web Service"**

4. **Connect Repository**:
   - You'll see your GitHub repositories
   - Find and click **"Connect"** next to your `schedulo` repository
   - If you don't see it, click "Configure account" to grant access

5. **Configure Service** (Fill in these fields):

   ```
   Name: schedulo-backend
   Region: Singapore (or closest to you)
   Branch: main
   Root Directory: backend
   Runtime: Node
   Build Command: npm install
   Start Command: npm start
   Instance Type: Free
   ```

6. **Scroll Down to Environment Variables**:
   - Click **"Advanced"** or scroll to "Environment" section
   - Click **"Add Environment Variable"** for each of these:

   **Copy these exactly:**

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
   | `FRONTEND_URL` | `http://localhost:3000` |

   **Note**: We'll update `FRONTEND_URL` later with your Netlify URL

7. **Create Web Service**:
   - Click the big **"Create Web Service"** button at bottom
   - Wait for deployment (5-10 minutes)
   - Watch the logs - look for "Your service is live 🎉"

8. **Copy Your Backend URL**:
   - At the top of the page, you'll see your URL
   - It looks like: `https://schedulo-backend-xxxx.onrender.com`
   - **SAVE THIS URL** - you need it!

---

## ✅ Step 5: Verify Backend is Working

1. **Open your backend URL in browser**: `https://your-backend-url.onrender.com/api/auth/me`

2. **You should see**:
   ```json
   {"success":false,"message":"Not authorized to access this route"}
   ```

3. **This is correct!** It means your backend is running!

---

## 👤 Step 6: Create Admin Account

### Option A: Using Render Shell (Easiest)

1. In Render dashboard, go to your service
2. Click **"Shell"** tab (top right, next to "Logs")
3. Wait for shell to load
4. Type: `npm run create-admin`
5. Press Enter
6. Wait for "Admin user created successfully"

### Option B: Using MongoDB Compass

If Shell doesn't work, you can create admin manually in MongoDB.

---

## 🔗 Step 7: Connect Frontend to Backend

Now that backend is deployed, update your frontend:

```powershell
cd c:\Users\kotap\OneDrive\Desktop\IN\frontend

# Set your backend URL (replace with your actual URL)
netlify env:set REACT_APP_API_URL "https://your-backend-url.onrender.com"

# Deploy frontend
netlify deploy --prod
```

---

## 🔄 Step 8: Update Backend with Frontend URL

After frontend is deployed:

1. Go to Render dashboard
2. Click your backend service
3. Go to **"Environment"** tab (left sidebar)
4. Find `FRONTEND_URL`
5. Click **Edit** (pencil icon)
6. Update to your Netlify URL: `https://your-site.netlify.app`
7. Click **Save**
8. Service will auto-redeploy (takes 2-3 minutes)

---

## 🎉 Step 9: Test Everything!

1. **Open your Netlify URL** in browser
2. **Login** with:
   - Email: `admin@schedulo.com`
   - Password: `admin123`
3. **Test features**:
   - Dashboard loads
   - Upload files
   - Generate allocations
   - Check notifications

---

## 🆘 If Something Goes Wrong

### MongoDB Connection Error
- Check MongoDB Atlas → Network Access → Make sure `0.0.0.0/0` is allowed
- Check Database Access → Verify user exists with correct password

### Backend Won't Start
- Check Render logs for errors
- Verify all environment variables are set correctly
- Make sure `backend` folder is set as Root Directory

### Can't Push to GitHub
- Create Personal Access Token (see Step 3)
- Use token as password when pushing
- Make sure repository exists on GitHub

### Frontend Can't Connect
- Verify backend URL is correct
- Check if backend is running (visit the URL)
- Check browser console for errors

---

## 📋 Quick Checklist

- [ ] GitHub repository created
- [ ] Code pushed to GitHub
- [ ] Render account created
- [ ] Backend deployed on Render
- [ ] All environment variables set
- [ ] Backend is running (verified)
- [ ] Backend URL copied
- [ ] Admin account created
- [ ] Frontend environment variable updated
- [ ] Frontend deployed
- [ ] Backend FRONTEND_URL updated
- [ ] Login tested successfully

---

## 🎯 Current Status

✅ Git initialized and code committed
⏳ Waiting for you to create GitHub repository

**Next**: Create GitHub repository at https://github.com/new

**Then**: Tell me your GitHub username and I'll help push the code!

---

## 📞 Important URLs

- **Create GitHub Repo**: https://github.com/new
- **Render Dashboard**: https://dashboard.render.com/
- **MongoDB Atlas**: https://cloud.mongodb.com/
- **GitHub Tokens**: https://github.com/settings/tokens

---

**Ready? Start with Step 2!** 🚀
