# Customization Guide

This guide will help you customize the portfolio with your own information quickly and easily.

## 📝 Quick Customization Checklist

- [ ] Update personal information in Hero Section
- [ ] Update contact details
- [ ] Add/modify your projects
- [ ] Update your skills
- [ ] Customize the About section
- [ ] Change colors (optional)
- [ ] Update page title and meta tags

---

## 1. Personal Information (Hero Section)

**File**: `lib/widgets/hero_section.dart`

### Update your name (line ~73-77):

```dart
Text(
  'Your Name Here',  // Change this
  style: isMobile
      ? AppTextStyles.heroTitleMobile
      : AppTextStyles.heroTitle,
),
```

### Update role descriptions (line ~93-135):

```dart
AnimatedTextKit(
  repeatForever: true,
  animatedTexts: [
    TypewriterAnimatedText('Your Role 1'),
    TypewriterAnimatedText('Your Role 2'),
    TypewriterAnimatedText('Your Role 3'),
    // Add more roles as needed
  ],
),
```

### Update introduction text (line ~153-157):

```dart
Text(
  'Your introduction text here...',
  style: AppTextStyles.body.copyWith(
    fontSize: isMobile ? 14 : 16,
  ),
),
```

---

## 2. Contact Information

**File**: `lib/widgets/contact_section.dart`

### Update email (line ~19-25):

```dart
Future<void> _launchEmail() async {
  final Uri emailUri = Uri(
    scheme: 'mailto',
    path: 'your.email@example.com',  // Change this
    query: 'subject=Hello%20from%20Portfolio',
  );
  // ...
}
```

### Update phone (line ~31-37):

```dart
Future<void> _launchPhone() async {
  final Uri phoneUri = Uri(
    scheme: 'tel',
    path: '+1234567890',  // Change this
  );
  // ...
}
```

### Update displayed contact info (line ~122-137):

```dart
_buildContactCard(
  icon: Icons.email_outlined,
  title: 'Email',
  subtitle: 'your.email@example.com',  // Change this
  onTap: _launchEmail,
  isMobile: false,
),
// ...
_buildContactCard(
  icon: Icons.phone_outlined,
  title: 'Phone',
  subtitle: '+1234567890',  // Change this
  onTap: _launchPhone,
  isMobile: false,
),
```

### Update location (line ~158-164):

```dart
_buildContactCard(
  icon: Icons.location_on_outlined,
  title: 'Location',
  subtitle: 'Your City, Country',  // Change this
  onTap: null,
  isMobile: isMobile,
),
```

---

## 3. Projects

**File**: `lib/models/project.dart`

### Add/modify projects in `getAllProjects()` method:

```dart
Project(
  name: 'Your Project Name',
  description: 'Brief description of your project',
  technologies: ['Tech1', 'Tech2', 'Tech3'],
  category: 'Web Application',  // or 'Game Development', 'Full Stack'
  highlights: [
    'Key feature 1',
    'Key feature 2',
    'Key feature 3',
  ],
),
```

### Example template to copy:

```dart
Project(
  name: '',
  description: '',
  technologies: [],
  category: '',
  highlights: [
    '',
  ],
),
```

---

## 4. Skills

**File**: `lib/models/skill.dart`

### Add/modify skills in `getAllSkills()` method:

```dart
Skill(
  name: 'Skill Category Name',
  icon: '🔥',  // Use any emoji
  items: [
    'Skill 1',
    'Skill 2',
    'Skill 3',
  ],
),
```

### Available emoji icons you can use:
- 💻 (Computer)
- ⚙️ (Settings/Backend)
- 🔗 (Chain/Blockchain)
- 🎮 (Game Controller)
- 🚀 (Rocket/Deployment)
- 🗄️ (Database)
- 📝 (Writing/Code)
- 🌐 (Globe/Languages)
- 🎨 (Art/Design)
- 📱 (Mobile)
- 🔧 (Tools)

---

## 5. About Section

**File**: `lib/widgets/about_section.dart`

### Update introduction (line ~66-71):

```dart
Text(
  'Your personal introduction and background...',
  style: AppTextStyles.body.copyWith(
    fontSize: isMobile ? 14 : 16,
  ),
),
```

### Update experience points (line ~88-125):

```dart
_buildExperiencePoint(
  '🚀 Your Experience Area',
  'Description of your experience in this area',
  isMobile,
),
```

### Update education (line ~134-163):

```dart
Text(
  'Your Degree',  // Change this
  style: TextStyle(...),
),
// ...
Text(
  'Your University',  // Change this
  style: TextStyle(...),
),
// ...
Text(
  '20XX - 20XX',  // Change this
  style: TextStyle(...),
),
```

### Update current focus (line ~170-176):

