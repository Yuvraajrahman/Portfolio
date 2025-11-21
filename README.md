# Bokhtiar Rahman Juboraz - Portfolio

A modern, professional portfolio website built with Flutter, showcasing projects, skills, and experience as a Full Stack Developer.

## ✨ Features

- 🎨 **Modern & Minimalistic Design** - Clean black and white color scheme
- 🌟 **Beautiful Animations** - Smooth transitions and engaging animations throughout
- 📱 **Fully Responsive** - Works perfectly on desktop, tablet, and mobile devices
- 🚀 **Fast Performance** - Optimized for web with Flutter
- 🎯 **Project Showcase** - Highlighting key projects with filtering capabilities
- 💡 **Skills Display** - Comprehensive skills section with categorization
- 📧 **Contact Integration** - Direct email and phone contact options

## 🛠️ Tech Stack

- **Framework**: Flutter (Web)
- **Language**: Dart
- **Fonts**: Google Fonts (Poppins)
- **Icons**: Font Awesome Flutter
- **Animations**: AnimatedTextKit, Custom Flutter Animations
- **URL Launcher**: For email and phone functionality

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (>=3.0.0)
- Dart SDK (>=3.0.0)
- A web browser (Chrome recommended for development)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/portfolio.git
   cd portfolio
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the development server**
   ```bash
   flutter run -d chrome
   ```
   Or for other browsers:
   ```bash
   flutter run -d edge
   flutter run -d web-server
   ```

### Building for Production

1. **Build the web app**
   ```bash
   flutter build web --release
   ```

2. **The build output will be in the `build/web` directory**

3. **Deploy to your hosting service** (Firebase Hosting, Vercel, Netlify, etc.)

## 📂 Project Structure

```
portfolio/
├── lib/
│   ├── main.dart                 # App entry point
│   ├── models/                   # Data models
│   │   ├── project.dart
│   │   └── skill.dart
│   ├── screens/                  # Main screens
│   │   └── home_screen.dart
│   ├── utils/                    # Utilities and constants
│   │   └── constants.dart
│   └── widgets/                  # Reusable widgets
│       ├── navigation_bar.dart
│       ├── hero_section.dart
│       ├── projects_section.dart
│       ├── skills_section.dart
│       ├── about_section.dart
│       ├── contact_section.dart
│       └── footer.dart
├── web/                          # Web-specific files
│   ├── index.html
│   └── manifest.json
├── pubspec.yaml                  # Dependencies
└── README.md
```

## 🎨 Customization

### Updating Personal Information

Edit the following files to update your personal information:

1. **Contact Information** - `lib/widgets/contact_section.dart`
2. **Projects** - `lib/models/project.dart`
3. **Skills** - `lib/models/skill.dart`
4. **About Section** - `lib/widgets/about_section.dart`

### Changing Colors

Update the color scheme in `lib/utils/constants.dart`:

```dart
class AppColors {
  static const Color background = Color(0xFF000000);
  static const Color primary = Color(0xFFFFFFFF);
  // ... other colors
}
```

## 📱 Sections

### 1. Hero Section
- Animated name and title
- Typewriter effect for role descriptions
- Call-to-action button
- Smooth scroll indicator

### 2. Projects Section
- Filterable project cards
- Category-based filtering
- Hover effects and animations
- Technology tags
- Project highlights

### 3. Skills Section
- Categorized skills display
- Icon-based representation
- Interactive hover effects
- Responsive grid layout

### 4. About Section
- Personal introduction
- Experience highlights
- Education information
- Current focus and goals

### 5. Contact Section
- Email integration
- Phone contact
- Location information
- Call-to-action button

## 🌐 Deployment

### Deploy to Firebase Hosting

```bash
# Install Firebase CLI
npm install -g firebase-tools

# Login to Firebase
firebase login

# Initialize Firebase
firebase init hosting

# Build and deploy
flutter build web --release
firebase deploy
```

### Deploy to Vercel

```bash
# Install Vercel CLI
npm install -g vercel

# Build the app
flutter build web --release

# Deploy
cd build/web
vercel
```

### Deploy to Netlify

1. Build the app: `flutter build web --release`
2. Drag and drop the `build/web` folder to Netlify
3. Or use Netlify CLI for automated deployment

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

## 👤 Author

**Bokhtiar Rahman Juboraz**
- Email: bokhtiar.rahman.juboraz@g.bracu.ac.bd
- Phone: +880 1957631102
- Location: Badda, Dhaka, Bangladesh

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Google Fonts for beautiful typography
- Font Awesome for comprehensive icon library

---

**Note**: This portfolio is designed to showcase full-stack development skills with emphasis on Flutter, MERN stack, and Blockchain development. Feel free to customize it according to your needs!
