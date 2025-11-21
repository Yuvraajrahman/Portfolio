# 🚀 Quick Start Guide

Get your portfolio running in under 5 minutes!

## ⚡ Fast Setup (Windows)

### Step 1: Open Terminal in Project Folder
1. Open folder in File Explorer: `C:\Users\yoyoy\Documents\Dev\Portfolio`
2. Type `cmd` in the address bar and press Enter

### Step 2: Run Development Server

**Option A - Using Batch File (Easiest):**
```bash
run_dev.bat
```

**Option B - Using Command:**
```bash
flutter run -d chrome
```

That's it! Your portfolio will open in Chrome browser! 🎉

---

## 📝 Quick Customization (3 Main Files)

### 1. Update Your Name & Contact
**File**: `lib/widgets/hero_section.dart` (line 73)
```dart
Text('Your Name Here'),
```

**File**: `lib/widgets/contact_section.dart` (line 22)
```dart
path: 'your.email@example.com',
```

### 2. Add Your Projects
**File**: `lib/models/project.dart`
```dart
Project(
  name: 'Project Name',
  description: 'Description',
  technologies: ['Tech1', 'Tech2'],
  category: 'Web Application',
  highlights: ['Feature 1', 'Feature 2'],
),
```

### 3. Update Your Skills
**File**: `lib/models/skill.dart`
```dart
Skill(
  name: 'Category Name',
  icon: '💻',
  items: ['Skill 1', 'Skill 2'],
),
```

---

## 🏗️ Build for Production

```bash
build_prod.bat
```

Or manually:
```bash
flutter build web --release
```

Output will be in: `build\web\`

---

## 🌐 Deploy (Choose One)

### Firebase (Free & Fast)
```bash
npm install -g firebase-tools
firebase login
firebase init hosting
firebase deploy
```

### Vercel (Automatic)
1. Go to [vercel.com](https://vercel.com)
2. Connect your GitHub repository
3. Deploy automatically

### Netlify (Drag & Drop)
1. Build: `flutter build web --release`
2. Go to [netlify.com](https://www.netlify.com)
3. Drag `build\web` folder

---

## 🎨 Color Scheme (Optional)

**File**: `lib/utils/constants.dart`

**Black & White (Current):**
```dart
static const Color background = Color(0xFF000000);
static const Color primary = Color(0xFFFFFFFF);
```

**Blue Theme:**
```dart
static const Color background = Color(0xFF0A1929);
static const Color primary = Color(0xFF66B2FF);
```

**Purple Theme:**
```dart
static const Color background = Color(0xFF1A0033);
static const Color primary = Color(0xFF9D4EDD);
```

---

## 🔧 Common Commands

| Command | Purpose |
|---------|---------|
| `flutter run -d chrome` | Start development server |
| `flutter build web --release` | Build for production |
| `flutter clean` | Clean build files |
| `flutter pub get` | Install dependencies |
| `flutter analyze` | Check for issues |

---

## 📱 Test Responsive Design

In Chrome DevTools (F12):
1. Click device toolbar icon (Ctrl+Shift+M)
2. Test on different screen sizes:
   - Mobile: 375px
   - Tablet: 768px
   - Desktop: 1920px

---

## 💡 Hot Reload

While app is running:
- Press `r` in terminal → Hot reload (fast, keeps state)
- Press `R` in terminal → Hot restart (full restart)
- Press `q` in terminal → Quit

---

## 📚 Full Documentation

- **Setup Details**: See `SETUP_GUIDE.md`
- **Customization**: See `CUSTOMIZATION_GUIDE.md`
- **Project Info**: See `README.md`

---

## ✅ Pre-Launch Checklist

- [ ] Updated name in hero section
- [ ] Updated email in contact section
- [ ] Updated phone number
- [ ] Added all your projects
- [ ] Updated skills list
- [ ] Updated about section
- [ ] Changed page title in `web/index.html`
- [ ] Tested on mobile view
- [ ] Built for production
- [ ] Deployed to hosting

---

## 🆘 Quick Fixes

**Problem**: Dependencies error
```bash
flutter clean
flutter pub get
```

**Problem**: Web not available
```bash
flutter config --enable-web
flutter devices
```

**Problem**: Port already in use
```bash
flutter run -d chrome --web-port=8080
```

---

## 🎯 Next Steps After Launch

1. ✅ Test on real devices
2. ✅ Share portfolio link
3. ✅ Add to resume/CV
4. ✅ Share on LinkedIn
5. ✅ Update regularly with new projects

---

**Need Help?** Check the detailed guides or Flutter docs at [flutter.dev](https://flutter.dev)

**Ready to launch? You got this! 🚀**

