# 📰 AI Buzz News App

A Flutter-based **News Application** that provides real-time news articles from a public News API, with **login, bookmarking, and persistent storage** features.  
This project demonstrates clean architecture principles (Data, Domain, Presentation layers) with **BLoC state management** and **Hive local storage**.

---

## ✨ Features

### 1. 🔑 Login Page
- Email & password input fields with validation  
- Toggle password visibility (eye icon)  
- Hive-based session persistence (no backend auth, demo only)  
- Users stay logged in until they log out / clear app data  

### 2. 📰 News Feed Page
- Fetches news from [NewsAPI](https://newsapi.org/)  
- Displays:
  - Thumbnail image  
  - Title  
  - Description  
  - Source name  
  - Published date (formatted as `16 April, 2025`)  
- Tap article → open in **WebView** with full content  
- Bookmark button to save article locally  

### 3. 🔖 Bookmarks Page
- Displays saved articles (stored via Hive)  
- Articles persist even when app is closed  
- Option to delete bookmarks  

### 4. 🌐 Wikipedia Tab (Bonus)
- Extra bottom navigation item for **Wikipedia**, embedded in a WebView  

### 5. ⚙️ Optional Extras
- Pull-to-refresh on lists  
- Dark mode support (via system theme)  
- Clean navigation with **BottomNavigationBar**  

---

## 📸 Screenshots

| Login | News Feed | Article Detail | Bookmarks |
|-------|-----------|----------------|-----------|
| ![](assets/screenshots/login.png) | ![](assets/screenshots/news_feed.png) | ![](assets/screenshots/detail.png) | ![](assets/screenshots/bookmarks.png) |

| Wikipedia Tab | Dark Mode |
|---------------|-----------|
| ![](assets/screenshots/wikipedia.png) | ![](assets/screenshots/dark_mode.png) |

---

## 🏛 Architecture Choices

The app follows **Clean Architecture** principles with **separation of concerns**:

### 1. **Domain Layer**
- `entities/` → Plain Dart objects (`ArticleEntity`)  
- `repository/` → Abstract contracts (`ArticleRepository`)  

### 2. **Data Layer**
- `remote/` → API services & models (`NewsRepository`, `categories_news_model.dart`)  
- `local/` → Hive persistence (`ArticleHiveModel`, `ArticleLocalDataSource`)  
- `repository_impl/` → Implements domain repositories by combining remote & local sources  

### 3. **Presentation Layer**
- **UI**: Flutter widgets with responsive layouts, Google Fonts for typography  
- **State Management**: [`flutter_bloc`](https://pub.dev/packages/flutter_bloc) for predictable state handling  
- **Screens**:
  - `LoginPage`
  - `NewsFeedPage`
  - `CategoriesScreen`
  - `SavedScreen`
  - `NewsDetailScreen`
  - `ArticleWebViewScreen`
  - `WikipediaScreen`  

### Why BLoC?
- Predictable state transitions  
- Testability & scalability  
- Widely used in industry for production Flutter apps  

### Why Hive?
- Lightweight, blazing fast NoSQL DB for Flutter  
- Great for persisting session data and bookmarks  
- Strong community support  

---

## 📦 Third-Party Packages Used

| Package | Purpose | Why chosen |
|---------|---------|------------|
| **[http](https://pub.dev/packages/http)** | API calls to News API | Simple & reliable for REST requests |
| **[flutter_bloc](https://pub.dev/packages/flutter_bloc)** | State management | Industry-standard for structured state handling |
| **[equatable](https://pub.dev/packages/equatable)** | Value comparison in BLoC | Cleaner equality checks |
| **[hive](https://pub.dev/packages/hive)** + **[hive_flutter](https://pub.dev/packages/hive_flutter)** | Local database | Fast, lightweight, and persistent storage |
| **[path_provider](https://pub.dev/packages/path_provider)** | File storage path for Hive | Required for Hive init |
| **[cached_network_image](https://pub.dev/packages/cached_network_image)** | Efficient image loading & caching | Handles image caching gracefully |
| **[intl](https://pub.dev/packages/intl)** | Date formatting | Used for converting ISO strings → `16 April, 2025` |
| **[google_fonts](https://pub.dev/packages/google_fonts)** | Custom typography | Consistent & modern text styling |
| **[flutter_spinkit](https://pub.dev/packages/flutter_spinkit)** | Loading animations | Smooth UI for async calls |
| **[webview_flutter](https://pub.dev/packages/webview_flutter)** | In-app web browsing | For full-article display & Wikipedia integration |

---

## ⚙️ Setup Instructions

```bash
git clone https://github.com/Tushar3529-dev/AiBuzz-NewsApplication.git
cd AiBuzz-NewsApplication

Step 2: flutter pub get

Step 3: Add API Key

Get a free API key from NewsAPI.org
.
Replace the API key in news_repository.dart:

Step 4: Run the app
flutter run
Step 5: Build release APK:
flutter build apk --release

Step 6: build/app/outputs/flutter-apk/app-release.apk


```
## 📂 Project Structure
lib/
│── data/
│   ├── local/
│   │   ├── data source/
│   │   ├── model/
│   │   └── repository/
│   ├── remote/
│   │   └── model/
│   └── repository/
│
│── domain/
│   ├── entities/
│   └── repository/
│
│── presentation/
│   ├── features/
│   │   ├── auth/
│   │   ├── news/
│   │   ├── bookmarks/
│   │   ├── category/
│   │   ├── web/
│   │   └── details/
│   └── widgets/
│
│── main.dart




## 👉 Download the APK from:
Google Drive Link Here : https://drive.google.com/drive/folders/1rwPu9_2zmYERj_oYdyubc32FWB4FmWNx?usp=drive_link

👨‍💻 Author
Tushar Yadav
GitHub: https://github.com/Tushar3529-dev








