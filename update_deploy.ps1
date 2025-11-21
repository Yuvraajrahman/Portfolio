# PowerShell script to update deploy branch
# Usage: .\update_deploy.ps1

Write-Host "🔄 Updating deploy branch..." -ForegroundColor Cyan

# Switch to deploy branch
Write-Host "📦 Switching to deploy branch..." -ForegroundColor Yellow
git checkout deploy

# Merge main into deploy
Write-Host "🔀 Merging main into deploy..." -ForegroundColor Yellow
git merge main

# Build Flutter web app
Write-Host "🏗️  Building Flutter web app..." -ForegroundColor Yellow
flutter build web --release

# Copy built files to root
Write-Host "📋 Copying built files..." -ForegroundColor Yellow
Copy-Item -Path "build\web\*" -Destination "." -Recurse -Force

# Stage and commit
Write-Host "💾 Committing changes..." -ForegroundColor Yellow
git add index.html main.dart.js flutter.js flutter_bootstrap.js flutter_service_worker.js manifest.json version.json assets/ canvaskit/ package.json vercel.json
git commit -m "Deploy: Updated portfolio"

# Push to GitHub
Write-Host "🚀 Pushing to GitHub..." -ForegroundColor Yellow
git push origin deploy

Write-Host "✅ Done! Vercel will auto-deploy." -ForegroundColor Green

