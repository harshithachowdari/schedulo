# 🚀 CLI Deployment Steps

## Quick Start

I've created an automated deployment script for you!

### Deploy Frontend to Netlify

Simply run:
```powershell
.\deploy-frontend.ps1
```

This script will:
1. ✅ Check if Netlify CLI is installed
2. ✅ Install dependencies if needed
3. ✅ Build your React application
4. ✅ Login to Netlify
5. ✅ Deploy to production

---

## Manual Steps (If you prefer)

### 1. Install Netlify CLI (if not already done)

```powershell
npm install -g netlify-cli
```

Wait for installation to complete (may take 2-3 minutes).

### 2. Build the Frontend

```powershell
cd frontend
npm install
npm run build
```

### 3. Login to Netlify

```powershell
netlify login
```

This will open a browser window. Authorize the CLI.

### 4. Deploy to Netlify

```powershell
netlify deploy --prod
```

When prompted:
- **Create & configure a new site?** → Yes
- **Team:** → Select your team
- **Site name:** → `schedulo-invigilator` (or your choice)
- **Publish directory:** → `build`

### 5. Set Environment Variable

After deployment, set the backend URL:

```powershell
netlify env:set REACT_APP_API_URL "https://your-backend-name.onrender.com"
```

Replace with your actual Render backend URL.

### 6. Redeploy with Environment Variable

```powershell
netlify deploy --prod
```

---

## Deploy Backend to Render

Since Render doesn't have a CLI deployment option as simple as Netlify, use the web interface:

### Option A: Via GitHub (Recommended)

1. **Push to GitHub**:
   ```powershell
   cd c:\Users\kotap\OneDrive\Desktop\IN
   git init
   git add .
   git commit -m "Ready for deployment"
   git branch -M main
   git remote add origin https://github.com/YOUR_USERNAME/schedulo.git
   git push -u origin main
   ```

2. **Deploy on Render**:
   - Go to https://dashboard.render.com/
   - Click **New +** → **Web Service**
   - Connect your GitHub repo
   - **Root Directory**: `backend`
   - **Build Command**: `npm install`
   - **Start Command**: `npm start`
   - Add environment variables (see below)

### Option B: Via Render CLI (Advanced)

Install Render CLI:
```powershell
npm install -g @render/cli
```

Then:
```powershell
cd backend
render login
render deploy
```

---

## Environment Variables

### For Render (Backend)

Set these in Render dashboard or via CLI:

```
NODE_ENV=production
MONGODB_URI=mongodb+srv://username:password@cluster.mongodb.net/schedulo?retryWrites=true&w=majority
JWT_SECRET=your_random_secret_minimum_32_characters_long
JWT_EXPIRE=7d
EMAIL_HOST=smtp.gmail.com
EMAIL_PORT=587
EMAIL_USER=your_email@gmail.com
EMAIL_PASS=your_gmail_app_password
FRONTEND_URL=https://your-site.netlify.app
```

### For Netlify (Frontend)

```powershell
netlify env:set REACT_APP_API_URL "https://your-backend.onrender.com"
```

---

## 🔗 Deployment Order

**IMPORTANT**: Follow this order!

1. ✅ **First**: Set up MongoDB Atlas (get connection string)
2. ✅ **Second**: Deploy Backend to Render (get backend URL)
3. ✅ **Third**: Deploy Frontend to Netlify (use backend URL)
4. ✅ **Fourth**: Update Backend FRONTEND_URL with Netlify URL

---

## 🧪 Testing

After deployment:

1. Open your Netlify URL
2. Login with:
   - Email: `admin@schedulo.com`
   - Password: `admin123`
3. Test all features

---

## 📝 Useful Commands

### Netlify CLI Commands

```powershell
# Check status
netlify status

# View site info
netlify sites:list

# Open site in browser
netlify open

# View logs
netlify logs

# Set environment variable
netlify env:set KEY "value"

# List environment variables
netlify env:list

# Link to existing site
netlify link
```

### Check Deployment Status

```powershell
# Frontend
netlify status

# Backend (check Render dashboard)
# https://dashboard.render.com/
```

---

## ⚠️ Troubleshooting

### Netlify CLI not found after installation

Close and reopen PowerShell, or run:
```powershell
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
```

### Build fails

```powershell
cd frontend
npm install
npm run build
# Check for errors
```

### Deployment fails

- Check if build directory exists: `frontend/build`
- Verify netlify.toml is in frontend folder
- Check Netlify logs: `netlify logs`

### Can't connect to backend

- Verify backend is running on Render
- Check REACT_APP_API_URL is set correctly
- Check browser console for CORS errors
- Verify FRONTEND_URL is set in Render

---

## 🎉 Success Checklist

- [ ] Netlify CLI installed
- [ ] Frontend built successfully
- [ ] Deployed to Netlify
- [ ] Environment variable set
- [ ] Backend deployed to Render
- [ ] Backend environment variables set
- [ ] Frontend URL updated in backend
- [ ] Can login to application
- [ ] All features working

---

## 📞 Quick Links

- **Netlify Dashboard**: https://app.netlify.com/
- **Render Dashboard**: https://dashboard.render.com/
- **MongoDB Atlas**: https://cloud.mongodb.com/

---

Need help? Check **DEPLOYMENT_GUIDE.md** for detailed instructions!
