# Nikhil Pareek's Portfolio

A modern, responsive portfolio website built with Flutter showcasing my journey as a Computer Science student, Flutter developer, and tech enthusiast.

🌐 **Live Demo**: [nikhilpareek.me](https://nikhilpareek.me)

## ✨ Features

### 🎯 Portfolio Sections
- **Hero Section**: Personal introduction with "Open for Work" status
- **Projects**: Showcase of Flutter applications with live demos
- **Experience**: Professional and project experience timeline
- **Tech Stack**: Visual display of technologies and tools
- **Education**: Academic background and achievements
- **Certifications**: Professional certifications and courses
- **Contact**: Social links and ways to connect

### 🚀 Technical Features
- **Responsive Design**: Optimized for desktop, tablet, and mobile
- **Dark Theme**: Modern dark UI with smooth animations
- **Interactive Elements**: Segmented controls, expandable sections
- **Performance Optimized**: Fast loading with optimized assets
- **SEO Friendly**: Proper meta tags and structure

## 🛠️ Tech Stack

### Frontend
- **Flutter** - UI framework for cross-platform development
- **Dart** - Programming language
- **Material Design** - Design system and components

### Dependencies
- **Google Fonts** - Typography
- **Font Awesome Flutter** - Icon library
- **URL Launcher** - External link handling
- **Cupertino Icons** - iOS-style icons

### Development Tools
- **Flutter Lints** - Code quality and style
- **Vercel** - Deployment platform
- **GitHub Pages** - Additional hosting

## 🏗️ Project Structure

```
lib/
├── main.dart                    # App entry point
├── theme/                       # Theme configuration
│   └── theme_provider.dart
├── ui/
│   ├── home_page.dart          # Main layout
│   ├── pages/                  # Additional pages
│   └── sections/               # Portfolio sections
│       ├── hero_section.dart
│       ├── projects_section.dart
│       ├── experience_section.dart
│       ├── tech_stack_section.dart
│       ├── education_section.dart
│       ├── certifications_section.dart
│       └── footer_section.dart
└── widgets/                    # Reusable components
    ├── custom_app_bar.dart
    └── project_card.dart

assets/
├── images/                     # Portfolio images and logos
├── animations/                 # Animation files
└── resume.pdf                  # Downloadable resume
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (>=3.8.1)
- Dart SDK
- VS Code or Android Studio (recommended)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/nikkhilpareek/folio.git
   cd folio
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   # For web (recommended)
   flutter run -d chrome

   # For mobile (if you have simulators/devices)
   flutter run
   ```

4. **Build for production**
   ```bash
   # Web build
   flutter build web --release

   # Android APK
   flutter build apk --release
   ```

## 🌐 Deployment

This portfolio is deployed using multiple platforms:

### Vercel (Primary)
- **URL**: [nikhilpareek.me](https://nikhilpareek.me)
- **Configuration**: `vercel.json`
- **Auto-deploy**: Connected to main branch

### GitHub Pages (Backup)
- **Build**: `docs/` folder contains web build
- **URL**: Available as GitHub Pages site

### Build Commands
```bash
# Build for web deployment
flutter build web --release

# Copy build to docs/ for GitHub Pages
cp -r build/web/* docs/
```

## 📱 Featured Projects

### 🚗 Ryder - Car Rental App
Modern car rental application with glassmorphic UI design.
- **Tech**: Flutter, Dart
- **Live Demo**: [View Project](https://nikkhilpareek.github.io/ryder/)

### 🔐 Authentication Screens
Beautiful and minimal authentication UI screens.
- **Tech**: Flutter, Material Design
- **Live Demo**: [View Project](https://nikkhilpareek.github.io/Minimal-Auth-Screens-in-Flutter/)

### 🧮 Flutter Calculator
Clean and functional calculator application.
- **Tech**: Flutter, Dart
- **Live Demo**: [View Project](https://nikkhilpareek.github.io/Calculator-in-Flutter/)

## 🎓 About Me

I'm **Nikhil Pareek**, a Computer Science & Engineering student at JK Lakshmipat University (2022-2026) with a passion for mobile app development, blockchain technology, and creating beautiful user experiences.

### 📊 Current Status
- 🎓 **Education**: B.Tech CSE | 8.1 CGPA
- 💼 **Status**: Open for Work & Collaborations
- 🌱 **Learning**: Advanced Flutter, Blockchain Development
- 💪 **Skills**: Flutter, Dart, Kotlin, C++, Solidity, NodeJS

## 📞 Connect With Me

- 🌐 **Portfolio**: [nikhilpareek.me](https://nikhilpareek.me)
- 💼 **LinkedIn**: [Connect with me](https://linkedin.com/in/nikkhilpareek)
- 🐱 **GitHub**: [@nikkhilpareek](https://github.com/nikkhilpareek)
- 📧 **Email**: [Contact me](mailto:your-email@example.com)

## 🤝 Contributing

This is a personal portfolio, but I'm open to suggestions and improvements!

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/improvement`)
3. Commit your changes (`git commit -am 'Add some improvement'`)
4. Push to the branch (`git push origin feature/improvement`)
5. Open a Pull Request

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

---

**Made with Flutter by Nikhil Pareek with a lot of caffeine ☕**

> "Building the future, one app at a time" 🚀
