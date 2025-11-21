# 🔧 Alternative Ways to Set Deploy Branch

Since you can't find the Production Branch option, here are alternative solutions:

## Method 1: Use Vercel CLI (Recommended)

Install Vercel CLI and configure it:

```bash
# Install Vercel CLI
npm install -g vercel

# Login to Vercel
vercel login

# Link your project
vercel link

# Set production branch
vercel env pull
```

Or use the project settings via CLI.

---

## Method 2: Create New Project (Easiest)

Since the branch setting is hard to find, create a fresh project:

1. **Go to Vercel Dashboard**
2. **Click "Add New..." → "Project"**
3. **Import from GitHub** → Select your repository
4. **When configuring, BEFORE clicking Deploy:**
   - Look for branch selector
   - Select `deploy` branch (not main!)
   - Set Root Directory: `.`
   - Clear all build commands
5. **Deploy**

Then delete the old project.

---

## Method 3: Configure via vercel.json

We can try to force it via configuration file.

---

## Method 4: Manual Deployment

Just manually deploy from the deploy branch each time:

1. Go to **Deployments** tab
2. Click **"Create Deployment"**
3. Select **`deploy`** branch
4. Deploy

---

## Method 5: Check Project Settings → General

Sometimes it's hidden. Try:
1. Settings → General
2. Scroll ALL the way down
3. Look for "Git" or "Repository" section
4. There might be a "Production Branch" dropdown there

