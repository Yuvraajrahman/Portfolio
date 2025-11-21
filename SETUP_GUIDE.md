# Setup Guide for Portfolio Website

## Quick Start Guide

This guide will help you get your Flutter portfolio website up and running in minutes.

## Step 1: Prerequisites

Make sure you have the following installed:

1. **Flutter SDK**: Download from [flutter.dev](https://flutter.dev/docs/get-started/install)
2. **Git**: Download from [git-scm.com](https://git-scm.com/)
3. **A Web Browser**: Chrome, Edge, or any modern browser

### Verify Flutter Installation

Open your terminal/command prompt and run:

```bash
flutter doctor
```

Make sure web support is enabled. If not, run:

```bash
flutter config --enable-web
```

## Step 2: Project Setup

### Clone or Navigate to Project

Navigate to your project directory:

```bash
cd C:\Users\yoyoy\Documents\Dev\Portfolio
```

### Install Dependencies

Run the following command to install all required packages:

```bash
flutter pub get
```

## Step 3: Run the Development Server

To run the website locally:

```bash
flutter run -d chrome
```

Or to run on any available web browser:

```bash
flutter run -d web-server
```

The website will open in your browser at `http://localhost:port`

## Step 4: Customization

### Update Your Information

1. **Personal Details**
   - Edit `lib/widgets/hero_section.dart` for your name and introduction
   - Edit `lib/widgets/contact_section.dart` for contact information

2. **Projects**
   - Edit `lib/models/project.dart` to add/modify your projects
   - Update project details, technologies, and highlights

3. **Skills**
   - Edit `lib/models/skill.dart` to customize your skills
   - Add/remove skill categories and items

4. **About Section**
   - Edit `lib/widgets/about_section.dart` for your bio and experience

### Change Colors

Edit `lib/utils/constants.dart` to customize the color scheme:

```dart
class AppColors {
  static const Color background = Color(0xFF000000); // Black background
  static const Color primary = Color(0xFFFFFFFF);    // White text
  // Modify these to change the color scheme
}
```

## Step 5: Building for Production

When you're ready to deploy:

### Build the Web App

```bash
flutter build web --release
```

This creates an optimized production build in the `build/web` directory.

## Step 6: Deployment Options

### Option 1: Firebase Hosting (Recommended)

1. Install Firebase CLI:
   ```bash
   npm install -g firebase-tools
   ```

2. Login to Firebase:
   ```bash
   firebase login
   ```

3. Initialize project:
   ```bash
   firebase init hosting
   ```
   - Choose your Firebase project
   - Set public directory to: `build/web`
   - Configure as single-page app: Yes
   - Don't overwrite index.html

4. Deploy:
   ```bash
   firebase deploy
   ```

### Option 2: Vercel

1. Install Vercel CLI:
   ```bash
   npm install -g vercel
   ```

2. Build and deploy:
   ```bash
   flutter build web --release
   cd build/web
   vercel
   ```

### Option 3: Netlify

1. Build the app:
   ```bash
   flutter build web --release
   ```

2. Go to [netlify.com](https://www.netlify.com/)
3. Drag and drop the `build/web` folder

### Option 4: GitHub Pages

1. Build the app:
   ```bash
   flutter build web --release --base-href "/repository-name/"
   ```

2. Copy contents of `build/web` to your GitHub Pages repository
3. Push to GitHub

## Step 7: Testing

### Test on Different Devices

- **Desktop**: Test in Chrome, Edge, Firefox, Safari
- **Mobile**: Test responsive design on various screen sizes
- **Tablet**: Test on iPad/Android tablets

### Use Flutter DevTools

```bash
flutter pub global activate devtools
flutter pub global run devtools
```

## Troubleshooting

### Common Issues

1. **Dependencies not installing**
   ```bash
   flutter clean
   flutter pub get
   ```

2. **Web not showing in devices**
   ```bash
   flutter config --enable-web
   flutter devices
   ```

3. **Build errors**
   ```bash
   flutter clean
   flutter pub get
   flutter build web --release
   ```

4. **Hot reload not working**
   - Restart the development server
   - Try `flutter run -d chrome --web-renderer html`

### Performance Tips

1. Use `--web-renderer html` for better compatibility
2. Use `--web-renderer canvaskit` for better graphics performance
3. Optimize images before adding them
4. Test on various browsers

## Additional Resources

- [Flutter Web Documentation](https://flutter.dev/web)
- [Flutter Deployment Guide](https://flutter.dev/docs/deployment/web)
- [Dart Documentation](https://dart.dev/guides)

## Support

If you encounter any issues:
1. Check Flutter version: `flutter --version`
2. Run Flutter doctor: `flutter doctor -v`
3. Check the [Flutter GitHub Issues](https://github.com/flutter/flutter/issues)

## Next Steps

1. ✅ Customize content with your information
2. ✅ Test on multiple browsers and devices
3. ✅ Optimize performance
4. ✅ Deploy to hosting service
5. ✅ Share your portfolio!

---

**Happy Coding! 🚀**

