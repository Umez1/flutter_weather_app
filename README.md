# 🌦️ Flutter Weather App

A modern Flutter weather app that displays real-time weather conditions using the **OpenWeatherMap API**.  
The app supports **light and dark themes**, **animated weather visuals (Lottie)**, and **dynamic background images** based on weather conditions and theme mode.

---

## 🚀 Features

✅ Real-time weather data for any city  
✅ Light and dark mode toggle  
✅ Dynamic background images  
✅ Animated weather visuals (sunny, rainy, cloudy, thunder)  
✅ Error handling for invalid cities  
✅ Clean, responsive UI built with Flutter

---

## 🧠 Tech Stack

- **Flutter** (Frontend Framework)  
- **Dart** (Programming Language)  
- **OpenWeatherMap API** (Weather Data)  
- **Lottie Animations** (Weather Animations)  
- **Provider / setState** for state management  

---

## ⚙️ Setup Instructions

1. **Clone the repository**
   ```bash
   git clone https://github.com/Umez1/weather_app.git
   cd weather_app
2. **Install dependencies**
   ```bash
   flutter pub get
3. **Add your OpenWeatherMap API key**
   Open lib/services/weather_service.dart
   Replace "YOUR_API_KEY" with your actual key.
4. **Run the app**
   ```bash
   flutter run

---

## ⚙️ API Configuration

1. Go to [OpenWeatherMap.org](https://openweathermap.org/api)
2. Create a free account.
3. Get your **API key** from your dashboard.
4. Open `lib/services/weather_service.dart`
5. Replace the placeholder with your key:
   ```dart
   final String apiKey = "YOUR_API_KEY"; // Replace with your real API key

---

## 📁 Folder Structure
   weather_app/
│
├── lib/
│   ├── main.dart
│   ├── screens/
│   │   └── weather_screen.dart
│   ├── services/
│   │   └── weather_service.dart
│   ├── providers/
│   │   └── theme_provider.dart
│   └── widgets/
│       └── weather_widget.dart
│
├── assets/
│   ├── animations/
│   │   ├── sunny.json
│   │   ├── rain.json
│   │   ├── cloudy.json
│   │   └── thunder.json
│   └── images/
│       ├── light_bg.png
│       └── dark_bg.png
│
├── pubspec.yaml
└── README.md

## 👤 Author

**Developed by:** [Umez](https://github.com/Umez1)  
📧 **Email:** [umezikeogu@gmail.com](mailto:umezikeogu@gmail.com)  
💻 **GitHub:** [Umez1](https://github.com/Umez1)
