# Push Schedulo to GitHub
# Run this script to prepare your code for Render deployment

Write-Host "🚀 Schedulo - Push to GitHub" -ForegroundColor Cyan
Write-Host "=============================" -ForegroundColor Cyan
Write-Host ""

# Check if Git is installed
Write-Host "📦 Checking Git installation..." -ForegroundColor Yellow
try {
    $gitVersion = git --version
    Write-Host "✅ Git is installed: $gitVersion" -ForegroundColor Green
} catch {
    Write-Host "❌ Git not found. Please install Git first:" -ForegroundColor Red
    Write-Host "   https://git-scm.com/download/win" -ForegroundColor White
    exit 1
}

Write-Host ""

# Check if already initialized
if (Test-Path ".git") {
    Write-Host "⚠️  Git repository already initialized" -ForegroundColor Yellow
    $reinit = Read-Host "Do you want to reinitialize? (Y/N)"
    if ($reinit -eq "Y" -or $reinit -eq "y") {
        Remove-Item -Recurse -Force .git
        Write-Host "✅ Removed existing Git repository" -ForegroundColor Green
    } else {
        Write-Host "📝 Using existing Git repository" -ForegroundColor Cyan
    }
}

# Initialize Git if needed
if (-not (Test-Path ".git")) {
    Write-Host "📝 Initializing Git repository..." -ForegroundColor Yellow
    git init
    Write-Host "✅ Git initialized" -ForegroundColor Green
}

Write-Host ""

# Add all files
Write-Host "📁 Adding files to Git..." -ForegroundColor Yellow
git add .
Write-Host "✅ Files added" -ForegroundColor Green

Write-Host ""

# Commit
Write-Host "💾 Creating commit..." -ForegroundColor Yellow
git commit -m "Initial commit - Ready for deployment"
if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ Commit created" -ForegroundColor Green
} else {
    Write-Host "⚠️  Commit may have failed or no changes to commit" -ForegroundColor Yellow
}

Write-Host ""

# Set main branch
Write-Host "🌿 Setting main branch..." -ForegroundColor Yellow
git branch -M main
Write-Host "✅ Main branch set" -ForegroundColor Green

Write-Host ""
Write-Host "📋 Next Steps:" -ForegroundColor Cyan
Write-Host ""
Write-Host "1. Create a GitHub repository:" -ForegroundColor White
Write-Host "   - Go to: https://github.com/new" -ForegroundColor Yellow
Write-Host "   - Repository name: schedulo" -ForegroundColor White
Write-Host "   - Keep it Private (recommended)" -ForegroundColor White
Write-Host "   - Don't initialize with README" -ForegroundColor White
Write-Host "   - Click 'Create repository'" -ForegroundColor White
Write-Host ""
Write-Host "2. After creating the repository, run these commands:" -ForegroundColor White
Write-Host ""
Write-Host "   git remote add origin https://github.com/YOUR_USERNAME/schedulo.git" -ForegroundColor Yellow
Write-Host "   git push -u origin main" -ForegroundColor Yellow
Write-Host ""
Write-Host "   (Replace YOUR_USERNAME with your actual GitHub username)" -ForegroundColor Gray
Write-Host ""

# Ask if user wants to add remote now
Write-Host "Do you want to add the remote repository now? (Y/N)" -ForegroundColor Cyan
$addRemote = Read-Host

if ($addRemote -eq "Y" -or $addRemote -eq "y") {
    Write-Host ""
    $username = Read-Host "Enter your GitHub username"
    $repoName = Read-Host "Enter repository name (default: schedulo)"
    
    if ([string]::IsNullOrWhiteSpace($repoName)) {
        $repoName = "schedulo"
    }
    
    $remoteUrl = "https://github.com/$username/$repoName.git"
    
    Write-Host ""
    Write-Host "📡 Adding remote: $remoteUrl" -ForegroundColor Yellow
    
    git remote add origin $remoteUrl
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ Remote added successfully" -ForegroundColor Green
        Write-Host ""
        Write-Host "🚀 Ready to push! Run:" -ForegroundColor Cyan
        Write-Host "   git push -u origin main" -ForegroundColor Yellow
        Write-Host ""
        
        $pushNow = Read-Host "Do you want to push now? (Y/N)"
        if ($pushNow -eq "Y" -or $pushNow -eq "y") {
            Write-Host ""
            Write-Host "📤 Pushing to GitHub..." -ForegroundColor Yellow
            git push -u origin main
            
            if ($LASTEXITCODE -eq 0) {
                Write-Host ""
                Write-Host "✅ Successfully pushed to GitHub!" -ForegroundColor Green
                Write-Host ""
                Write-Host "🎉 Next: Deploy on Render" -ForegroundColor Cyan
                Write-Host "   1. Go to: https://dashboard.render.com/" -ForegroundColor White
                Write-Host "   2. Click 'New +' → 'Web Service'" -ForegroundColor White
                Write-Host "   3. Connect your GitHub repository" -ForegroundColor White
                Write-Host "   4. Follow instructions in DEPLOY_BACKEND_NOW.md" -ForegroundColor White
                Write-Host ""
            } else {
                Write-Host ""
                Write-Host "❌ Push failed. You may need to:" -ForegroundColor Red
                Write-Host "   1. Create the repository on GitHub first" -ForegroundColor White
                Write-Host "   2. Login to GitHub (use Personal Access Token)" -ForegroundColor White
                Write-Host "   3. Try again: git push -u origin main" -ForegroundColor Yellow
            }
        }
    } else {
        Write-Host "⚠️  Failed to add remote. It may already exist." -ForegroundColor Yellow
        Write-Host "   Try: git remote remove origin" -ForegroundColor White
        Write-Host "   Then run this script again" -ForegroundColor White
    }
}

Write-Host ""
Write-Host "Done! 🎉" -ForegroundColor Green