```dart
Text(
  'Your current goals and what you\'re looking for...',
  style: AppTextStyles.body.copyWith(
    fontSize: isMobile ? 14 : 16,
  ),
),
```

---

## 6. Navigation Bar Logo

**File**: `lib/widgets/navigation_bar.dart`

### Update logo text (line ~60-68):

```dart
Text(
  'YourInitials',  // Change this (e.g., 'JD' for John Doe)
  style: TextStyle(
    fontSize: isMobile ? 24 : 28,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
    letterSpacing: 2,
  ),
),
```

---

## 7. Footer

**File**: `lib/widgets/footer.dart`

### Update logo (line ~29-37):

```dart
Text(
  'YourInitials',  // Change this
  style: TextStyle(
    fontSize: isMobile ? 24 : 28,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
    letterSpacing: 3,
  ),
),
```

### Update tagline (line ~43-51):

```dart
Text(
  'Your Tagline Here',  // Change this
  textAlign: TextAlign.center,
  style: TextStyle(...),
),
```

### Update copyright (line ~64-71):

```dart
Text(
  '© 2025 Your Name',  // Change this
  textAlign: TextAlign.center,
  style: TextStyle(...),
),
```

---

## 8. Page Title and Meta Tags

**File**: `web/index.html`

### Update page title (line ~9):

```html
<title>Your Name | Portfolio</title>
```

### Update meta tags (lines ~5-7):

```html
<meta name="description" content="Your Name - Your Title Portfolio">
<meta name="keywords" content="Your, Keywords, Here">
<meta name="author" content="Your Name">
```

---

## 9. Manifest File

**File**: `web/manifest.json`

### Update manifest details:

```json
{
  "name": "Your Name Portfolio",
  "short_name": "Portfolio",
  "description": "Your Title Portfolio",
  ...
}
```

---

## 10. Color Customization (Optional)

**File**: `lib/utils/constants.dart`

### To change from black & white to your colors:

```dart
class AppColors {
  static const Color background = Color(0xFF000000);  // Background color
  static const Color surface = Color(0xFF0A0A0A);     // Card backgrounds
  static const Color primary = Color(0xFFFFFFFF);     // Text color
  static const Color secondary = Color(0xFF808080);   // Secondary text
  static const Color accent = Color(0xFF1A1A1A);      // Accent elements
  static const Color cardBackground = Color(0xFF0F0F0F);
  static const Color borderColor = Color(0xFF2A2A2A);
}
```

### Color format:
- `0xFF` prefix is required
- Followed by 6 hex digits (RRGGBB)
- Example: `0xFF1E90FF` = Dodger Blue

### Suggested color schemes:

**Blue & White:**
```dart
static const Color background = Color(0xFF0A1929);
static const Color primary = Color(0xFFFFFFFF);
static const Color secondary = Color(0xFF66B2FF);
```

**Dark Purple:**
```dart
static const Color background = Color(0xFF1A0033);
static const Color primary = Color(0xFFE0E0E0);
static const Color secondary = Color(0xFF9D4EDD);
```

**Minimal Gray:**
```dart
static const Color background = Color(0xFF121212);
static const Color primary = Color(0xFFFFFFFF);
static const Color secondary = Color(0xFFB0B0B0);
```

---

## Testing Your Changes

After making changes:

1. **Save all files**
2. **Hot reload** (press `r` in terminal) or **Hot restart** (press `R`)
3. If changes don't appear, restart the development server:
   ```bash
   flutter run -d chrome
   ```

---

## Common Customization Tips

### Adding More Projects
1. Copy an existing `Project(...)` block in `lib/models/project.dart`
2. Update all fields with your project information
3. Save and reload

### Removing Sections
To remove a section (e.g., Skills section):
1. Open `lib/screens/home_screen.dart`
2. Comment out or delete the corresponding `SliverToBoxAdapter` block
3. Update navigation items in `lib/widgets/navigation_bar.dart`

### Changing Fonts
1. Open `lib/main.dart`
2. Change line ~18: `GoogleFonts.poppinsTextTheme` to another font
3. Available fonts: [Google Fonts](https://fonts.google.com/)
4. Example: `GoogleFonts.montserratTextTheme`, `GoogleFonts.robotoTextTheme`

### Adding Social Media Links
You can add social media icons in the contact section or footer by:
1. Using `url_launcher` package
2. Adding icon buttons with links to your profiles
3. Example code provided in `lib/widgets/contact_section.dart`

---

## Need Help?

If you need help with customization:
1. Check the Flutter documentation: [flutter.dev/docs](https://flutter.dev/docs)
2. Review the SETUP_GUIDE.md for troubleshooting
3. Each file has comments explaining its purpose

**Happy customizing! 🎨**

