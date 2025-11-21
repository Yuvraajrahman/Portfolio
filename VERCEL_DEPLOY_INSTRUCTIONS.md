# 🚀 Vercel Deployment - Step by Step

Since Vercel doesn't have Flutter installed, we'll build locally and deploy the built files.

## Quick Steps:

### 1. Build Your Flutter App Locally

```bash
flutter build web --release
```

### 2. Copy Built Files to Root

You have two options:

**Option A: Deploy from build/web folder (Recommended)**

1. In Vercel, change these settings:
   - **Root Directory:** `build/web`
   - **Build Command:** (leave empty or remove)
   - **Output Directory:** (leave empty)
   - **Install Command:** (leave empty)

2. Deploy!

**Option B: Create a deploy branch with built files**

1. Create a new branch:
   ```bash
   git checkout -b deploy
   ```

2. Copy build/web contents to root:
   ```bash
   # On Windows PowerShell:
   Copy-Item -Path "build\web\*" -Destination "." -Recurse -Force
   ```

3. Commit and push:
   ```bash
   git add .
   git commit -m "Deploy built files"
   git push origin deploy
   ```

4. In Vercel, select the `deploy` branch

---

## ⚡ Better Alternative: Use Netlify

Netlify is easier - just drag and drop!

1. Build: `flutter build web --release`
2. Go to netlify.com
3. Drag `build/web` folder
4. Done!

No build commands needed! 🎉

