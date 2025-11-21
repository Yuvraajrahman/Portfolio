# 🔧 How to Change Vercel Branch to Deploy

## Step-by-Step Instructions:

### Method 1: Via Project Settings (Recommended)

1. **Go to Vercel Dashboard**
   - Visit [vercel.com](https://vercel.com)
   - Log in to your account

2. **Select Your Project**
   - Click on your "portfolio" project

3. **Go to Settings**
   - Click on **"Settings"** tab (top navigation)

4. **Click on "Git"**
   - In the left sidebar, click **"Git"**

5. **Change Production Branch**
   - Find the section **"Production Branch"**
   - You'll see a dropdown that says `main`
   - Click the dropdown and select **`deploy`**
   - Click **"Save"** button

6. **Done!**
   - Vercel will now use the `deploy` branch for production deployments
   - It should automatically trigger a new deployment from the `deploy` branch

---

### Method 2: Via Project Configuration

If you can't find the Git settings:

1. Go to **Settings** → **General**
2. Look for **"Git Repository"** section
3. Click **"Edit"** or **"Configure"**
4. Find **"Production Branch"** option
5. Change from `main` to `deploy`
6. Save

---

### Method 3: Create New Project (If Settings Don't Work)

If the above methods don't work:

1. **Create New Project** in Vercel
2. **Import from GitHub** → Select your repository
3. **When configuring:**
   - **Branch:** Select `deploy` (not main!)
   - **Root Directory:** `.` (root)
   - **Build Command:** (empty)
   - **Output Directory:** (empty)
   - **Install Command:** (empty)
4. **Deploy**

Then delete the old project if needed.

---

## Verify It's Working:

After changing the branch:

1. Go to **Deployments** tab
2. Check the latest deployment
3. It should show:
   - **Source:** `deploy` branch (not main)
   - **Status:** Building/Ready

---

## Troubleshooting:

**Can't find Git settings?**
- Make sure you're the project owner/admin
- Try refreshing the page
- Check if you're in the correct project

**Still deploying from main?**
- Wait a few minutes for settings to sync
- Manually trigger a deployment from the `deploy` branch
- Check if there are multiple projects with the same name

**Need to manually trigger deployment?**
- Go to **Deployments** tab
- Click **"..."** (three dots) on any deployment
- Click **"Redeploy"**
- Make sure it's deploying from `deploy` branch

