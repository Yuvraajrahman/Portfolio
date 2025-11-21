# ✅ Main Branch Deployment Setup

## What We Did:

1. ✅ Built Flutter web app locally
2. ✅ Copied built files to main branch root
3. ✅ Updated vercel.json for static deployment
4. ✅ Committed and pushed to main branch

---

## Vercel Settings (Important!)

Now in your Vercel project settings, make sure:

### Settings → General:
- **Root Directory:** `.` (root) or leave empty
- **Build Command:** (EMPTY - delete everything)
- **Output Directory:** (EMPTY - delete everything)
- **Install Command:** (EMPTY - delete everything)

### Why?
- The files are already built
- Vercel doesn't have Flutter installed
- We just need to serve static files

---

## For Future Updates:

When you update your portfolio:

1. **Make changes** on main branch
2. **Build locally:**
   ```bash
   flutter build web --release
   ```
3. **Copy built files:**
   ```bash
   Copy-Item -Path "build\web\*" -Destination "." -Recurse -Force
   ```
4. **Commit and push:**
   ```bash
   git add .
   git commit -m "Update portfolio"
   git push origin main
   ```
5. **Vercel auto-deploys!** 🎉

---

## Quick Update Script:

Save this as `update_main.ps1`:

```powershell
# Build Flutter web app
flutter build web --release

# Copy built files to root
Copy-Item -Path "build\web\*" -Destination "." -Recurse -Force

# Commit and push
git add .
git commit -m "Update portfolio"
git push origin main
```

Then just run: `.\update_main.ps1`

---

## Your Portfolio Should Now Deploy!

Vercel will automatically deploy from the `main` branch whenever you push.

Check your Vercel dashboard - deployment should be in progress! 🚀

