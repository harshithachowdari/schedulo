# Schedulo Frontend Deployment Script for Netlify
# Run this script to deploy your frontend to Netlify

Write-Host "🚀 Schedulo Frontend Deployment to Netlify" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""

# Check if Netlify CLI is installed
Write-Host "📦 Checking Netlify CLI..." -ForegroundColor Yellow
try {
    $netlifyVersion = netlify --version 2>&1
    Write-Host "✅ Netlify CLI is installed: $netlifyVersion" -ForegroundColor Green
} catch {
    Write-Host "❌ Netlify CLI not found. Installing..." -ForegroundColor Red
    npm install -g netlify-cli
    Write-Host "✅ Netlify CLI installed successfully!" -ForegroundColor Green
}

Write-Host ""

# Navigate to frontend directory
Write-Host "📁 Navigating to frontend directory..." -ForegroundColor Yellow
Set-Location -Path "frontend"

# Check if node_modules exists
if (-not (Test-Path "node_modules")) {
    Write-Host "📦 Installing dependencies..." -ForegroundColor Yellow
    npm install
    Write-Host "✅ Dependencies installed!" -ForegroundColor Green
} else {
    Write-Host "✅ Dependencies already installed" -ForegroundColor Green
}

Write-Host ""

# Build the application
Write-Host "🔨 Building the application..." -ForegroundColor Yellow
npm run build

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ Build completed successfully!" -ForegroundColor Green
} else {
    Write-Host "❌ Build failed! Please check the errors above." -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "🌐 Ready to deploy to Netlify!" -ForegroundColor Cyan
Write-Host ""
Write-Host "⚠️  IMPORTANT: Before deploying, make sure you have:" -ForegroundColor Yellow
Write-Host "   1. Your backend deployed to Render (get the URL)" -ForegroundColor White
Write-Host "   2. The backend URL ready to set as environment variable" -ForegroundColor White
Write-Host ""

# Ask if user wants to continue
$continue = Read-Host "Do you want to continue with deployment? (Y/N)"

if ($continue -eq "Y" -or $continue -eq "y") {
    Write-Host ""
    Write-Host "🔐 Logging into Netlify..." -ForegroundColor Yellow
    Write-Host "   (This will open a browser window for authentication)" -ForegroundColor White
    netlify login
    
    Write-Host ""
    Write-Host "🚀 Deploying to Netlify..." -ForegroundColor Yellow
    Write-Host ""
    Write-Host "📝 When prompted:" -ForegroundColor Cyan
    Write-Host "   - Create & configure a new site: Yes" -ForegroundColor White
    Write-Host "   - Team: Select your team" -ForegroundColor White
    Write-Host "   - Site name: schedulo-invigilator (or your choice)" -ForegroundColor White
    Write-Host "   - Publish directory: build" -ForegroundColor White
    Write-Host ""
    
    netlify deploy --prod
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host ""
        Write-Host "✅ Deployment successful!" -ForegroundColor Green
        Write-Host ""
        Write-Host "📋 Next Steps:" -ForegroundColor Cyan
        Write-Host "   1. Copy your site URL from above" -ForegroundColor White
        Write-Host "   2. Set environment variable:" -ForegroundColor White
        Write-Host "      netlify env:set REACT_APP_API_URL 'https://your-backend.onrender.com'" -ForegroundColor Yellow
        Write-Host "   3. Update your Render backend FRONTEND_URL with this Netlify URL" -ForegroundColor White
        Write-Host ""
    } else {
        Write-Host "❌ Deployment failed! Please check the errors above." -ForegroundColor Red
    }
} else {
    Write-Host ""
    Write-Host "⏸️  Deployment cancelled. Run this script again when ready!" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "Done! 🎉" -ForegroundColor Green

# Return to root directory
Set-Location -Path ".."
